# Java Runner 개선 분석 리포트

**작성일**: 2025-12-18 19:10:28
**작성자**: Claude Code
**대상 스크립트**: `scripts/java-runner.sh`

---

## 📋 Executive Summary

본 리포트는 `java-runner.sh` 스크립트의 현재 상태를 분석하고, 프로젝트 루트에서 멀티모듈 프로젝트를 실행할 수 있도록 개선하는 방안을 제시합니다.

**주요 발견사항**:
- ❌ 프로젝트 루트에서 실행 시 pom.xml을 찾지 못해 실패
- ❌ CURRENT_LESSON 설정을 읽지 않음
- ❌ 멀티모듈 구조 미지원
- ✅ 기본 Maven 명령 래핑 기능은 정상

**권장 조치**: .katarc의 CURRENT_LESSON을 읽어 자동으로 해당 디렉토리로 이동 후 Maven 실행

---

## 🔍 1. 현재 상태 분석

### 1.1 환경 설정

#### .katarc 파일
```bash
CURRENT_KATA=hidden-number
CURRENT_LESSON=01-hello-world
DEFAULT_PROJECT_TYPE=lesson
```

**분석**:
- ✅ `CURRENT_LESSON=01-hello-world` 정의됨
- ❌ java-runner.sh가 이 설정을 읽지 않음

### 1.2 프로젝트 구조

```
java-study/                          ← 프로젝트 루트
├── .katarc
├── scripts/
│   └── java-runner.sh
├── katas/
│   └── hidden-number/
│       └── pom.xml
└── java-apcs-lessons/               ← 멀티모듈 루트
    └── 01-hello-world/              ← 개별 lesson 모듈
        └── pom.xml                  ← 실제 pom.xml 위치
```

**문제점**:
- 프로젝트 루트에는 pom.xml이 없음
- lesson 모듈들이 `java-apcs-lessons/` 하위에 분산되어 있음
- 스크립트가 현재 디렉토리에서만 pom.xml을 찾음

### 1.3 스크립트 분석

#### check_pom() 함수 (Line 49-53)
```bash
check_pom() {
    if [ ! -f "pom.xml" ]; then
        fail "pom.xml not found in the current directory. Please run this script from the project root."
    fi
}
```

**문제**:
- 현재 디렉토리에만 pom.xml이 있는지 확인
- 멀티모듈 구조 미고려
- CURRENT_LESSON 설정 미활용

---

## 🧪 2. 테스트 결과

### 2.1 프로젝트 루트에서 실행

**실행**:
```bash
$ pwd
/Users/takgyun/source/java-study

$ ./scripts/java-runner.sh test
```

**결과**:
```
❌ pom.xml not found in the current directory. Please run this script from the project root.
```

**분석**:
- ❌ 프로젝트 루트에서 실행 불가능
- ❌ 사용자가 수동으로 lesson 디렉토리로 이동해야 함
- ❌ CURRENT_LESSON 설정이 있는데도 활용하지 않음

### 2.2 현재 사용 방법 (불편)

```bash
# 방법 1: 수동으로 이동
$ cd java-apcs-lessons/01-hello-world
$ ../../scripts/java-runner.sh test

# 방법 2: 상대 경로로 실행 (여전히 이동 필요)
$ cd java-apcs-lessons/01-hello-world
$ ../../scripts/java-runner.sh run
```

**문제점**:
1. 매번 lesson 디렉토리로 이동해야 함
2. 프로젝트 루트에서 바로 실행 불가능
3. .katarc의 CURRENT_LESSON 설정이 무용지물
4. 다른 lesson으로 전환하려면 .katarc 수정 + 디렉토리 이동 필요

---

## 💡 3. 개선 방안

### 3.1 요구사항 정의

사용자가 원하는 사용 방식:
```bash
# 프로젝트 루트에서 바로 실행
$ pwd
/Users/takgyun/source/java-study

$ ./scripts/java-runner.sh test
# → CURRENT_LESSON을 읽어 java-apcs-lessons/01-hello-world로 자동 이동 후 실행

$ ./scripts/java-runner.sh run
# → 자동으로 올바른 디렉토리에서 mvn exec:java 실행
```

### 3.2 아키텍처 설계

#### Before (현재)
```
사용자 → java-runner.sh → check_pom() → 현재 디렉토리에서 pom.xml 확인
                                          ↓
                                        실패 (pom.xml 없음)
```

#### After (개선 후)
```
사용자 → java-runner.sh → load_lesson() → .katarc에서 CURRENT_LESSON 읽기
                              ↓
                         check_pom() → 1. 현재 디렉토리에 pom.xml 있는지 확인
                              ↓          2. 없으면 CURRENT_LESSON 디렉토리로 이동
                         Maven 실행     3. 여전히 없으면 에러
```

### 3.3 구현 계획

#### 1단계: .katarc 읽기 함수 추가

```bash
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

    # 읽은 값을 전역 변수로 저장
    export CURRENT_LESSON
}
```

#### 2단계: check_pom() 함수 개선

```bash
# Maven 실행 전 pom.xml 확인 및 자동 디렉토리 이동
check_pom() {
    # 1. 현재 디렉토리에 pom.xml이 있으면 바로 사용
    if [ -f "pom.xml" ]; then
        info "Found pom.xml in current directory."
        return
    fi

    # 2. CURRENT_LESSON 설정이 있으면 해당 디렉토리로 이동
    if [ -n "$CURRENT_LESSON" ]; then
        local lesson_dir="java-apcs-lessons/$CURRENT_LESSON"

        if [ -d "$lesson_dir" ] && [ -f "$lesson_dir/pom.xml" ]; then
            info "Navigating to $lesson_dir (from CURRENT_LESSON)"
            cd "$lesson_dir" || fail "Failed to navigate to $lesson_dir"
            return
        else
            fail "CURRENT_LESSON is set to '$CURRENT_LESSON', but $lesson_dir/pom.xml not found."
        fi
    fi

    # 3. 둘 다 실패하면 에러
    fail "pom.xml not found. Please ensure you're in a Maven project directory or set CURRENT_LESSON in .katarc"
}
```

#### 3단계: main() 함수 수정

```bash
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
    shift

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
```

#### 4단계: 도움말 업데이트

```bash
print_help() {
    echo "Usage: ./scripts/java-runner.sh [command]"
    echo ""
    echo "Available commands:"
    echo "  test [options]   - Run tests using 'mvn test'."
    echo "  run              - Run the project's main class using 'mvn exec:java'."
    echo "  compile          - Compile the source code using 'mvn compile'."
    echo "  clean            - Clean the project using 'mvn clean'."
    echo "  package          - Package the application into a JAR/WAR file."
    echo "  help             - Show this help message."
    echo ""
    echo "Multi-module support:"
    echo "  - If run from project root, automatically navigates to CURRENT_LESSON directory"
    echo "  - CURRENT_LESSON is read from .katarc file"
    echo "  - Example: CURRENT_LESSON=01-hello-world → java-apcs-lessons/01-hello-world"
    echo ""
    echo "Examples:"
    echo "  ./scripts/java-runner.sh test        # From project root (uses CURRENT_LESSON)"
    echo "  ./scripts/java-runner.sh run         # Automatically navigates to correct module"
    echo ""
    echo "Troubleshooting:"
    echo "  - Ensure .katarc has CURRENT_LESSON set (e.g., CURRENT_LESSON=01-hello-world)"
    echo "  - Or run from within a module directory containing pom.xml"
}
```

---

## 📊 4. 개선 효과

### 4.1 사용성 비교

#### Before (현재)
```bash
# 사용자가 매번 수동으로 이동해야 함
$ cd java-apcs-lessons/01-hello-world
$ ../../scripts/java-runner.sh test
==> Running tests with 'mvn test'...
...

# 다른 lesson으로 전환
$ cd ../02-variables
$ ../../scripts/java-runner.sh test
```

**문제점**:
- 3번의 명령 (cd, 스크립트 실행, 다시 cd)
- 프로젝트 루트를 벗어남
- 불편한 UX

#### After (개선 후)
```bash
# 프로젝트 루트에서 바로 실행
$ pwd
/Users/takgyun/source/java-study

$ ./scripts/java-runner.sh test
==> Found pom.xml in current directory.
==> Navigating to java-apcs-lessons/01-hello-world (from CURRENT_LESSON)
==> Running tests with 'mvn test'...
...

# lesson 전환도 간단
$ vim .katarc  # CURRENT_LESSON=02-variables로 변경
$ ./scripts/java-runner.sh test
==> Navigating to java-apcs-lessons/02-variables (from CURRENT_LESSON)
```

**장점**:
- 1번의 명령으로 실행
- 프로젝트 루트 유지
- .katarc만 수정하면 lesson 전환 자동

### 4.2 워크플로우 개선

#### 시나리오 1: 새로운 lesson 시작
```bash
# Before (현재)
1. vim .katarc                                    # CURRENT_LESSON 변경
2. cd java-apcs-lessons/02-variables             # 수동 이동
3. ../../scripts/java-runner.sh test            # 실행
4. cd ../../                                      # 프로젝트 루트로 복귀

# After (개선 후)
1. vim .katarc                                    # CURRENT_LESSON 변경
2. ./scripts/java-runner.sh test                # 실행 (자동 이동)
```

#### 시나리오 2: 빠른 테스트 실행
```bash
# Before (현재)
$ cd java-apcs-lessons/01-hello-world && ../../scripts/java-runner.sh test && cd -

# After (개선 후)
$ ./scripts/java-runner.sh test
```

---

## 🧪 5. 테스트 시나리오

### 5.1 기본 시나리오

#### 테스트 1: 프로젝트 루트에서 test 실행
```bash
$ pwd
/Users/takgyun/source/java-study

$ cat .katarc | grep CURRENT_LESSON
CURRENT_LESSON=01-hello-world

$ ./scripts/java-runner.sh test
```

**예상 결과**:
```
==> Navigating to java-apcs-lessons/01-hello-world (from CURRENT_LESSON)
==> Running tests with 'mvn test'...
[INFO] Scanning for projects...
[INFO] Building 01-hello-world 1.0-SNAPSHOT
...
✅ Tests finished.
```

#### 테스트 2: 프로젝트 루트에서 run 실행
```bash
$ ./scripts/java-runner.sh run
```

**예상 결과**:
```
==> Navigating to java-apcs-lessons/01-hello-world (from CURRENT_LESSON)
==> Executing project with 'mvn exec:java'...
Hello, World!
✅ Execution finished.
```

#### 테스트 3: lesson 디렉토리 내에서 실행 (하위 호환성)
```bash
$ cd java-apcs-lessons/01-hello-world
$ ../../scripts/java-runner.sh test
```

**예상 결과**:
```
==> Found pom.xml in current directory.
==> Running tests with 'mvn test'...
...
✅ Tests finished.
```

### 5.2 에러 처리 시나리오

#### 테스트 4: CURRENT_LESSON 미설정
```bash
# .katarc에서 CURRENT_LESSON 제거
$ grep -v "CURRENT_LESSON" .katarc > .katarc.tmp && mv .katarc.tmp .katarc

$ ./scripts/java-runner.sh test
```

**예상 결과**:
```
❌ pom.xml not found. Please ensure you're in a Maven project directory or set CURRENT_LESSON in .katarc
```

#### 테스트 5: 잘못된 CURRENT_LESSON 값
```bash
# .katarc에 존재하지 않는 lesson 설정
$ echo "CURRENT_LESSON=99-nonexistent" >> .katarc

$ ./scripts/java-runner.sh test
```

**예상 결과**:
```
❌ CURRENT_LESSON is set to '99-nonexistent', but java-apcs-lessons/99-nonexistent/pom.xml not found.
```

#### 테스트 6: .katarc 파일 없음
```bash
$ mv .katarc .katarc.backup

$ cd java-apcs-lessons/01-hello-world
$ ../../scripts/java-runner.sh test
```

**예상 결과**:
```
==> Found pom.xml in current directory.
==> Running tests with 'mvn test'...
✅ Tests finished.
```
(하위 호환성: .katarc 없어도 현재 디렉토리에 pom.xml 있으면 작동)

### 5.3 통합 시나리오

#### 테스트 7: lesson 전환 워크플로우
```bash
# 1단계: 01-hello-world 테스트
$ cat .katarc | grep CURRENT_LESSON
CURRENT_LESSON=01-hello-world

$ ./scripts/java-runner.sh test
==> Navigating to java-apcs-lessons/01-hello-world (from CURRENT_LESSON)
✅ Tests finished.

# 2단계: lesson 전환
$ sed -i.bak 's/CURRENT_LESSON=01-hello-world/CURRENT_LESSON=02-variables/' .katarc

$ ./scripts/java-runner.sh test
==> Navigating to java-apcs-lessons/02-variables (from CURRENT_LESSON)
✅ Tests finished.

# 3단계: 원복
$ mv .katarc.bak .katarc
```

---

## 🔗 6. study-note-helper와의 통합

### 6.1 공통 설정 활용

두 스크립트가 동일한 .katarc 파일을 읽음:

| 스크립트 | 읽는 설정 | 용도 |
|----------|----------|------|
| java-runner.sh | `CURRENT_LESSON` | 자동 디렉토리 네비게이션 |
| study-note-helper.sh | `CURRENT_LESSON`, `DEFAULT_PROJECT_TYPE` | 프로젝트 컨텍스트, 타입 기본값 |

### 6.2 통합 워크플로우

```bash
# 1. lesson 시작
$ vim .katarc
CURRENT_LESSON=01-hello-world
DEFAULT_PROJECT_TYPE=lesson

# 2. 코드 작성 및 테스트
$ ./scripts/java-runner.sh test

# 3. 학습 노트 추가 (자동으로 lesson 타입, 01-hello-world 프로젝트)
$ ./scripts/study-note-helper.sh add \
    --keyword "Java기본" \
    --content "HelloWorld 프로그램 작성 완료"
# → docs/study/lesson/아카이브.md에 추가
# → **프로젝트**: 01-hello-world 자동 기록

# 4. 코드 실행
$ ./scripts/java-runner.sh run

# 5. 전체 학습 노트 확인
$ ./scripts/study-note-helper.sh list
```

**효과**:
- 두 스크립트가 .katarc를 통해 연동
- lesson 전환 시 두 스크립트 모두 자동 적용
- 일관된 프로젝트 컨텍스트 유지

---

## 🚨 7. 주의사항

### 7.1 구현 시 주의점

#### 경로 처리
```bash
# 상대 경로와 절대 경로 혼용 주의
local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
local project_root="$(dirname "$script_dir")"

# cd 실패 시 에러 처리
cd "$lesson_dir" || fail "Failed to navigate to $lesson_dir"
```

#### 하위 호환성 유지
```bash
# .katarc 없어도 작동해야 함 (기존 사용자 고려)
if [ ! -f "$katarc_file" ]; then
    return  # 조용히 리턴, 에러 없음
fi
```

#### 에러 메시지 명확화
```bash
fail "pom.xml not found. Please ensure you're in a Maven project directory or set CURRENT_LESSON in .katarc"
# ↑ 사용자에게 해결 방법 제시
```

### 7.2 잠재적 위험

| 위험 요소 | 영향도 | 대응 방안 |
|-----------|--------|----------|
| cd 실패 | 높음 | `cd ... || fail` 패턴 사용 |
| 잘못된 lesson 경로 | 중간 | 디렉토리 존재 확인 후 이동 |
| .katarc 파싱 에러 | 낮음 | grep/cut 실패 시 빈 문자열 반환 (안전) |
| Maven 명령 실패 | 낮음 | `set -e`로 자동 종료 |

---

## 📋 8. 구현 계획 요약

### 8.1 변경 사항

| 항목 | 현재 | 변경 후 |
|------|------|---------|
| .katarc 읽기 | 없음 | `load_lesson()` 함수 추가 |
| 디렉토리 네비게이션 | 없음 | `check_pom()`에 자동 이동 로직 추가 |
| CURRENT_LESSON 활용 | 없음 | 전역 변수로 저장 및 활용 |
| 에러 메시지 | 단순 | 해결 방법 포함 |
| 도움말 | 기본 | 멀티모듈 설명 추가 |

### 8.2 구현 단계

1. **load_lesson() 함수 추가** (10분)
   - .katarc 파일 읽기
   - CURRENT_LESSON 파싱 및 전역 변수 저장

2. **check_pom() 함수 개선** (20분)
   - 현재 디렉토리 pom.xml 확인
   - CURRENT_LESSON 기반 자동 이동
   - 상세 에러 메시지

3. **main() 함수 수정** (5분)
   - 맨 처음에 load_lesson() 호출

4. **print_help() 업데이트** (10분)
   - 멀티모듈 지원 설명 추가
   - 트러블슈팅 섹션 추가

5. **테스트 및 검증** (15분)
   - 7가지 테스트 시나리오 실행
   - 에러 처리 확인

**예상 총 소요 시간**: 약 1시간

---

## 🎯 9. 결론 및 권장사항

### 9.1 핵심 결론

1. **현재 java-runner.sh는 프로젝트 루트에서 실행 불가능**
2. **CURRENT_LESSON 설정이 있으나 활용하지 않음**
3. **멀티모듈 구조를 지원하지 않아 사용성 저하**
4. **간단한 개선으로 UX를 크게 향상시킬 수 있음**

### 9.2 권장 조치

#### 우선순위 1 (필수)
- ✅ load_lesson() 함수 추가
- ✅ check_pom() 자동 네비게이션 로직 추가
- ✅ CURRENT_LESSON 활용

#### 우선순위 2 (권장)
- ✅ 에러 메시지 개선 (해결 방법 포함)
- ✅ 도움말에 멀티모듈 설명 추가
- ✅ 하위 호환성 유지

### 9.3 최종 권장사항

**즉시 구현을 권장합니다**. 다음 이유로:

1. 현재 사용자는 매번 수동으로 디렉토리 이동해야 함 (불편)
2. .katarc에 CURRENT_LESSON 설정이 있지만 사용되지 않음 (낭비)
3. 구현이 간단하고 소요 시간이 짧음 (약 1시간)
4. study-note-helper.sh와 통합하여 일관된 워크플로우 제공 가능
5. 하위 호환성 유지 가능 (기존 사용자 영향 없음)

---

## 📎 10. 참고 자료

### 10.1 관련 파일

- **스크립트**: `scripts/java-runner.sh` (131 lines)
- **설정**: `.katarc`
- **스킬 문서**: `.claude/skills/java-runner/java-runner.md` (업데이트 예정)

### 10.2 주요 함수 목록

#### 현재 구현된 함수
- `print_help()` - 도움말 출력
- `check_pom()` - pom.xml 확인 (현재 디렉토리만)
- `run_tests()` - mvn test 실행
- `run_project()` - mvn exec:java 실행
- `compile_source()` - mvn compile 실행
- `clean_project()` - mvn clean 실행
- `package_project()` - mvn package 실행
- `main()` - 메인 로직

#### 신규 구현 필요 함수
- `load_lesson()` - .katarc에서 CURRENT_LESSON 읽기

---

## 📝 변경 이력

| 버전 | 날짜 | 작성자 | 변경 내용 |
|------|------|--------|----------|
| 1.0 | 2025-12-18 | Claude Code | 초안 작성 |

---

**리포트 종료**
