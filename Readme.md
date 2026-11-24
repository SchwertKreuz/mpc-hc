# MPC-HC-TC (unofficial fork of MPC-HC)

**MPC-HC-TC is an unofficial fork of [MPC-HC](https://github.com/clsid2/mpc-hc). It is not affiliated with or endorsed by the MPC-HC project.** Please report problems with MPC-HC-TC to [this repository](https://github.com/SchwertKreuz/mpc-hc/issues), not to MPC-HC.

### Changes from MPC-HC
- **Timecode in the timer**: right-click the time in the status bar (or the seekbar time) and check **Timecode** to show the position, duration and remaining time as `HH:MM:SS:FF`, like editing software. 29.97 fps uses drop-frame timecode (`HH:MM:SS;FF`). The frame shown in the timecode always matches the frame on screen.
- **FPS with up to 3 decimals** in the status bar: `23.976 fps` instead of `23.98 fps`.
- **Seeks go to the start of the shown frame**, so frame step, Go To, seekbar clicks and jumps all show the frame that matches the position (MPC-HC can be one frame off).
- **No update check against MPC-HC**: Help > Check for updates opens the [MPC-HC-TC releases](https://github.com/SchwertKreuz/mpc-hc/releases) page, and the automatic check is turned off, so the player doesn't offer to replace itself with MPC-HC.
- The Japanese translation includes the new Timecode menu item.

MPC-HC-TC keeps its settings in the same place as MPC-HC, so both share the same settings.

### License and source
MPC-HC-TC is licensed under [GPL v3](/COPYING.txt), like MPC-HC. The source of every release is the commit tagged for it in this repository. The included LAV Filters, FFmpeg and other components keep their own licenses. `d3dx9_43.dll` and `d3dcompiler_47.dll` are Microsoft DirectX redistributable files, included as in MPC-HC.

### Building
Build as described in [docs/Compilation.md](/docs/Compilation.md). With Visual Studio 2026 (MSVC 19.52), dav1d 1.5.3 in LAV Filters fails with error C7780; apply [patches/dav1d-msvc-stdatomic.patch](/patches/dav1d-msvc-stdatomic.patch) first (fixed in dav1d 1.5.5):
```
git -C src/thirdparty/LAVFilters/msvc/libs/dav1d/dav1d apply ../../../../../../../patches/dav1d-msvc-stdatomic.patch
```

### 日本語
MPC-HC-TC は [MPC-HC](https://github.com/clsid2/mpc-hc) の**非公式 fork** です。MPC-HC プロジェクトとは関係がなく、公認も受けていません。不具合の報告は MPC-HC ではなく[このリポジトリ](https://github.com/SchwertKreuz/mpc-hc/issues)へお願いします。

- ステータスバー（またはシークバー）の時間を右クリックして「タイムコード」にチェックを入れると、位置・総時間・残り時間を `HH:MM:SS:FF` で表示します（29.97 fps はドロップフレーム `HH:MM:SS;FF`）。表示は画面に映っているフレームと一致します。
- ステータスバーの FPS を小数3桁まで表示します（`23.98 fps` ではなく `23.976 fps`）。
- シーク先を「映っているフレームの開始時刻」にそろえるので、コマ送り・移動・シークバーのクリックで映像と時間がずれません。
- MPC-HC の更新確認はしません。「ヘルプ → 更新の確認」は MPC-HC-TC のリリースページを開きます。
- 設定は MPC-HC と同じ場所に保存されるので、両方入れると設定を共有します。
- ライセンスは MPC-HC と同じ GPL v3 です。各リリースのソースは、このリポジトリのタグを付けたコミットです。

---

# Media Player Classic - Home Cinema

Media Player Classic - Home Cinema (MPC-HC) is a free and open-source video and audio player for Windows. It is famous and loved for its simple and effective user interface, providing an excellent user experience. It offers a huge amount of functionality. Being a DirectShow player, it also allows flexibility and extensibility through third party filters.

## Development Status

The player is mature, stable, reliable, and already provides a huge amount of features.

I currently do not accept any new feature requests. But that does not mean that the player is not getting any new features or other improvements. In fact, a huge amount of improvements have been made since I have taken over development in 2017.

There are three primary reasons why I currently do not accept any new feature requests:<br/>
1) I and my fellow developers are too busy working on our own ideas and wishes for MPC-HC, and do not have any time or desire to work on other stuff.<br/>
2) 90% of all requests are for functionality that is already available in the player, sometimes for over a decade, but users are too lazy/stupid to have a look at the options and player menus, or do a simple Internet search for help.<br/>
3) For certain extra functionality there are already good solutions available. Such as an [equalizer](https://sourceforge.net/projects/equalizerapo/).

The internal codecs are developed in an external project ([LAV Filters](https://github.com/Nevcairiel/LAVFilters)). That project is actively maintained, and MPC-HC will be updated periodically with the latest codecs. Same applies to code/files from other external projects that are used by MPC-HC, such as MediaInfo.

If you are a programmer and want to help improve MPC-HC, then you can do so by submitting a pull request containing your patches.

## Overview of features

A lot of people seem to be unaware of some of the awesome features that have been added to MPC-HC in the past years. Here is a list of useful options and features that everyone should know about:
* Modern GUI Theme (Dark or Light)<br/>
Options > Player > User Interface<br/>
When using modern theme it is also possible to change the height of the seekbar and size of the toolbar buttons.<br/>
* Video preview on the seekbar<br/>
Options > Player > User Interface
* Play HDR video<br/>
This requires using MPC Video Renderer (included) or [madVR](http://forum.doom9.org/showthread.php?t=146228).<br/>
After installation these renderers can be selected here:<br/>
Options > Playback > Output<br/>
Tip: If you want an easy to use all-in-one package that contains MPC-HC and these renderers, then use [K-Lite Codec pack](http://codecguide.com/download_kl.htm).
* Added support for playback of many new audio and video formats:<br/>
For example HEVC (H.265) / VVC (H.266) / AV1 video, and AC4 audio.<br/>
* Improved subtitle rendering performance, and ability to use libass. Plus support for WebVTT.
* Ability to search for subtitles<br/>
Press D for manual search.<br/>
Or enable automatic search in: Options > Subtitles > Misc<br/>
* Adjust playback speed<br/>
Menu > Play > Playback rate<br/>
The buttons in the player that control playback rate take a 2x step by default. This can be customized to smaller values (like 10%):<br/>
Options > Playback > Speed step<br/>
Adjusting playback speed works best in combination with the SaneAR or MPC Audio Renderer. These two renderers have automatic pitch correction.<br/>
Options > Playback > Output > Audio Renderer
* MPC-HC can remember playback position, so you can resume from that point later<br/>
Options > Player > History
* You can quickly seek through a video with Ctrl + Mouse Scrollwheel.
* You can jump to next/previous file in a folder by pressing PageUp/PageDown.
* You can perform automatic actions at end of file. For example to go to next file or close player.<br/>
Options > Playback > After Playback (permanent setting)<br/>
Menu > Play > After Playback (for current file only)
* A-B repeat<br/>
You can loop a segment of a video. Press \[ and \] to set start and stop markers.
* You can rotate/flip/mirror/stretch/zoom the video<br/>
Menu > View > Pan&Scan<br/>
This is also easily done with hotkeys (see below).
* There are lots of keyboard hotkeys and mouse actions to control the player. They can be customized as well.<br/>
Options > Player > Keys<br/>
Tip: there is a search box above the table.
* You can stream videos directly from Youtube and many other video websites<br/>
Put [yt-dlp.exe](https://github.com/yt-dlp/yt-dlp/releases) in the MPC-HC installation folder.<br/>
Then you can open website URLs in the player: Menu > File > Open File/URL<br/>
You can even download those videos: Menu > File > Save a copy<br/>
Tip: to be able to download in best quality with yt-dlp, it is recommended to also put [ffmpeg.exe](https://www.gyan.dev/ffmpeg/builds/) in the MPC-HC folder.<br/>
Several YDL configuration options are found here: Options > Advanced<br/>
This includes an option to specify the location of the .exe in case you don't want to put it in MPC-HC folder.<br/>
Note 1: You also need to install [Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)](https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe)<br/>
Note 2: [yt-dlp nightly build](https://github.com/yt-dlp/yt-dlp-nightly-builds/) (very latest version made daily)
Note 3: [yt-dlp fork with Win7 support](https://github.com/nicolaasjan/yt-dlp/releases)
* Besides all these (new) features, there have also been many bugfixes and internal improvements in the player in the past years that give better performance and stability.

## System Requirements

* Windows 7 / 8 / 8.1 / 10 / 11

## License

MPC-HC's code is licensed under [GPL v3](/COPYING.txt).
