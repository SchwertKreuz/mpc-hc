@ECHO OFF
REM Generates test videos for checking the status bar FPS / timecode display (Windows).
REM Local helper only (lives on the local/my-build branch, never in upstream PRs).
REM Needs an ffmpeg with drawtext, e.g. the "full" build from https://www.gyan.dev/ffmpeg/builds/
REM Usage: testmedia\make_test_videos.bat   (ffmpeg.exe must be on PATH, or SET FFMPEG=C:\path\ffmpeg.exe)

SETLOCAL
PUSHD %~dp0
IF NOT DEFINED FFMPEG SET "FFMPEG=ffmpeg"

CALL :make tc_23.976fps 24000/1001 70 "00\:00\:00\:00"
CALL :make tc_24fps 24 70 "00\:00\:00\:00"
CALL :make tc_25fps 25 70 "00\:00\:00\:00"
CALL :make tc_29.97fps_df 30000/1001 660 "00\:00\:00\;00"
CALL :make tc_59.94fps 60000/1001 70 "00\:00\:00\:00"

ECHO -^> audio_only.m4a
"%FFMPEG%" -hide_banner -loglevel error -y -f lavfi -i "sine=frequency=440:duration=30" -c:a aac -b:a 96k audio_only.m4a

DIR /B *.mp4 *.m4a
POPD
ENDLOCAL
PAUSE
EXIT /B

:make
ECHO -^> %1.mp4 (%2 fps, %3 s)
SET "COMMON=fontfile='C\:/Windows/Fonts/consola.ttf':fontcolor=white:box=1:boxcolor=black@0.7:boxborderw=12:fontsize=56:x=40"
"%FFMPEG%" -hide_banner -loglevel error -y -f lavfi -i "testsrc2=size=1280x720:rate=%2" -t %3 ^
 -vf "drawtext=%COMMON%:y=40:text='frame %%{n}',drawtext=%COMMON%:y=130:timecode='%~4':rate=%2,drawtext=%COMMON%:fontsize=36:y=h-80:text='%1'" ^
 -c:v libx264 -preset ultrafast -crf 28 -pix_fmt yuv420p -g 60 %1.mp4
EXIT /B
