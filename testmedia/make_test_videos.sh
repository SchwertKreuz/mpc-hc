#!/bin/bash
# Generates test videos for checking the status bar FPS / timecode display.
# Local helper only (lives on the local/my-build branch, never in upstream PRs).
#
# Usage:  ./testmedia/make_test_videos.sh
#         FFMPEG=/path/to/ffmpeg ./testmedia/make_test_videos.sh
#
# Each video shows its frame number and the expected timecode burned into the picture
# when ffmpeg has the drawtext filter. Homebrew's "ffmpeg" formula does not include it;
# "brew install ffmpeg-full" does (keg-only, picked up automatically below).
# Without drawtext, the testsrc pattern is used instead: its counter shows the time
# in milliseconds (e.g. 60060 = 60.060 s).

set -euo pipefail
cd "$(dirname "$0")"

if [[ -z "${FFMPEG:-}" ]]; then
    FFMPEG=ffmpeg
    if command -v brew >/dev/null 2>&1; then
        full="$(brew --prefix ffmpeg-full 2>/dev/null)/bin/ffmpeg"
        [[ -x "$full" ]] && FFMPEG="$full"
    fi
fi

has_drawtext=0
if "$FFMPEG" -hide_banner -filters 2>/dev/null | grep -q " drawtext "; then
    has_drawtext=1
fi

font=""
for f in /System/Library/Fonts/Menlo.ttc /System/Library/Fonts/Supplemental/Courier\ New.ttf; do
    [[ -f "$f" ]] && font="$f" && break
done

echo "ffmpeg: $FFMPEG (drawtext: $has_drawtext)"

# make <name> <rate> <seconds> <start timecode, ';' before FF = drop-frame>
make() {
    local name="$1" rate="$2" secs="$3" tc="$4"
    local src vf
    if [[ $has_drawtext == 1 ]]; then
        src="testsrc2=size=1280x720:rate=$rate"
        local tc_esc="${tc//:/\\:}"
        tc_esc="${tc_esc//;/\\;}"
        local common="fontfile='$font':fontcolor=white:box=1:boxcolor=black@0.7:boxborderw=12:fontsize=56:x=40"
        vf="drawtext=$common:y=40:text='frame %{n}',"
        vf+="drawtext=$common:y=130:timecode='$tc_esc':rate=$rate,"
        vf+="drawtext=$common:fontsize=36:y=h-80:text='$name'"
    else
        src="testsrc=size=640x360:rate=$rate:decimals=3"
        vf="null"
    fi
    echo "-> $name.mp4 ($rate fps, ${secs}s)"
    "$FFMPEG" -hide_banner -loglevel error -y -f lavfi -i "$src" -t "$secs" -vf "$vf" \
        -c:v libx264 -preset ultrafast -crf 28 -pix_fmt yuv420p -g 60 \
        "$name.mp4"
}

make tc_23.976fps 24000/1001  70 "00:00:00:00"
make tc_24fps     24          70 "00:00:00:00"
make tc_25fps     25          70 "00:00:00:00"
make tc_29.97fps_df 30000/1001 660 "00:00:00;00"   # 11 min: crosses the 10-minute (no drop) boundary
make tc_59.94fps  60000/1001  70 "00:00:00:00"

echo "-> audio_only.m4a (timecode must fall back to the normal timer)"
"$FFMPEG" -hide_banner -loglevel error -y -f lavfi -i "sine=frequency=440:duration=30" \
    -c:a aac -b:a 96k audio_only.m4a

ls -lh ./*.mp4 ./*.m4a
