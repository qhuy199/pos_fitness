@echo off

set pos_logfile=pos.log
set pos_zipfile[0]=pos1.log.zip
set pos_zipfile[1]=pos2.log.zip
set pos_zipfile[2]=pos3.log.zip
set /a maxsizegiga=1
set /a maxsizebyte=%maxsizegiga%*1024
set /a max7zipmega=10
set /a max7zipbyte=%max7zipmega%*1024*1024
set ziplogfile=7zip\zip.pos.log
set ziplogfilebk=7zip\zip.pos.log.bk

if EXIST %pos_logfile% (goto :start) else echo KHONG CO FILE LOG, BAO ADMIN XU LY 
	
goto :eof

:start
	call :getsize %pos_logfile%
	if %sizebyte% gtr %maxsizebyte% call :archive_newdata
	pause
EXIT /B %ERRORLEVEL%

:rename_archive_as_zip
	if NOT EXIST %pos_zipfile[0]% ren tmp_pos_log.zip %pos_zipfile[0]% & echo %date% %time% Windows - Rename "tmp_pos_log.zip" - "%pos_zipfile[0]%" >> "%ziplogfile%" 2>&1 & EXIT /B %ERRORLEVEL%
	if NOT EXIST %pos_zipfile[1]% ren tmp_pos_log.zip %pos_zipfile[1]% & echo %date% %time% Windows - Rename "tmp_pos_log.zip" - "%pos_zipfile[1]%" >> "%ziplogfile%" 2>&1 & EXIT /B %ERRORLEVEL%
	if NOT EXIST %pos_zipfile[2]% ren tmp_pos_log.zip %pos_zipfile[2]% & echo %date% %time% Windows - Rename "tmp_pos_log.zip" - "%pos_zipfile[2]%" >> "%ziplogfile%" 2>&1 & EXIT /B %ERRORLEVEL%
EXIT /B %ERRORLEVEL%

REM NEN FILE POS.LOG TOI DA 3 FILE, 1 FILE 1 LAN, XOA FILE POS.LOG (-SDEL) SAU KHI NEN XONG
REM DO ERRORLEVEL TRA LAI GIA TRI CHO "CALLER" NEN PHAI GOI FUNCTION TRONG NAY LUON
:archive_newdata	
	echo PHAT HIEN POS LOG CO SIZE LON HON DINH MUC, TIEN HANH THU GON DU LIEU
	echo %date% %time% 7-zip - Compressing ....
	echo %date% %time% 7-zip - Compressing ...."%pos_logfile%" >> "%ziplogfile%" 2>&1
	
	.\7zip\7z.exe a -y -tzip tmp_pos_log.zip %pos_logfile% >> "%ziplogfile%" 2>&1
	if %ERRORLEVEL%==0 call :del_old_data %pos_zipfile[0]% %pos_zipfile[1]% %pos_zipfile[2]% 		
	if %ERRORLEVEL%==0 call :rename_archive_as_zip

REM check file log cua 7zip, neu day thi xoa bot
	call :getsize %ziplogfile%
	if NOT EXIST %ziplogfilebk% copy NUL %ziplogfilebk%
	if %sizebyte% gtr %max7zipbyte% del %ziplogfilebk% & ren %ziplogfile% %ziplogfilebk%
	if %ERRORLEVEL%==0 echo %date% %time% HOAN TAT
	if ERRORLEVEL 1 echo %date% %time% CO LOI XAY RA, LIEN HE ADMIN
EXIT /B %ERRORLEVEL%

:getsize
	set sizebyte=%~z1	
EXIT /B %ERRORLEVEL% 

:del_old_data
	if EXIST %3 del %3 & echo %date% %time% Windows - Delete "%3" >> "%ziplogfile%" 2>&1
	if EXIST %2 ren %2 %3 & echo %date% %time% Windows - Rename "%2" - "%3" >> "%ziplogfile%" 2>&1
	if EXIST %1 ren %1 %2 & echo %date% %time% Windows - Rename "%1" - "%2" >> "%ziplogfile%" 2>&1
EXIT /B %ERRORLEVEL% 
