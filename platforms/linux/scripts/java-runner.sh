#!/bin/bash

# Java/Maven 프로젝트를 위한 래퍼 스크립트
# 사용법: ./scripts/java-runner.sh [command] [options]

set -e # 오류 발생 시 즉시 스크립트 종료

# --- 색상 코드 ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- 기본 헬퍼 ---
info() {
    echo -e "${BLUE}==> $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

fail() {
    echo -e "${RED}❌ $1${NC}" >&2
    exit 1
}

# --- Configuration Loading ---
# Load CURRENT_LESSON from .katarc
load_lesson() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local project_root="$(dirname "$script_dir")"
    local katarc_file="$project_root/.katarc"

    if [ ! -f "$katarc_file" ]; then
        # .katarc 없으면 현재 디렉토리 사용 (하위 호환성)
        return
    fi

    # CURRENT_LESSON 값 읽기
    CURRENT_LESSON=$(grep "^CURRENT_LESSON=" "$katarc_file" | cut -d'=' -f2 | tr -d ' ')

    if [ -n "$CURRENT_LESSON" ]; then
        export CURRENT_LESSON
        export PROJECT_ROOT="$project_root"
    fi
}

# --- 작업 정의 ---

# 도움말 출력
print_help() {
    echo "Usage: ./scripts/java-runner.sh [command]"
    echo ""
    echo "Available commands:"
    echo "  test [options]   - Run tests using 'mvn test'. Pass additional Maven options if needed."
    echo "  run              - Run the project's main class using 'mvn exec:java'."
    echo "  compile          - Compile the source code using 'mvn compile'."
    echo "  clean            - Clean the project using 'mvn clean'."
    echo "  package          - Package the application into a JAR/WAR file using 'mvn package'."
    echo "  help             - Show this help message."
    echo ""
    echo "Multi-module support:"
    echo "  - If run from project root, automatically navigates to CURRENT_LESSON directory"
    echo "  - CURRENT_LESSON is read from .katarc file"
    echo "  - Example: CURRENT_LESSON=01-hello-world → 01-hello-world"
    echo ""
    echo "Examples:"
    echo "  ./scripts/java-runner.sh test        # From project root (uses CURRENT_LESSON)"
    echo "  ./scripts/java-runner.sh run         # Automatically navigates to correct module"
    echo ""
    echo "Troubleshooting:"
    echo "  - Ensure .katarc has CURRENT_LESSON set (e.g., CURRENT_LESSON=01-hello-world)"
    echo "  - Or run from within a module directory containing pom.xml"
}

# Maven 실행 전 pom.xml 확인 및 자동 디렉토리 이동
check_pom() {
    # 1. 현재 디렉토리에 pom.xml이 있으면 바로 사용
    if [ -f "pom.xml" ]; then
        info "Found pom.xml in current directory."
        return
    fi

    # 2. CURRENT_LESSON 설정이 있으면 해당 디렉토리로 이동
    if [ -n "$CURRENT_LESSON" ] && [ -n "$PROJECT_ROOT" ]; then
        local lesson_dir="$PROJECT_ROOT/$CURRENT_LESSON"

        if [ -d "$lesson_dir" ] && [ -f "$lesson_dir/pom.xml" ]; then
            info "Navigating to $CURRENT_LESSON (from CURRENT_LESSON)"
            cd "$lesson_dir" || fail "Failed to navigate to $lesson_dir"
            return
        else
            fail "CURRENT_LESSON is set to '$CURRENT_LESSON', but $lesson_dir/pom.xml not found."
        fi
    fi

    # 3. 둘 다 실패하면 에러
    fail "pom.xml not found. Please ensure you're in a Maven project directory or set CURRENT_LESSON in .katarc"
}

# 테스트 실행
run_tests() {
    check_pom
    info "Running tests with 'mvn test'..."
    mvn test "$@"
    success "Tests finished."
}

# 프로젝트 실행
run_project() {
    check_pom
    info "Executing project with 'mvn exec:java'..."
    mvn exec:java
    success "Execution finished."
}

# 소스코드 컴파일
compile_source() {
    check_pom
    info "Compiling source code with 'mvn compile'..."
    mvn compile
    success "Compilation successful."
}

# 빌드 아티팩트 정리
clean_project() {
    check_pom
    info "Cleaning project with 'mvn clean'..."
    mvn clean
    success "Project cleaned."
}

# 프로젝트 패키징
package_project() {
    check_pom
    info "Packaging project with 'mvn package'..."
    mvn package
    success "Project packaged successfully."
}


# --- 메인 로직 ---
main() {
    # .katarc 읽기 (맨 처음 실행)
    load_lesson

    if [ -z "$1" ]; then
        info "No command provided. Showing help."
        print_help
        exit 1
    fi

    COMMAND=$1
    shift # 첫 번째 인자(command)를 제거

    case "$COMMAND" in
    test)
        run_tests "$@"
        ;;
    run)
        run_project "$@"
        ;;
    compile)
        compile_source "$@"
        ;;
    clean)
        clean_project "$@"
        ;;
    package)
        package_project "$@"
        ;;
    help | *)
        print_help
        ;;
    esac
}

# 스크립트 실행
main "$@"
