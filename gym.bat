@echo off

set pos_logfile=pos.log
set pos_zipfile[0]=pos1.log.zip
set pos_zipfile[1]=pos2.log.zip
set pos_zipfile[2]=pos3.log.zip
set /a maxsizemega=50
set /a maxsizebyte=%maxsizemega%*1024*1024

if EXIST %pos_logfile% (goto :start) else echo KHONG CO FILE LOG, BAO ADMIN XU LY 	
goto :eof

:start
	call :getsize %pos_logfile%
	if %sizebyte% gtr %maxsizebyte% (
		call :archive_newdata			
	)
EXIT /B %ERRORLEVEL%

:archive_newdata	
	del %pos_zipfile[2]%
	ren %pos_zipfile[1]% %pos_zipfile[2]%
	ren %pos_zipfile[0]% %pos_zipfile[1]%
	.\7zip\7z.exe a -y -tzip -sdel %pos_zipfile[0]% %pos_logfile%
EXIT /B %ERRORLEVEL%

:getsize
	set sizebyte=%~z1
EXIT /B %ERRORLEVEL% 
