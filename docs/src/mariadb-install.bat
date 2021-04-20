@ECHO OFF
CD /D %~dp0

SET DB_SERVICE_NAME=mariadb
FOR /F "usebackq delims=" %%f in (`DIR /A:D /B "%CD%\mariadb-*-winx64"`) DO (
    SET DB_LOCAL_HOME=%CD%\%%f
)
REM ��������������������������������������������������������������������������������������������������������������������������������


REM ��黷��
IF NOT EXIST "%DB_LOCAL_HOME%\bin\mysqld.exe" (
    ECHO DB_LOCAL_HOME is not a database installation directory.
    PAUSE>NUL
    EXIT
)

REM ���û�������
SET PATH=%DB_LOCAL_HOME%\bin;%PATH%
CD /D "%DB_LOCAL_HOME%"

REM ���������ļ�
IF NOT EXIST my.ini (
    copy my-small.ini my.ini
)

REM ������Ա��ɾ���ɷ���
REM sc delete %DB_SERVICE_NAME%>nul
net stop %DB_SERVICE_NAME% 2>NUL
mysqld --remove %DB_SERVICE_NAME% 2>NUL

REM ������Ա����װ����
mysqld --install %DB_SERVICE_NAME% --defaults-file="%CD%\my.ini"

REM ������Ա����������
net start %DB_SERVICE_NAME%

REM ��¼�û�
mysql -uroot
@REM ��������������������������������������������������������������������������������������������������������������������������������
ECHO Everything is OK.
PAUSE>NUL