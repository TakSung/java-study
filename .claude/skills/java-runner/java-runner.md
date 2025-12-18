name: java-runner
description: Java Maven 멀티모듈 프로젝트의 빌드, 실행, 테스트, 정리를 위한 스킬. .katarc의 CURRENT_LESSON을 읽어 해당 모듈에서 작업합니다.
allowed-tools: Bash
---

# Java Runner - Java Maven 프로젝트 실행 및 검증 스킬

이 스킬은 `scripts/java-runner.sh` 래퍼 스크립트를 사용하여 Maven 멀티모듈 프로젝트를 빌드, 테스트, 실행 및 정리합니다.

스크립트는 `.katarc` 파일의 `CURRENT_LESSON` 변수를 읽어 자동으로 해당 모듈 디렉토리로 이동한 후 Maven 명령을 실행합니다.

## 작동 방식

1. `.katarc`에서 `CURRENT_LESSON` 읽기 (예: `01-hello-world`)
2. 해당 모듈 디렉토리로 이동
3. Maven 명령 실행

예시:
- `.katarc`: `CURRENT_LESSON=02-variables`
- 실행: `./scripts/java-runner.sh test`
- 내부 동작: `cd 02-variables && mvn test`

## 주요 명령어

모든 기능은 `./scripts/java-runner.sh`를 통해 접근합니다.

| 작업 | 명령어 | 설명 |
|---|---|---|
| **전체 테스트 실행** | `./scripts/java-runner.sh test` | `mvn test`를 실행하여 모든 테스트를 수행합니다. |
| **특정 테스트 실행** | `./scripts/java-runner.sh test -Dtest=TestClassName#methodName` | 특정 클래스 또는 메서드에 대한 테스트를 실행합니다. |
| **프로젝트 실행** | `./scripts/java-runner.sh run` | `mvn exec:java`를 실행하여 `pom.xml`에 정의된 메인 클래스를 실행합니다. |
| **컴파일 (문법 검사)** | `./scripts/java-runner.sh compile` | `mvn compile`을 실행하여 소스 코드의 문법을 검사하고 컴파일합니다. |
| **정리** | `./scripts/java-runner.sh clean` | `mvn clean`을 실행하여 `target` 디렉터리의 빌드 결과물을 삭제합니다. |
| **패키징** | `./scripts/java-runner.sh package` | `mvn package`를 실행하여 프로젝트를 `.jar` 또는 `.war` 파일로 패키징합니다. |
| **도움말** | `./scripts/java-runner.sh help` | 사용 가능한 모든 명령어를 확인합니다. |

---

## 사용 예시

### 예시 1: 전체 테스트 실행

**사용자 요청:**
> "테스트 돌려줘"

**스킬 동작:**
```bash
./scripts/java-runner.sh test
```

### 예시 2: 특정 테스트 실행

**사용자 요청:**
> "GameTest 클래스의 shouldStartWithReadyState 테스트만 실행해줘"

**스킬 동작:**
```bash
./scripts/java-runner.sh test -Dtest=GameTest#shouldStartWithReadyState
```

### 예시 3: 프로젝트 실행

**사용자 요청:**
> "프로젝트 실행해줘"

**스킬 동작:**
```bash
./scripts/java-runner.sh run
```

### 예시 4: 컴파일 및 문법 검사

**사용자 요청:**
> "문법 오류 없는지 확인해줘"

**스킬 동작:**
```bash
./scripts/java-runner.sh compile
```

### 예시 5: 빌드 결과물 정리

**사용자 요청:**
> "빌드 파일들 정리해줘"

**스킬 동작:**
```bash
./scripts/java-runner.sh clean
```

---

## Maven 프로젝트 구조 및 의존성 관리

Java 프로젝트는 표준 Maven 디렉터리 구조를 따릅니다.

- **`src/main/java`**: 애플리케이션 소스 코드
- **`src/main/resources`**: 리소스 파일 (설정 파일 등)
- **`src/test/java`**: 테스트 소스 코드
- **`src/test/resources`**: 테스트용 리소스 파일
- **`pom.xml`**: 프로젝트 설정 및 의존성 관리 파일

### 의존성 추가

`pom.xml` 파일의 `<dependencies>` 섹션에 새로운 의존성을 추가하고 Maven을 통해 동기화합니다.

```xml
<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-api</artifactId>
        <version>5.10.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

---

## 주의사항

- 시스템에 Java 21 (또는 `pom.xml`에 명시된 버전)과 Maven이 설치되어 있어야 합니다.
- 모든 명령어는 `pom.xml` 파일이 위치한 프로젝트의 루트 디렉터리에서 실행해야 합니다.

## 트러블슈팅

**문제: `mvn` command not found**
- **해결책**: 시스템에 Maven이 설치되어 있는지, `PATH` 환경 변수에 등록되어 있는지 확인하세요.

**문제: `Could not find or load main class`**
- **해결책**: `pom.xml`의 `maven-exec-plugin` 설정에서 `mainClass`가 올바르게 지정되었는지 확인하세요.
    ```xml
    <properties>
        <exec.mainClass>com.example.kata.Main</exec.mainClass>
    </properties>
    ```

**문제: `Dependencies not found`**
- **해결책**: `mvn clean install` 명령을 실행하여 모든 의존성을 다운로드하고 프로젝트를 로컬 Maven 저장소에 설치하세요.

**문제: `Java version mismatch`**
- **해결책**: `pom.xml`에 명시된 Java 버전과 시스템에 설치된 Java 버전이 일치하는지 확인하세요.
    ```xml
    <properties>
        <maven.compiler.source>21</maven.compiler.source>
        <maven.compiler.target>21</maven.compiler.target>
    </properties>
    ```

**문제: `Lesson directory not found`**
- **해결책**: `.katarc`의 `CURRENT_LESSON` 값이 실제 존재하는 디렉토리인지 확인하세요.
    ```bash
    cat .katarc | grep CURRENT_LESSON
    ls -d 01-*  # 실제 lesson 디렉토리 확인
    ```

**문제: `CURRENT_LESSON not set in .katarc`**
- **해결책**: `.katarc` 파일에 `CURRENT_LESSON=01-hello-world` 형식으로 변수를 추가하세요.
