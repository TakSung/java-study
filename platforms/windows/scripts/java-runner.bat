@echo off
rem Java/Maven 프로젝트를 위한 래퍼 스크립트 (Windows용)
rem 사용법: java-runner.bat [command] [options]

rem --- 작업 정의 ---

rem 도움말 출력
:print_help
echo Usage: java-runner.bat [command]
echo.
echo Available commands:
echo   test [options]   - Run tests using 'mvn test'. Pass additional Maven options if needed.
echo   run              - Run the project's main class using 'mvn exec:java'.
echo   compile          - Compile the source code using 'mvn compile'.
echo   clean            - Clean the project using 'mvn clean'.
echo   package          - Package the application into a JAR/WAR file using 'mvn package'.
echo   help             - Show this help message.
echo.
echo Examples:
echo   java-runner.bat test
echo   java-runner.bat test -Dtest=com.example.MyTest
echo   java-runner.bat run
goto:eof

rem Maven 실행 전 pom.xml 확인
:check_pom
if not exist "pom.xml" (
    echo [ERROR] pom.xml not found in the current directory. Please run this script from the project root.
    exit /b 1
)
goto:eof

rem 테스트 실행
:run_tests
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
echo.
echo [INFO] Running tests with 'mvn test'...
mvn test %*
echo [INFO] Tests finished.
goto:eof

rem 프로젝트 실행
:run_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
echo.
echo [INFO] Executing project with 'mvn exec:java'...
mvn exec:java %*
echo [INFO] Execution finished.
goto:eof

rem 소스코드 컴파일
:compile_source
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
echo.
echo [INFO] Compiling source code with 'mvn compile'...
mvn compile %*
echo [INFO] Compilation successful.
goto:eof

rem 빌드 아티팩트 정리
:clean_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
echo.
echo [INFO] Cleaning project with 'mvn clean'...
mvn clean %*
echo [INFO] Project cleaned.
goto:eof

rem 프로젝트 패키징
:package_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
echo.
echo [INFO] Packaging project with 'mvn package'...
mvn package %*
echo [INFO] Project packaged successfully.
goto:eof


rem --- 메인 로직 ---
if "%1"=="" (
    echo [INFO] No command provided. Showing help.
    call :print_help
    exit /b 1
)

set "COMMAND=%1"
shift

if /I "%COMMAND%"=="test" (
    call :run_tests %*
) else if /I "%COMMAND%"=="run" (
    call :run_project %*
) else if /I "%COMMAND%"=="compile" (
    call :compile_source %*
) else if /I "%COMMAND%"=="clean" (
    call :clean_project %*
) else if /I "%COMMAND%"=="package" (
    call :package_project %*
) else if /I "%COMMAND%"=="help" (
    call :print_help
) else (
    echo [ERROR] Unknown command: %COMMAND%
    call :print_help
)
