@echo off
echo  ������������������������������������������������������������������������������������
echo    FastCAE��������һ������ Windows10��
echo.
echo      ������������¼��㹤����
echo      1. ȷ�ϰ�װ��Ҫ�Ŀ������ߣ�
echo      2. �����������⣻
echo      3. ���ɱ�Ҫ�����л�����
echo      4. ��Visual Studio IDE��
echo.
echo   �����ȷ�ϵ�ǰ����ϵͳ�� Qt, Visual Studio������ȷ��װ��
echo.
echo   ������װ���⣬����ϵFastCAE����С�飡
echo.
echo  ��������������������������������������������������������������������������������������

echo.  
echo ��ȷ���Ѿ���װQt5.4.2��Visual Studio 2013!
echo.

cd /d "%~dp0"

set currentPath=%cd%
echo %currentPath%

echo ������qmake.exe����·�������磺C:\Qt\Qt5.4.2\5.4\msvc2013_64_opengl\bin\��
echo.
set /p qmakeDir=������:
echo.
set qmakePath=%qmakeDir%\qmake.exe
echo %qmakePath%


echo ������Visual Studio 2013��װĿ¼�����磺C:\Program Files (x86)\Microsoft Visual Studio 12.0\��
echo (��Ŀ¼�´���VC��Common7���ļ���)
echo.
set /p VSDir=������:
echo.
echo "%VSDir%"

:Replace
set codePath=%currentPath%\Code
for /d  %%d in ("%currentPath%\Code\*") do (
if exist "%%d\_Create_project.bat" (
cd %%d
for /f "delims=" %%a in ('dir /b *.pro') do (
rem �����̵�qmake�ű�
echo. > %%d\_Create_project.bat
echo call "%VSDir%\VC\bin\amd64\vcvars64.bat" >> %%d\_Create_project.bat

echo. >> %%d\_Create_project.bat
echo SET "PATH=%qmakeDir%;%%PATH%%" >> %%d\_Create_project.bat 
echo. >> %%d\_Create_project.bat
echo qmake CONFIG+=X64 -tp vc %%a >> %%d\_Create_project.bat
echo. >> %%d\_Create_project.bat
echo pause >> %%d\_Create_project.bat
)
)
)

rem ����Ĺ��̽ű�
echo. >%codePath%\Create_X64_Project.bat
echo call "%VSDir%\VC\bin\amd64\vcvars64.bat" >> %codePath%\Create_X64_Project.bat
echo. >> %codePath%\Create_X64_Project.bat 
echo SET "PATH=%qmakeDir%;%%PATH%%" >> %codePath%\Create_X64_Project.bat 
echo. >> %codePath%\Create_X64_Project.bat 
for /d  %%d in ("%currentPath%\Code\*") do (
if exist "%%d\_Create_project.bat" (
for /f "delims=" %%a in ('dir /b %%d\*.pro') do (
echo cd %%d >> %codePath%\Create_X64_Project.bat
echo qmake CONFIG+=X64 -tp vc %%a >> %codePath%\Create_X64_Project.bat
echo. >> %codePath%\Create_X64_Project.bat 
)
)
)
echo pause >> %codePath%\Create_X64_Project.bat 

:VS
rem ����Visual studio 2013
echo. > %codePath%\Run_MSVC.bat
echo @echo off>> %codePath%\Run_MSVC.bat
echo %%1 mshta vbscript:CreateObject^("Shell.Application"^).ShellExecute^("cmd.exe","/c %%~s0 ::","","runas",1^)^(window.close^)^&^&exit >> %codePath%\Run_MSVC.bat
echo cd /d "%%~dp0">> %codePath%\Run_MSVC.bat
echo. >> %codePath%\Run_MSVC.bat
echo start "%VSDir%\Common7\IDE\devenv.exe" FastCAE.sln >> %codePath%\Run_MSVC.bat
echo. >> %codePath%\Run_MSVC.bat

echo ������ű���Ϣ������ϣ�
echo �����������ɿ�������������
pause

cd %codePath%

call "%codePath%\Copy_DLLs.bat"
call "%codePath%\Copy_Pys.bat"
call "%codePath%\Create_X64_Project.bat"

echo ���潫����Visual Studio 2013
pause
call "%codePath%\Run_MSVC.bat"


:finish
echo ������Ŀȫ����ɣ����򼴽��˳���
echo.
pause
exit
