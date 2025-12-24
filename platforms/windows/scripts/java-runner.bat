@echo off
REM ============================================================================
REM java-runner.bat - Windows version
REM Java/Maven 프로젝트를 위한 래퍼 스크립트
REM 사용법: java-runner.bat [command] [options]
REM ============================================================================

setlocal enabledelayedexpansion

REM --- 색상 코드 ---
set "BLUE=[34m"
set "GREEN=[32m"
set "RED=[31m"
set "NC=[0m"

REM --- 기본 헬퍼 ---
:info
echo %BLUE%==^> %~1%NC%
goto:eof

:success
echo %GREEN%✅ %~1%NC%
goto:eof

:fail
echo %RED%❌ %~1%NC%
exit /b 1

REM --- Configuration Loading ---
REM Change to project root (scripts is in platforms/windows/scripts)
cd /d "%~dp0\..\.."

REM Load CURRENT_LESSON from .katarc
:load_lesson
set KATARC_FILE=.katarc
if not exist "%KATARC_FILE%" goto:eof

for /f "tokens=1,2 delims==" %%a in (%KATARC_FILE%) do (
    if "%%a"=="CURRENT_LESSON" set CURRENT_LESSON=%%b
)

if defined CURRENT_LESSON (
    set "PROJECT_ROOT=%CD%"
)
goto:eof

REM --- 도움말 출력 ---
:print_help
echo Usage: %~nx0 [command]
echo.
echo Available commands:
echo   test [options]   - Run tests using 'mvn test'. Pass additional Maven options if needed.
echo   run              - Run the project's main class using 'mvn exec:java'.
echo   compile          - Compile the source code using 'mvn compile'.
echo   clean            - Clean the project using 'mvn clean'.
echo   package          - Package the application into a JAR/WAR file using 'mvn package'.
echo   help             - Show this help message.
echo.
echo Multi-module support:
echo   - If run from project root, automatically navigates to CURRENT_LESSON directory
echo   - CURRENT_LESSON is read from .katarc file
echo   - Example: CURRENT_LESSON=01-hello-world -^> 01-hello-world
echo.
echo Examples:
echo   %~nx0 test        # From project root (uses CURRENT_LESSON)
echo   %~nx0 run         # Automatically navigates to correct module
echo.
echo Troubleshooting:
echo   - Ensure .katarc has CURRENT_LESSON set (e.g., CURRENT_LESSON=01-hello-world)
echo   - Or run from within a module directory containing pom.xml
goto:eof

REM --- Maven 실행 전 pom.xml 확인 및 자동 디렉토리 이동 ---
:check_pom
REM 1. 현재 디렉토리에 pom.xml이 있으면 바로 사용
if exist "pom.xml" (
    call :info "Found pom.xml in current directory."
    goto:eof
)

REM 2. CURRENT_LESSON 설정이 있으면 해당 디렉토리로 이동
if defined CURRENT_LESSON (
    if defined PROJECT_ROOT (
        set "lesson_dir=%PROJECT_ROOT%\%CURRENT_LESSON%"

        if exist "!lesson_dir!\pom.xml" (
            call :info "Navigating to %CURRENT_LESSON% (from CURRENT_LESSON)"
            cd /d "!lesson_dir!" || call :fail "Failed to navigate to !lesson_dir!"
            goto:eof
        ) else (
            call :fail "CURRENT_LESSON is set to '%CURRENT_LESSON%', but !lesson_dir!\pom.xml not found."
        )
    )
)

REM 3. 둘 다 실패하면 에러
call :fail "pom.xml not found. Please ensure you're in a Maven project directory or set CURRENT_LESSON in .katarc"
goto:eof

REM --- 테스트 실행 ---
:run_tests
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
call :info "Running tests with 'mvn test'..."
mvn test %*
call :success "Tests finished."
goto:eof

REM --- 프로젝트 실행 ---
:run_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
call :info "Executing project with 'mvn exec:java'..."
mvn exec:java %*
call :success "Execution finished."
goto:eof

REM --- 소스코드 컴파일 ---
:compile_source
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
call :info "Compiling source code with 'mvn compile'..."
mvn compile %*
call :success "Compilation successful."
goto:eof

REM --- 빌드 아티팩트 정리 ---
:clean_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
call :info "Cleaning project with 'mvn clean'..."
mvn clean %*
call :success "Project cleaned."
goto:eof

REM --- 프로젝트 패키징 ---
:package_project
call :check_pom
if %errorlevel% neq 0 exit /b %errorlevel%
call :info "Packaging project with 'mvn package'..."
mvn package %*
call :success "Project packaged successfully."
goto:eof

REM --- 메인 로직 ---
:main
REM .katarc 읽기 (맨 처음 실행)
call :load_lesson

if "%~1"=="" (
    call :info "No command provided. Showing help."
    call :print_help
    exit /b 1
)

set "COMMAND=%~1"
shift

if /I "%COMMAND%"=="test" (
    call :run_tests %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if /I "%COMMAND%"=="run" (
    call :run_project %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if /I "%COMMAND%"=="compile" (
    call :compile_source %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if /I "%COMMAND%"=="clean" (
    call :clean_project %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if /I "%COMMAND%"=="package" (
    call :package_project %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if /I "%COMMAND%"=="help" (
    call :print_help
) else (
    call :print_help
)
goto:eof

REM 스크립트 실행
call :main %*
