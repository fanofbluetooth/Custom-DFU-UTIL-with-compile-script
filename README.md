Building on Windows using MinGW-w64 from MSYS2
==============================================

1. Install `msys2-x86_64-20210604.exe` (MSYS2 GUI installer for Windows)
   with default configuration (install to the directory `C:\msys64`).

File `msys2-x86_64-20210604.exe`: <https://github.com/msys2/msys2-installer/releases/download/2021-06-04/msys2-x86_64-20210604.exe>
Download page: <https://www.msys2.org/#installation>

2. After MSYS2 installation to `C:\msys64`, run `Build.bat`.

3. In MSYS2 shell Window type the command: `./build-in-msys.sh`

Compilation of `libusb` and `dfu-util` using MinGW64 will begin in the last step.

If MSYS2 asked you to exit, just press Yes and start again from step 2.

MSYS2 subsytem is not fast. Some commands in Linux runs for 10-30 seconds. Such
commands in MSYS2, may run for many minutes.

When succeeded, your compiled files will be in the directory `Build`.

How to download source code
---------------------------

File `dfu-util-0.10.tar.gz`: <http://dfu-util.sourceforge.net/releases/dfu-util-0.10.tar.gz>
Download page: <http://dfu-util.sourceforge.net/releases/>

File `libusb-1.0.24.zip`: <https://github.com/libusb/libusb/archive/refs/tags/v1.0.24.zip>
Download page: <https://github.com/libusb/libusb/releases>
