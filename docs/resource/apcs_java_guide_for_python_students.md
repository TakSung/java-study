## APCS A를 위한 Java 학습 가이드 (Python 학생용)

이 문서는 파이썬 학습자가 APCS (Advanced Placement Computer Science) A 시험을 준비하고 자바로 코드를 포팅하는 데 필요한 학습 내용을 안내합니다. 최대한 많은 코딩을 경험하며 APCS A 취득에 어려움이 없도록 하는 데 중점을 둡니다.

### 목차
1.  [학습 목표 및 접근 방식](#1-학습-목표-및-접근-방식)
2.  [Java 기본기 다지기](#2-java-기본기-다지기)
3.  [APCS A 핵심 자료구조 및 알고리즘](#3-apcs-a-핵심-자료구조-및-알고리즘)
4.  [문제 해결 및 코딩 연습](#4-문제-해결-및-코딩-연습)
5.  [학습 자료](#5-학습-자료)
6.  [Python 개발자를 위한 추가 팁](#6-python-개발자를-위한-추가-팁)

---

### 1. 학습 목표 및 접근 방식

*   **APCS A의 범위 이해:** College Board에서 제공하는 AP Computer Science A Course and Exam Description (CED) 문서를 철저히 검토하여 시험에서 요구하는 모든 주제와 스킬을 숙지해야 합니다. 이 문서는 시험의 청사진입니다.
*   **실습 중심 학습:** 이론 학습과 병행하여 **반드시** 코딩 실습에 집중해야 합니다. APCS A는 문제 해결 능력과 Java 코드를 효과적으로 작성하는 능력을 평가합니다.
*   **Python 코드 Java로 포팅 연습:** 파이썬으로 작성된 간단한 알고리즘이나 자료구조 코드를 Java로 직접 포팅하는 연습을 꾸준히 합니다. 이는 두 언어의 근본적인 차이점을 체감하고 Java 문법에 익숙해지는 데 매우 효과적인 방법입니다.

### 2. Java 기본기 다지기

파이썬과 자바의 주요 차이점을 인지하고 자바의 기초 문법과 개념을 확실히 다져야 합니다.

*   **Java 문법 및 기본 개념:**
    *   **강타입 언어의 이해 (Static Typing):** 파이썬의 동적 타이핑(Dynamic Typing)과 달리 자바는 모든 변수에 `int`, `double`, `boolean`, `String` 등 명시적인 타입 선언이 필요합니다. 기본 타입(primitive types)과 참조 타입(reference types)의 차이를 명확히 이해해야 합니다.
    *   **엄격한 구문 규칙 (Strict Syntax):** 모든 문장의 끝에는 세미콜론(;)이 필요하며, 코드 블록은 중괄호({})로 정의됩니다. `public static void main(String[] args)`와 같은 기본 프로그램 구조에 익숙해져야 합니다.
    *   **클래스와 객체 (Classes and Objects):** 자바의 모든 실행 가능한 코드는 클래스 내부에 존재합니다. 클래스 정의, 객체 생성 (`new` 키워드), 필드(인스턴스 변수), 메서드, 생성자 (`this` 키워드 포함)의 개념을 완벽히 이해해야 합니다.
    *   **접근 제어자 (Access Modifiers):** `public`, `private` 키워드의 역할과 사용법을 숙지합니다. APCS A에서는 주로 이 두 가지를 다룹니다.
    *   **표준 입출력 (Standard I/O):** `System.out.println()`을 통한 출력과 `java.util.Scanner` 클래스를 이용한 사용자 입력 처리를 연습합니다.
*   **제어문 및 루프 (Control Structures and Loops):** `if-else`, `switch` 문, `while` 루프, `for` 루프(특히 `for-each` 루프), 중첩 루프 사용법을 숙달합니다.

### 3. APCS A 핵심 자료구조 및 알고리즘

APCS A 시험에서 가장 중요하게 다루는 자료구조와 알고리즘에 집중하여 학습합니다.

*   **배열 (Arrays):**
    *   선언, 초기화, 요소 접근, 순회(traverse) 방법을 익힙니다.
    *   고정된 크기라는 특징과 `length` 속성을 이해합니다.
    *   1차원 및 2차원 배열의 활용법과 관련 알고리즘(예: 최대/최소 찾기, 합계 계산)을 연습합니다.
*   **ArrayList:**
    *   자바에서 배열의 한계를 보완하는 동적 배열(`java.util.ArrayList`)의 개념과 사용법을 배웁니다.
    *   주요 메서드 (`add`, `remove`, `get`, `set`, `size`)를 숙지하고 활용합니다.
    *   `ArrayList`에 기본 타입을 저장하기 위한 래퍼 클래스(`Integer`, `Double` 등)의 필요성(autoboxing/unboxing)을 이해하고 사용합니다.
*   **검색 및 정렬 알고리즘 (Searching and Sorting Algorithms):**
    *   선형 검색(Sequential Search)과 이진 검색(Binary Search)의 원리 및 Java 구현을 학습합니다.
    *   선택 정렬(Selection Sort), 삽입 정렬(Insertion Sort), 병합 정렬(Merge Sort) 등 APCS A에서 다루는 기본적인 정렬 알고리즘을 이해하고 직접 구현해봅니다.
*   **재귀 (Recursion):** 재귀의 기본 원리, 종료 조건(base case), 재귀 호출(recursive step)을 이해하고, 간단한 재귀 문제를 자바로 해결해봅니다 (예: 팩토리얼, 피보나치 수열).

### 4. 문제 해결 및 코딩 연습

*   **APCS A 예제 문제 풀이:** College Board에서 제공하는 과거 시험 문제, 샘플 문제, Free-Response Question(FRQ)들을 풀어봅니다. 이는 시험 형식과 요구 사항에 익숙해지는 데 가장 중요합니다.
*   **온라인 코딩 플랫폼 활용:** HackerRank, LeetCode, 백준 온라인 저지 등에서 Java로 알고리즘 문제를 풀어보며 실력을 향상시킵니다. 특히 파이썬으로 풀었던 문제들을 Java로 다시 풀어보는 것이 매우 효과적입니다.
*   **디버깅 연습:** IDE(IntelliJ IDEA, Eclipse 등)의 디버깅 기능을 활용하여 코드의 오류를 찾고 수정하는 연습을 합니다.

### 5. 학습 자료

*   **공식 문서:** AP Computer Science A Course and Exam Description (CED)는 가장 중요한 학습 자료입니다.
    *   [APCS Course and Exam Description (PDF)](https://apcentral.collegeboard.org/media/pdf/ap-computer-science-a-course-and-exam-description.pdf)
*   **Java 교재/온라인 튜토리얼:** 초보자를 위한 Java 프로그래밍 서적이나 Oracle Java 자습서, Codecademy, 생활코딩 같은 온라인 강좌를 활용하여 기본기를 탄탄히 다집니다.
*   **APCS A 전용 교재:** Barron's AP Computer Science A, Princeton Review AP Computer Science A 등 APCS A 시험 대비를 위한 전문 교재를 참고합니다.

### 6. Python 개발자를 위한 추가 팁

*   **IDE 사용 습관화:** 파이썬은 가벼운 에디터로도 개발이 가능하지만, 자바는 강력한 IDE(IntelliJ IDEA, Eclipse)를 사용하는 것이 생산성 향상과 디버깅에 필수적입니다.
*   **오류 메시지 분석:** 자바 컴파일 에러나 런타임 에러는 파이썬보다 상세하게 나오지만, 처음에는 어려울 수 있습니다. 오류 메시지를 주의 깊게 읽고 이해하려는 노력을 해야 합니다.
*   **객체 지향적 사고 방식 전환:** 파이썬에서는 클래스를 사용하지 않고도 많은 작업을 할 수 있었지만, 자바에서는 모든 것을 객체(클래스) 중심으로 생각해야 합니다. 이 패러다임 전환이 중요합니다.
*   **메모리 관리 및 참조 이해:** 자바는 가비지 컬렉션을 제공하지만, 객체 참조와 메모리 할당 방식(특히 `NullPointerException` 방지)을 이해하는 것이 중요합니다.
