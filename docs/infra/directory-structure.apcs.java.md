# Java APCS 학습을 위한 디렉토리 구조

이 문서는 **Java 7**과 **Maven**을 기반으로 APCS(Advanced Placement Computer Science) Java 과정을 학습할 때 사용될 프로젝트의 표준 폴더 구조를 설명합니다. 이 구조는 Maven 멀티 모듈 방식을 채택하여 학습 효율성을 높이고, IDE 호환성을 보장하며, 학습 진행 상황을 체계적으로 관리할 수 있도록 설계되었습니다.

---

## 목차

- [프로젝트 구조 개요](#프로젝트-구조-개요)
- [구조의 장점](#구조의-장점)
- [각 모듈의 구성](#각-모듈의-구성)
- [스크립트 연동](#스크립트-연동)

---

## 1. 프로젝트 구조 개요

APCS Java 학습 프로젝트는 **Maven 멀티 모듈(Multi-module) 프로젝트** 구조를 채택합니다. 전체 학습 과정은 `java-apcs-lessons`라는 루트 폴더 아래에 위치하며, 각 학습 단원(예: 변수, 조건문)은 하나의 독립적인 Maven 모듈로 구성됩니다.

```
java-study/
├── pom.xml                 # 전체 프로젝트를 관리하는 부모 POM
│
└── java-apcs-lessons/
    ├── pom.xml             # 모든 학습 모듈을 포함하는 POM
    │
    ├── 01-hello-world/       (첫 번째 단원 모듈)
    │   ├── pom.xml
    │   └── src/
    │       └── main/
    │           └── java/
    │               └── lesson/
    │                   └── HelloWorld.java
    │
    ├── 02-variables/         (두 번째 단원 모듈)
    │   ├── pom.xml
    │   └── src/
    │       ├── main/
    │       │   └── java/
    │       │       └── lesson/
    │       │           └── Variables.java
    │       └── test/           (단원에 대한 테스트 코드)
    │           └── java/
    │               └── lesson/
    │                   └── VariablesTest.java
    │
    └── ... (이후 단원들)
```

---

## 2. 구조의 장점

### 2.1. IDE 호환성
IntelliJ IDEA, Eclipse 등 주요 Java IDE에서 `java-study` 루트 폴더를 '기존 Maven 프로젝트로 가져오기(Import as Maven Project)' 하면, 각 단원 폴더(`01-hello-world` 등)가 자동으로 독립된 모듈로 인식됩니다. 이는 실제 Java 개발 환경과 유사한 경험을 제공합니다.

### 2.2. 독립적인 학습 단위
각 단원은 자체 `pom.xml`과 `src` 폴더를 갖는 독립 모듈입니다. 이로 인해 한 단원을 학습할 때 다른 단원의 코드가 영향을 주지 않아, 특정 개념에만 집중할 수 있습니다.

### 2.3. 표준화된 구조 학습
`src/main/java`와 `src/test/java`로 소스 코드를 분리하는 것은 Java 개발의 표준 관례입니다. 학생들은 이 구조를 통해 자연스럽게 업계 표준을 익힐 수 있습니다.

### 2.4. 체계적인 진행 상황 추적
`.katarc`와 같은 설정 파일을 프로젝트 루트에 두어 `current_lesson = "02-variables"`와 같이 현재 진행 중인 학습 단원을 기록할 수 있습니다. 이는 자동화된 스크립트가 현재 학습 컨텍스트를 파악하는 데 도움을 줍니다.

---

## 3. 각 모듈의 구성

-   **`pom.xml`**: 해당 단원 모듈의 빌드 설정, 의존성(dependency), 플러그인 등을 정의합니다.
-   **`src/main/java`**: 단원의 핵심 Java 소스 코드가 위치합니다.
-   **`src/test/java`**: 단원에서 학습한 내용에 대한 JUnit 테스트 코드가 위치합니다.

---

## 4. 스크립트 연동

이 구조는 자동화된 헬퍼 스크립트와 원활하게 연동되도록 설계되었습니다.

### `java-runner.sh`
-   `java-runner.sh` 스크립트는 현재 학습 중인 모듈의 Java 코드를 실행하는 데 사용됩니다.
-   스크립트는 `.katarc` 파일 등을 참조하여 현재 작업 디렉토리(예: `java-apcs-lessons/02-variables`)를 파악하고, 해당 모듈에 대해 `mvn exec:java`와 같은 Maven 명령을 실행하여 코드를 컴파일하고 실행합니다.
-   이를 통해 사용자는 복잡한 명령 없이 단일 명령으로 현재 학습 중인 코드를 즉시 실행하고 결과를 확인할 수 있습니다.

### `study-note-helper.sh`
-   `study-note-helper.sh` 스크립트는 현재 학습 단원에 대한 노트를 생성하거나 관리하는 데 도움을 줍니다.
-   마찬가지로 현재 학습 중인 모듈(예: `02-variables`)을 기준으로, 해당 단원 폴더 내에 `notes.md` 파일을 생성하거나 업데이트하는 등의 작업을 자동화할 수 있습니다.
-   이는 학습 내용을 코드와 함께 체계적으로 정리하는 데 도움을 줍니다.