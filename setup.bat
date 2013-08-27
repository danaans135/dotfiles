@echo off
setlocal

set MYHOME=%HOMEDRIVE%%HOMEPATH%

mklink %MYHOME%\_vimrc %~dp0\_vimrc
mklink %MYHOME%\_gvimrc %~dp0\_gvimrc
mklink %MYHOME%\_vimperatorrc %~dp0\_vimperatorrc

endlocal
