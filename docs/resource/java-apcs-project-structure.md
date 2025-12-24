# Java APCS 학습 프로젝트 구조 가이드

이 문서는 '선생님' 페르소나와 함께 APCS(Advanced Placement Computer Science) Java 과정을 학습할 때 사용될 프로젝트의 권장 폴더 구조에 대해 설명합니다. 학습 효율성을 높이고 Eclipse와 같은 통합 개발 환경(IDE)에서의 경험과 이질감을 줄이며, 학습 진행 상황을 체계적으로 추적할 수 있도록 설계되었습니다.

---

## 1. 프로젝트 구조 개요

APCS Java 학습 프로젝트는 **Maven 멀티 모듈(Multi-module) 프로젝트** 구조를 채택합니다. 각 학습 단원(예: 변수, 조건문)은 하나의 독립적인 Maven 모듈로 구성됩니다. 이 방식은 실제 Java 개발에서 널리 사용되는 표준이며, 각 단원을 독립적인 단위로 관리하면서도 전체 학습 과정을 하나의 프로젝트로 묶을 수 있는 장점이 있습니다.

```
java-apcs-lessons/
├── pom.xml            (전체 프로젝트를 관리하는 부모 설정 파일)
│
├── 01-hello-world/      (첫 번째 단원: Hello World)
│   ├── pom.xml
│   └── src/
│       └── main/
│           └── java/
│               └── lesson/
│                   └── HelloWorld.java
│
├── 02-variables/        (두 번째 단원: 변수와 타입)
│   ├── pom.xml
│   └── src/
│       ├── main/
│       │   └── java/
│       │       └── lesson/
│       │           └── Variables.java
│       └── test/          (단원에 대한 테스트 코드)
│           └── java/
│               └── lesson/
│                   └── VariablesTest.java
│
└── 03-conditionals/     (세 번째 단원: 조건문)
    ├── pom.xml
    └── src/
        ├── main/
        │   └── java/
        │       └── lesson/
        │           └── ConditionalLogic.java
        └── test/
            └── java/
                └── lesson/
                    └── ConditionalLogicTest.java
```

---

## 2. 구조의 장점

### 2.1. Eclipse 및 IDE 호환성

Eclipse (m2e 플러그션 사용 시) 또는 IntelliJ IDEA와 같은 주요 Java IDE에서 `java-apcs-lessons` 최상위 폴더를 '기존 Maven 프로젝트 가져오기(Import Existing Maven Projects)' 기능으로 불러오면, 각 단원 폴더(`01-hello-world/`, `02-variables/` 등)가 IDE 내에서 독립적인 모듈로 자동으로 인식됩니다. 이는 실제 Java 개발 환경과 동일한 경험을 제공하며, 학생들이 IDE 사용법을 자연스럽게 익히는 데 도움을 줍니다.

### 2.2. 학습 진행 상황 추적 용이성

`.katarc` 파일과 같은 학습 추적 메커니즘은 `java-apcs-lessons` 최상위 폴더에 위치하여, 현재 학습 중인 단원(모듈)의 이름을 기록할 수 있습니다. 예를 들어, `.katarc` 파일에 `current_lesson = "02-variables"`와 같이 저장하여 학습자가 어느 단원을 진행 중인지 쉽게 파악하고 다음 학습을 안내할 수 있습니다.

### 2.3. 독립적인 학습 단위

각 단원은 자체 `pom.xml` (Maven 프로젝트 설정 파일)과 `src` 폴더를 갖는 독립적인 모듈입니다. 이는 한 단원을 학습할 때 다른 단원의 코드나 설정이 현재 학습에 영향을 주지 않도록 하여, 학습자가 특정 개념이나 문제 해결에만 집중할 수 있게 합니다. 복잡한 의존성 관리 없이 깔끔하게 학습 단위를 분리할 수 있습니다.

### 2.4. 표준화된 폴더 구조 학습

`src/main/java`에 실제 구현 코드를, `src/test/java`에 해당 코드의 테스트 코드를 배치하는 것은 Java 개발의 표준 관례입니다. 학생들은 APCS 과정을 통해 이러한 업계 표준 폴더 구조와 빌드 시스템(Maven)을 자연스럽게 습득하며 좋은 개발 습관을 기를 수 있습니다.

---

## 3. 각 모듈의 구성

*   **`pom.xml`**: 해당 단원(모듈)의 빌드 설정, 의존성(dependency) 관리, 플러그인(plugin) 설정 등을 정의합니다. 각 단원에 필요한 최소한의 설정만 포함됩니다.
*   **`src/main/java`**: 단원의 핵심 Java 소스 코드가 위치합니다. 패키지 구조(`lesson/`)를 활용하여 코드를 체계적으로 관리합니다.
*   **`src/test/java`**: 단원에서 학습한 내용이나 구현된 기능에 대한 테스트 코드가 위치합니다. 주로 JUnit과 같은 테스트 프레임워크를 사용합니다.

이러한 구조는 APCS 학습자들이 기본적인 Java 문법과 더불어 실제 프로젝트 개발에 필요한 기본적인 코드 관리 및 빌드 시스템에 대한 이해를 동시에 얻을 수 있도록 돕습니다.
