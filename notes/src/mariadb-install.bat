@SET DB_LOCAL_HOME=D:\ProgramFiles\MariaDB\mariadb-10.1.38-winx64
@SET DB_SERVICE_NAME=mariadb
@REM ��������������������������������������������������������������������������������������������������������������������������������
@ECHO OFF
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
IF NOT EXIST .\my.ini (
    ECHO [client]>.\my.ini
    ECHO port=3306>>.\my.ini
    ECHO socket=/tmp/mysql.sock>>.\my.ini
    ECHO default-character-set=utf8mb4>>.\my.ini
    @REM ����������������������������������������������������������������
    ECHO [mysqld]>>.\my.ini
    ECHO port=3306>>.\my.ini
    ECHO socket=/tmp/mysql.sock>>.\my.ini
    ECHO #basedir=>>.\my.ini
    ECHO #datadir=>>.\my.ini
    ECHO character_set_server=utf8mb4>>.\my.ini
    ECHO character_set_client=utf8mb4>>.\my.ini

    ECHO skip-external-locking>>.\my.ini
    ECHO key_buffer_size         = 16M>>.\my.ini
    ECHO max_allowed_packet      = 1M>>.\my.ini
    ECHO table_open_cache        = 64>>.\my.ini
    ECHO sort_buffer_size        = 512K>>.\my.ini
    ECHO net_buffer_length       = 8K>>.\my.ini
    ECHO read_buffer_size        = 256K>>.\my.ini
    ECHO read_rnd_buffer_size    = 512K>>.\my.ini
    ECHO myisam_sort_buffer_size = 8M>>.\my.ini

    ECHO log-bin=mysql-bin>>.\my.ini
    ECHO binlog_format=mixed>>.\my.ini
    ECHO server-id=1 >>.\my.ini
    @REM ����������������������������������������������������������������
    ECHO [mysqldump]>>.\my.ini
    ECHO character_set_client=utf8mb4>>.\my.ini
    ECHO quick>>.\my.ini
    ECHO max_allowed_packet=16M>>.\my.ini
    @REM ����������������������������������������������������������������
    ECHO [mysql]>>.\my.ini
    ECHO default-character-set=utf8mb4>>.\my.ini
    ECHO no-auto-rehash>>.\my.ini
    ECHO #safe-updates>>.\my.ini
    @REM ����������������������������������������������������������������
    ECHO [myisamchk]>>.\my.ini
    ECHO key_buffer_size  = 20M>>.\my.ini
    ECHO sort_buffer_size = 20M>>.\my.ini
    ECHO read_buffer      = 2M>>.\my.ini
    ECHO write_buffer     = 2M>>.\my.ini
    @REM ����������������������������������������������������������������
    ECHO [mysqlhotcopy]>>.\my.ini
    ECHO interactive-timeout>>.\my.ini
)
REM ������Ա��ɾ���ɷ���
sc delete %DB_SERVICE_NAME%>nul
REM ������Ա����װ����
mysqld --install %DB_SERVICE_NAME% --defaults-file="%CD%\my.ini"
REM ������Ա����������
net start %DB_SERVICE_NAME%
REM ��¼�û�
mysql -uroot
@REM ��������������������������������������������������������������������������������������������������������������������������������
ECHO Everything is OK.
PAUSE>NUL