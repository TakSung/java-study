# Java Kata를 위한 클린 아키텍처 디렉토리 구조

이 문서는 Java 21과 Maven을 사용하여 클린 아키텍처(Clean Architecture) 기반의 Kata를 구성하는 표준 디렉토리 구조를 설명합니다. 이 구조는 각 Kata를 독립적인 Maven 모듈로 관리하여 명확성, 테스트 용이성, 그리고 확장성을 보장합니다.

---

## 목차

- [프로젝트 전체 구조](#프로젝트-전체-구조)
- [클린 아키텍처 Kata 구조](#클린-아키텍처-kata-구조)
- [계층별 책임 (Layer Responsibilities)](#계층별-책임-layer-responsibilities)
  - [1. 도메인 계층 (Domain Layer)](#1-도메인-계층-domain-layer)
  - [2. 애플리케이션 계층 (Application Layer)](#2-애플리케이션-계층-application-layer)
  - [3. 인프라스트럭처 계층 (Infrastructure Layer)](#3-인프라스트럭처-계층-infrastructure-layer)
  - [4. UI 계층 (UI Layer)](#4-ui-계층-ui-layer)
  - [5. 진입점 (Entry Point)](#5-진입점-entry-point)
- [의존성 흐름](#의존성-흐름)
- [패키지 및 임포트 전략](#패키지-및-임포트-전략)
- [파일 및 클래스 명명 규칙](#파일-및-클래스-명명-규칙)
- [사용된 Java 21 주요 기능](#사용된-java-21-주요-기능)
- [클린 아키텍처 원칙](#클린-아키텍처-원칙)
- [설정 파일 (pom.xml)](#설정-파일-pomxml)

---

## 프로젝트 전체 구조

Java Kata는 학습용 프로젝트와 충돌하지 않도록 별도의 `katas` 디렉토리 내에서 관리됩니다. 전체 프로젝트는 Maven 멀티 모듈 구조를 가지며, 각 Kata는 `katas` 폴더 아래의 독립적인 모듈이 됩니다.

```
java-study/
├── pom.xml                   # Parent POM (전체 프로젝트 관리)
│
├── ... (기타 문서 및 스크립트)
│
├── java-apcs-lessons/        # APCS 학습용 모듈 경로
│   ├── 01-hello-world/
│   └── ...
│
└── katas/                    # 클린 아키텍처 Kata 모듈 경로
    └── hidden-number/        # 예시 Kata (하나의 Maven 모듈)
        ├── pom.xml           # Kata 모듈 설정
        └── src/
            ├── main/
            │   └── java/
            │       └── com/kata/hiddennumber/
            │           ├── Main.java
            │           ├── domain/
            │           ├── app/
            │           ├── infra/
            │           └── ui/
            └── test/
                └── java/
                    └── com/kata/hiddennumber/
                        ├── domain/
                        └── app/
```

---

## 클린 아키텍처 Kata 구조

각 Kata는 표준 Maven 디렉토리 구조를 따릅니다. 패키지는 계층별로 분리됩니다.

### 참조 구현: `katas/hidden-number`

```
hidden-number/
├── pom.xml                             # 🔧 Maven 빌드 설정
├── README.md                           # 📖 Kata 설명 및 미션
└── src/
    ├── main/
    │   └── java/
    │       └── com/kata/hiddennumber/
    │           ├── Main.java           # 🚀 진입점 (의존성 주입)
    │           │
    │           ├── domain/             # 🎯 도메인 계층
    │           │   └── Game.java       #      (불변 데이터 클래스 - Record)
    │           │
    │           ├── app/                # 💼 애플리케이션 계층
    │           │   ├── GameService.java
    │           │   └── NumberGenerator.java (인터페이스)
    │           │
    │           ├── infra/              # 🔌 인프라스트럭처 계층
    │           │   └── RandomNumberGenerator.java
    │           │
    │           └── ui/                 # 🖥️ UI 계층
    │               └── ConsoleUI.java
    │
    └── test/
        └── java/
            └── com/kata/hiddennumber/
                ├── app/                # ✅ 테스트 스위트
                │   └── GameServiceTest.java
                └── domain/
                    └── GameTest.java
```

---

## 계층별 책임 (Layer Responsibilities)

각 계층의 역할과 구조적 특징을 간략한 코드로 설명합니다.

### 1. 도메인 계층 (Domain Layer)
- **역할**: 순수 비즈니스 로직, 규칙, 데이터 구조를 정의합니다.
- **예시**: 불변(immutable) 데이터 객체로 `record`를 사용합니다.

```java
// package com.kata.hiddennumber.domain;
public record Game(int answer, int attempts, int maxAttempts, boolean isFinished) {
    // 도메인 객체의 상태를 변경하는 비즈니스 로직 포함 가능
}
```

### 2. 애플리케이션 계층 (Application Layer)
- **역할**: 유즈케이스를 구현하고 도메인 객체를 조율합니다. 인프라 계층에 대한 의존성은 인터페이스(추상화)를 통해 관리합니다.
- **예시**: `GameService`는 `NumberGenerator` 인터페이스에 의존합니다.

```java
// package com.kata.hiddennumber.app;
public class GameService {
    private final NumberGenerator numberGenerator; // 인터페이스에 의존

    public GameService(NumberGenerator numberGenerator) { /* ... */ }

    public Game startNewGame() { /* ... */ }
    // ... 기타 유즈케이스 메서드
}
```

### 3. 인프라스트럭처 계층 (Infrastructure Layer)
- **역할**: 외부 기술(DB, API, 랜덤 생성 등)과의 연동을 구체적으로 구현합니다.
- **예시**: `NumberGenerator` 인터페이스를 구현한 `RandomNumberGenerator` 클래스.

```java
// package com.kata.hiddennumber.infra;
public class RandomNumberGenerator implements NumberGenerator {
    @Override
    public int generate(int min, int max) {
        // 실제 난수 생성 로직
    }
}
```

### 4. UI 계층 (UI Layer)
- **역할**: 사용자 인터페이스를 담당하며, 사용자의 입력을 받아 애플리케이션 계층으로 전달합니다.
- **예시**: `GameService`를 사용하여 콘솔 UI를 구성합니다.

```java
// package com.kata.hiddennumber.ui;
public class ConsoleUI {
    private final GameService gameService;

    public ConsoleUI(GameService gameService) { /* ... */ }

    public void run() {
        // 사용자 입출력 및 GameService 호출 로직
    }
}
```

### 5. 진입점 (Entry Point)
- **역할**: 애플리케이션의 시작 지점으로, 모든 계층의 구체적인 구현체를 생성하고 의존성을 주입(DI)합니다.
- **예시**: `Main` 클래스에서 각 객체를 생성하고 연결합니다.

```java
// package com.kata.hiddennumber;
public class Main {
    public static void main(String[] args) {
        // 1. 구체적인 구현체 생성
        NumberGenerator generator = new RandomNumberGenerator();
        GameService service = new GameService(generator);
        ConsoleUI ui = new ConsoleUI(service);

        // 2. 애플리케이션 실행
        ui.run();
    }
}
```

---

## 의존성 흐름

```
Domain Layer (domain/)
    ↑ depends on (imports from)
Application Layer (app/)
    ↑ depends on
Infrastructure Layer (infra/) & UI Layer (ui/)
```
**핵심 원칙**: 의존성은 항상 안쪽(domain)을 향해야 합니다. 외부 계층은 내부 계층에 의존할 수 있지만, 그 반대는 성립하지 않습니다.

---

## 패키지 및 임포트 전략

Java의 표준 `package`와 `import` 문법을 따릅니다. 모든 클래스는 명확한 패키지 경로를 가져야 하며, 다른 패키지의 클래스를 사용할 때는 `import` 문을 사용해야 합니다.

**✅ 올바른 방식**:
```java
package com.kata.hiddennumber.app;

import com.kata.hiddennumber.domain.Game; // 명시적 import
```

---

## 파일 및 클래스 명명 규칙

- **클래스/인터페이스/레코드**: `UpperCamelCase` (예: `GameService.java`)
- **테스트 클래스**: `*Test.java` (예: `GameServiceTest.java`)
- **패키지**: `lowercase` (예: `com.kata.hiddennumber.domain`)

---

## 사용된 Java 21 주요 기능

### 1. 레코드 (Records)

불변(immutable) 데이터 객체를 간결하게 정의하는 데 사용됩니다. `equals()`, `hashCode()`, `toString()` 및 생성자가 자동으로 생성됩니다.
```java
// domain/Game.java
public record Game(int answer, int attempts, int maxAttempts, boolean isFinished) {}
```

### 2. 스위치 표현식 (Switch Expressions)

`switch` 문을 더 간결하고 안전하게 사용할 수 있으며, 값을 반환할 수 있습니다.
```java
String message = switch (result) {
    case HIGH -> "너무 높습니다!";
    case LOW -> "너무 낮습니다!";
    case CORRECT -> "정답입니다!";
};
```

### 3. 향상된 `instanceof` (Pattern Matching for instanceof)

`instanceof` 확인과 변수 캐스팅을 한 번에 수행하여 코드를 간소화합니다.
```java
if (obj instanceof String s) {
    // 여기서 's'는 String 타입으로 바로 사용 가능
    System.out.println(s.toUpperCase());
}
```
---

## 클린 아키텍처 원칙

- **관심사 분리 (Separation of Concerns)**: 각 계층은 고유한 책임을 가집니다.
- **의존성 역전 (Dependency Inversion)**: 구체적인 구현이 아닌 추상화(인터페이스)에 의존합니다.
- **단일 책임 원칙 (Single Responsibility)**: 하나의 클래스는 하나의 변경 이유만 가져야 합니다.
- **테스트 용이성 (Testability)**: 각 계층은 독립적으로 테스트할 수 있습니다.

---

## 설정 파일 (pom.xml)

각 Kata 모듈은 Java 21 컴파일러와 JUnit 5 테스트 프레임워크를 사용하도록 설정된 `pom.xml` 파일을 가집니다.

상세한 예시는 아래 경로의 파일을 참고하세요.
- `docs/resource/pom.xml.example`
