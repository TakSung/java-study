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
    echo "Examples:"
    echo "  ./scripts/java-runner.sh test"
    echo "  ./scripts/java-runner.sh test -Dtest=com.example.MyTest"
    echo "  ./scripts/java-runner.sh run"
}

# Maven 실행 전 pom.xml 확인
check_pom() {
    if [ ! -f "pom.xml" ]; then
        fail "pom.xml not found in the current directory. Please run this script from the project root."
    fi
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
