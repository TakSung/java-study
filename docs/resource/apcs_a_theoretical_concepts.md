## APCS A 학습을 위한 핵심 이론 정리

이 문서는 APCS A 시험의 각 단원에서 다루는 주요 이론적 개념들을 요약하여 제공합니다. 코딩 실습 전후에 각 개념에 대한 깊이 있는 이해를 돕기 위해 작성되었습니다.

### 목차
1.  [Unit 1: 객체와 메서드 사용 (Using Objects and Methods)](#unit-1)
2.  [Unit 2: 선택과 반복 (Selection and Iteration)](#unit-2)
3.  [Unit 3: 클래스 생성 (Class Creation)](#unit-3)
4.  [Unit 4: 데이터 컬렉션 (Data Collections)](#unit-4)

---

### <a name="unit-1"></a>Unit 1: 객체와 메서드 사용 (Using Objects and Methods)
*   **변수와 데이터 타입 (Variables and Data Types):**
    *   **기본 타입 (Primitive Types):** `int`, `double`, `boolean` 등 메모리에 실제 값을 저장하는 타입의 개념과 각 타입이 표현할 수 있는 값의 범위를 이해합니다.
    *   **참조 타입 (Reference Types):** `String` 이나 다른 객체들처럼 메모리 주소(참조)를 저장하는 타입의 개념을 이해합니다. `null`의 의미를 파악합니다.
*   **객체와 클래스 (Objects and Classes):**
    *   **클래스:** 객체를 만들기 위한 "설계도" 또는 "틀"의 개념을 이해합니다.
    *   **객체:** 클래스로부터 생성된 "실체"이며, 고유한 상태(state)와 행동(behavior)을 가짐을 이해합니다. (예: `String` 객체)
*   **메서드와 매개변수 (Methods and Parameters):**
    *   **메서드:** 특정 작업을 수행하는 코드 블록으로, 객체의 행동(behavior)을 정의함을 이해합니다.
    *   **매개변수 전달:** 메서드 호출 시 값을 전달하는 원리(pass-by-value)와 참조 타입 변수가 전달될 때의 동작 방식을 이해합니다.
*   **표현식과 연산자 (Expressions and Operators):** 산술, 관계, 논리 연산자의 우선순위와 결합 법칙을 이해하여 복잡한 표현식의 결과를 예측할 수 있어야 합니다.

### <a name="unit-2"></a>Unit 2: 선택과 반복 (Selection and Iteration)
*   **불리언 로직 (Boolean Logic):**
    *   `if`문과 `while`문의 조건식으로 사용되는 불리언 표현식(`true`/`false`)을 이해합니다.
    *   `&&`(AND), `||`(OR), `!`(NOT) 논리 연산자와 드 모르간의 법칙(De Morgan's Laws)을 활용하여 복잡한 조건을 단순화하는 방법을 이해합니다.
*   **알고리즘 분석 (Algorithm Analysis):**
    *   반복문(loops)이 알고리즘의 실행 시간에 어떤 영향을 미치는지 비공식적으로 분석합니다. 루프의 반복 횟수를 기준으로 효율성을 비교하는 개념을 이해합니다.

### <a name="unit-3"></a>Unit 3: 클래스 생성 (Class Creation)
*   **객체 지향 프로그래밍 (OOP) 원칙:**
    *   **추상화 (Abstraction):** 복잡한 현실 세계의 요소를 단순화하여 핵심적인 속성과 기능만으로 표현하는 개념을 이해합니다.
    *   **캡슐화 (Encapsulation):** 데이터(필드)와 그 데이터를 처리하는 메서드를 하나로 묶고, 외부로부터 데이터를 보호(정보 은닉)하는 개념을 `private` 접근 제어자를 통해 이해합니다.
*   **클래스 설계 (Class Design):**
    *   **필드 (Fields / Instance Variables):** 객체의 상태(state)를 나타내는 데이터입니다.
    *   **메서드 (Methods):** 객체의 행동(behavior)을 정의합니다.
    *   **생성자 (Constructors):** 객체가 생성될 때 필드를 초기화하는 특수한 메서드의 역할을 이해합니다.
    *   **`static`의 개념:** 클래스에 속하며 모든 객체가 공유하는 변수(`static` 변수)와 메서드(`static` 메서드)의 개념을 인스턴스 멤버와 비교하여 이해합니다.

### <a name="unit-4"></a>Unit 4: 데이터 컬렉션 (Data Collections)
*   **자료구조 (Data Structures):**
    *   **배열 (Arrays):** 동일한 타입의 데이터를 연속된 메모리 공간에 저장하는 고정 크기 자료구조의 개념을 이해합니다. 인덱스를 통한 빠른 접근의 장점을 파악합니다.
    *   **ArrayList:** 내부적으로 배열을 사용하지만 크기가 동적으로 조절되는 리스트 자료구조의 개념과 장단점을 배열과 비교하여 이해합니다.
*   **알고리즘 (Algorithms):**
    *   **검색 (Searching):**
        *   **선형 검색 (Linear/Sequential Search):** 처음부터 끝까지 순차적으로 탐색하는 방법의 원리와 시간 복잡도(O(n))를 이해합니다.
        *   **이진 검색 (Binary Search):** **정렬된** 데이터에서 탐색 범위를 절반씩 줄여나가며 탐색하는 방법의 원리와 시간 복잡도(O(log n))를 이해합니다.
    *   **정렬 (Sorting):**
        *   **선택 정렬 (Selection Sort), 삽입 정렬 (Insertion Sort):** 기본적인 O(n^2) 시간 복잡도를 갖는 정렬 알고리즘들의 동작 원리를 단계별로 추적하고 이해합니다.
        *   **병합 정렬 (Merge Sort):** 분할 정복(Divide and Conquer) 전략을 사용하는 O(n log n) 시간 복잡도의 효율적인 정렬 알고리즘의 원리를 이해합니다.
*   **재귀 (Recursion):**
    *   어떤 문제를 자기 자신을 호출하는 더 작은 단위의 동일한 문제로 나누어 해결하는 프로그래밍 기법을 이해합니다.
    *   **종료 조건 (Base Case):** 재귀 호출이 멈추는 조건을 명확히 하는 것의 중요성을 이해합니다.

---
