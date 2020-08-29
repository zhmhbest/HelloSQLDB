@ECHO OFF
CD /D %~dp0

SET DB_SERVICE_NAME=mariadb
FOR /F "usebackq delims=" %%f in (`DIR /A:D /B "%CD%\mariadb-*-winx64"`) DO (
    SET DB_LOCAL_HOME=%CD%\%%f
)
REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


REM 检查环境
IF NOT EXIST "%DB_LOCAL_HOME%\bin\mysqld.exe" (
    ECHO DB_LOCAL_HOME is not a database installation directory.
    PAUSE>NUL
    EXIT
)

REM 配置环境变量
SET PATH=%DB_LOCAL_HOME%\bin;%PATH%
CD /D "%DB_LOCAL_HOME%"

REM 创建配置文件
IF NOT EXIST my.ini (
    copy my-small.ini my.ini
)

REM （管理员）删除旧服务
REM sc delete %DB_SERVICE_NAME%>nul
net stop %DB_SERVICE_NAME% 2>NUL
mysqld --remove %DB_SERVICE_NAME% 2>NUL

REM （管理员）安装服务
mysqld --install %DB_SERVICE_NAME% --defaults-file="%CD%\my.ini"

REM （管理员）启动服务
net start %DB_SERVICE_NAME%

REM 登录用户
mysql -uroot
@REM ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
ECHO Everything is OK.
PAUSE>NUL