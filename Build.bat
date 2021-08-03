@echo off
setlocal
cd "%~dp0"
"c:\msys64\msys2_shell.cmd" -mingw64 -where "%~dp0"
