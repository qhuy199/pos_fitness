
@echo off
REM    uniCenta oPOS Touch Friendly Point of Sales designed for Touch Screen
REM    Copyright (c) 2009-2017 uniCenta
REM    http://sourceforge.net/projects/unicentaopos
REM
REM    This file is part of uniCenta oPOS
REM
REM    uniCenta oPOS is free software: you can redistribute it and/or modify
REM    it under the terms of the GNU General Public License as published by
REM    the Free Software Foundation, either version 3 of the License, or
REM    (at your option) any later version.
REM
REM    uniCenta oPOS is distributed in the hope that it will be useful,
REM    but WITHOUT ANY WARRANTY; without even the implied warranty of
REM    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM    GNU General Public License for more details.
REM
REM    You should have received a copy of the GNU General Public License
REM    along with uniCenta oPOS.  If not, see http://www.gnu.org/licenses/>
REM

echo Chuong trinh dang khoi dong, man hinh den nay se tu dong tat sau khi khoi dong xong...

cd c:\app\pos

set DIRNAME=%~dp0
echo Canh bao -- The system cannot find the file specified -- ben duoi la binh thuong.
COPY /Y %DIRNAME%unicentaopos_new.jar %DIRNAME%unicentaopos.jar
set CP="%DIRNAME%unicentaopos.jar"

set CP=%CP%;"%DIRNAME%lib/bsh-core-2.0b4.jar"
set CP=%CP%;"%DIRNAME%lib/barcode4j-2.0.jar"
set CP=%CP%;"%DIRNAME%lib/commons-beanutils-1.8.3.jar"
set CP=%CP%;"%DIRNAME%lib/commons-codec-1.4.jar"
set CP=%CP%;"%DIRNAME%lib/commons-collections-3.2.1.jar"
set CP=%CP%;"%DIRNAME%lib/commons-configuration2-2.1.jar"
set CP=%CP%;"%DIRNAME%lib/commons-dbcp2-2.1.1.jar"
set CP=%CP%;"%DIRNAME%lib/commons-digester-2.1.jar"
set CP=%CP%;"%DIRNAME%lib/commons-discovery-0.5.0.jar"
set CP=%CP%;"%DIRNAME%lib/commons-lang3-3.5.jar"
set CP=%CP%;"%DIRNAME%lib/commons-logging-1.2.jar"
set CP=%CP%;"%DIRNAME%lib/iText-4.2.1.jar"
set CP=%CP%;"%DIRNAME%lib/jasperreports-6.4.0.jar"
set CP=%CP%;"%DIRNAME%lib/jcl_editor.jar"
set CP=%CP%;"%DIRNAME%lib/jcommon-1.0.15.jar"
set CP=%CP%;"%DIRNAME%lib/jdt-compiler-3.1.1.jar"
set CP=%CP%;"%DIRNAME%lib/jfreechart-1.0.19.jar"
set CP=%CP%;"%DIRNAME%lib/jpos-1.13.0.jar"
set CP=%CP%;"%DIRNAME%lib/jpos-2.0.10.jar"
set CP=%CP%;"%DIRNAME%lib/oro-2.0.8.jar"
set CP=%CP%;"%DIRNAME%lib/poi-3.10.1.jar"
set CP=%CP%;"%DIRNAME%lib/RXTXcomm.jar"
set CP=%CP%;"%DIRNAME%lib/swingx-all-1.6.4.jar"
set CP=%CP%;"%DIRNAME%lib/velocity-1.7-dep.jar"

REM Apache Axis SOAP libraries.
set CP=%CP%;"%DIRNAME%lib/axis.jar"
set CP=%CP%;"%DIRNAME%lib/jaxrpc-1.4.0.jar"
set CP=%CP%;"%DIRNAME%lib/saaj-1.4.0.jar"
set CP=%CP%;"%DIRNAME%lib/wsdl4j-1.6.3.jar"

set CP=%CP%;"%DIRNAME%locales/"
set CP=%CP%;"%DIRNAME%reports/"

REM ///////////////
set pos_logfile=pos.log
set pos_zipfile[0]=pos1.log.zip
set pos_zipfile[1]=pos2.log.zip
set pos_zipfile[2]=pos3.log.zip
set pos_zipfile[3]=pos4.log.zip
set pos_zipfile[4]=pos5.log.zip
set /a maxsizemega=50
set /a maxsizebyte=%maxsizemega%*1024*1024

if EXIST %pos_logfile% (call :log_rotate) else echo KHONG CO FILE LOG, NEU LA LAN DAU CO THONG BAO NAY LA BINH THUONG
goto :start

:log_rotate
	call :getsize %pos_logfile%
	if %sizebyte% gtr %maxsizebyte% (
		call :archive_newdata			
	)
EXIT /B %ERRORLEVEL%

:archive_newdata	
	del %pos_zipfile[4]%
	ren %pos_zipfile[3]% %pos_zipfile[4]%
	ren %pos_zipfile[2]% %pos_zipfile[3]%
	ren %pos_zipfile[1]% %pos_zipfile[2]%
	ren %pos_zipfile[0]% %pos_zipfile[1]%
	.\7zip\7z.exe a -y -tzip -sdel %pos_zipfile[0]% %pos_logfile%
EXIT /B %ERRORLEVEL%

:getsize
	set sizebyte=%~z1
EXIT /B %ERRORLEVEL% 

:start
REM /////////////////
start /B javaw -Xms512m -Xmx1024m -cp %CP% -Djava.library.path="%DIRNAME%lib/Windows/i368-mingw32" -Ddirname.path="%DIRNAME%./" -splash:unicenta_splash_dark.png com.openbravo.pos.forms.StartPOS %1 1>> pos.log 2>&1
ping -n 10 127.0.0.1 >nul
type "auto-update-check"
IF %ERRORLEVEL% EQU 0 (echo: && echo ============================ && echo: && echo Dang cap nhat phien ban moi ... && java -jar "%DIRNAME%POSAutoUpdater.jar")
del "auto-update-check" /f /q

