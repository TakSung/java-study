# Python Katas 프로젝트 구조 분석 보고서

Java 버전 Katas 프로젝트 구축을 위한 현재 Python 프로젝트 구조 분석 문서입니다.

---

## 1. 문서별 역할과 구조

### 📂 docs/ 디렉토리

#### docs/index.md (네비게이션 허브)

**역할**: 전체 문서 안내서 (Table of Contents)

**주요 기능**:
- 상황별 문서 선택 가이드 제공
- 빠른 참조 테이블로 각 문서의 목적과 읽을 시점 명시
- 문서 구조 시각화 (트리 구조)
- Master Index 파일 참조 포인터

**작성 규칙**:
- 각 문서의 "언제 읽어야 하는지"를 명확히 제시
- 중복 내용 없이 참조만 제공
- 상황별 읽기 순서 제시 (예: 새 사용자, 막혔을 때, 새 Kata 시작)

**구조**:
```markdown
# Documentation Index

## Quick Navigation
| Document | Purpose | When to Read |

## [각 문서별 섹션]
- File
- Contains
- Read this when
- Complements

## Selection Guide by Situation
- I'm new to this project
- I want to start a new kata
- I'm stuck / encountering errors
- I want to understand agents
- I want to use skills
- I need command syntax

## Documentation Structure (트리 다이어그램)
```

---

#### docs/directory-structure.md (프로젝트 구조 가이드)

**역할**: 프로젝트 전체 디렉토리 구조 및 Clean Architecture 레이어 설명

**주요 내용**:

1. **Project-Wide Structure**
   - 각 디렉토리의 목적과 역할
   - `.claude/`, `.gemini/`, `agent/`, `docs/` 구조

2. **Clean Architecture Kata Structure**
   - `domain/`, `app/`, `infra/`, `ui/` 레이어
   - `hidden-number/` 참조 구현 예시

3. **Layer Responsibilities**
   - 각 레이어의 역할과 특징
   - 허용된 import 규칙 (✅/❌ 예시)

4. **Import Strategy (Absolute Imports)**
   - 절대 경로 임포트 필수
   - python-runner 스킬의 임포트 검증 기능 설명

5. **Python 3.13 Features Used**
   - `@dataclass(frozen=True)` - 불변성
   - `Protocol` - 구조적 타이핑
   - `match-case` - 패턴 매칭
   - 타입 힌트 강화

6. **Clean Architecture Principles**
   - Separation of Concerns
   - Dependency Inversion
   - Single Responsibility
   - Testability
   - Immutability

**작성 규칙**:
- 실제 코드 예시 포함 (✅ CORRECT / ❌ FORBIDDEN 형식)
- Clean Architecture 원칙을 Python 3.13 문법과 연결
- 의존성 흐름 다이어그램 포함
- 파일 명명 규칙 명시

**구조**:
```markdown
# Directory Structure

## Project-Wide Structure (트리)

## Clean Architecture Kata Structure (트리)

## Layer Responsibilities
### 1. Domain Layer
### 2. Application Layer
### 3. Infrastructure Layer
### 4. UI Layer
### 5. Entry Point (main.py)

## Dependency Flow (다이어그램)

## Import Strategy
### Absolute Imports (Required)
### Why Absolute Imports?
### Import Validation

## File Naming Conventions

## Python 3.13 Features Used

## Clean Architecture Principles

## Configuration Files
```

---

#### docs/TDD-guide.md (TDD 사이클 가이드)

**역할**: TDD 방법론과 에이전트 전환 타이밍 설명

**주요 내용**:

1. **TDD 개념 설명**
   - RED → GREEN → REFACTOR 사이클
   - 각 단계의 목적

2. **Phase별 에이전트 전환**
   - RED: Navigator (전략) → Driver (테스트 작성)
   - GREEN: Driver (최소 구현)
   - REFACTOR: Reviewer (코드 리뷰) → Driver (리팩토링 적용) → Navigator (다음 계획)

3. **에이전트별 명령어 예시**
   - 각 단계에서 사용할 프롬프트 제공
   - 예상 응답 예시

4. **Coach 호출 시점**
   - 막혔을 때, 역할 혼란 시

5. **커밋 권장 시점**

**작성 규칙**:
- 단계별 표(Table) 형식으로 요약
- 실제 명령어 예시 포함
- 각 에이전트의 역할을 명확히 구분

**구조**:
```markdown
# TDD Cycle Guide with Agent Transitions

## TDD란?

## Phase 1: RED - 실패하는 테스트 작성
### Step 1: 전략 수립 (Navigator)
### Step 2: 테스트 코드 작성 (Driver)
### Step 3: RED 확인

## Phase 2: GREEN - 테스트 통과시키기
### Step 4: 최소 구현 (Driver)
### Step 5: GREEN 확인

## Phase 3: REFACTOR - 코드 개선
### Step 6: 코드 리뷰 (Reviewer)
### Step 7: 리팩토링 적용 (Driver)
### Step 8: 다음 사이클 계획 (Navigator)

## TDD 사이클 요약표
| Phase | Step | Agent | Purpose | Command Example |

## 막혔을 때 - Coach 호출

## 커밋 권장 시점
```

---

#### docs/driver-guide.md (Driver 사용자 가이드)

**역할**: AI Navigator와 페어 프로그래밍하는 Driver(사용자) 관점의 실전 가이드

**주요 내용**:

1. **프로젝트 시작하기**
   - 처음 시작, 이어서 진행, 특정 커밋에서 시작 시 프롬프트

2. **개발 진행하기 (TDD 사이클)**
   - 작업 완료 후 다음 단계 확인
   - 테스트 검토 요청
   - 추가 구현 확인

3. **막혔을 때 질문하기**
   - 문법/개념 모를 때
   - 더 자세한 설명 필요 시
   - 테스트 함수 이름 고민
   - 파일 실행 방법

4. **오류 및 문제 해결**
   - 테스트 실행 오류
   - 코드 문법/실행 오류

5. **Navigator 조정**
   - 주도적으로 안내하지 않을 때
   - 코딩을 하려고 할 때
   - 영어로 답변하는 경우
   - 도구(Skill) 사용하지 않을 때

**작성 규칙**:
- 한국어로 작성 (사용자 대면 문서)
- 실제 사용 프롬프트를 인용구(blockquote)로 제공
- 상황별 섹션 분리 (5개 대분류)
- 친근한 톤 (이모지 사용)

**구조**:
```markdown
# Driver 가이드: AI Navigator와 효과적으로 페어 프로그래밍하기

## 🚀 1. 프로젝트 시작하기
### 처음 프로젝트를 시작할 때
### 이전 작업에 이어서 진행할 때
### 특정 지점에서 작업을 시작하고 싶을 때

## ⚙️ 2. 개발 진행하기 (TDD 사이클)
### 기능 구현 및 테스트 완료 후
### 새로운 테스트 코드에 대한 검토 요청
### 추가 구현 여부 확인

## 🤔 3. 개발 중 막혔을 때: 질문하기
### 문법 또는 개념을 모를 때
### 방향은 알겠는데 더 자세한 설명이 필요할 때
### 테스트 함수 이름이 고민될 때
### 파일 실행 방법을 모를 때

## 🐛 4. 오류 및 문제 해결
### 테스트 실행 오류가 발생했을 때
### 코드 문법/실행 오류가 발생했을 때

## 🤖 5. Navigator가 잘 동작하지 않을 때
### Navigator가 주도적으로 안내하지 않을 때
### Navigator가 코딩을 하려고 했을때
### Navigator가 영어로 답변하는 경우
### Navigator가 도구(Skill)를 사용하지 않을 때
```

---

#### docs/contributing.md (기여 가이드)

**역할**: 에이전트/스킬 추가 및 문서 관리 규칙

**주요 내용**:

1. **새 에이전트 추가**
   - 템플릿 제공
   - 인덱스 파일 업데이트 방법

2. **새 스킬 추가**
   - skill-creator 사용 (추천)
   - 수동 생성 방법

3. **문서 업데이트 규칙**
   - 200줄 목표
   - 단일 진실 공급원 (Single Source of Truth)
   - 토큰 최적화 (@ 사용 금지)

4. **문서 구조 원칙**
   - Index 파일: 네비게이션 + 빠른 참조
   - Guide 파일: 개념 교육 + 워크플로우
   - Reference 파일: 완전한 명세서

5. **AGENTS.md 업데이트 가이드**
   - 100줄 목표
   - 무엇을 넣고 뺄지 명시

**작성 규칙**:
- 체크리스트와 단계별 가이드
- ✅/❌ 형식으로 명확한 지침
- 파일 크기 제한 명시 (200-250줄)
- 버전 관리 (Last Updated 날짜)

**구조**:
```markdown
# Contributing Guide

## Adding New Agent
### 1. Create Agent File
### 2. Update Agent Index
### 3. Update AGENTS.md

## Adding New Skill
### Method 1: Use skill-creator (Recommended)
### Method 2: Manual Creation

## Updating Documentation
### File Organization Rules
### Token Optimization
### When to Split Files

## Documentation Structure Principles
### Index Files
### Guide Files
### Reference Files

## Updating AGENTS.md
### Current Structure (Target: ~100 lines)
### What NOT to put in AGENTS.md
### What to KEEP in AGENTS.md

## Versioning

## Testing Changes
```

---

### 📂 agent/sub-agent/ 디렉토리

#### agent/sub-agent/navigator.python.md (Navigator 에이전트 프롬프트)

**역할**: Navigator AI의 역할, 제약, 응답 형식 정의

**주요 구성**:

1. **ROLE**: Pair Programming Navigator, TDD/BDD 학습 지원

2. **AVAILABLE SKILLS**:
   - catchup (Git 히스토리 분석)
   - python-runner (테스트 실행, 문법 검증)

3. **SKILL USAGE PATTERNS**:
   - Proactive-Internal: 분석 후 제안 (catchup + pytest)
   - Reactive-Instructional: 사용자에게 도구 사용법 교육

4. **CORE RESPONSIBILITIES**:
   - 전략적 방향 제시 (WHAT, not HOW)
   - 테스트 우선 마인드셋
   - Git 히스토리 추적

5. **Proactive Workflow Mandate**:
   - 코드 변경/작업 완료 시 자동 검증 (git status, pytest)

6. **COMMUNICATION RULES**:
   - 한국어 응답 필수
   - 협력적 톤 (~하는 게 어때요?)
   - 직접적인 코드 솔루션 금지

7. **CONSTRAINTS**:
   - ❌ 직접 코드 솔루션 제공 금지
   - ✅ 문법 예시, 테스트 구조 제안 허용

8. **PROGRESSIVE TEACHING PATTERN (2-Step Learning)**:
   - Step 1: 개념 + 간단 예시
   - Step 2: 실제 프로젝트 코드 (명시적 요청 시)

9. **RESPONSE FORMAT**:
   ```
   <thinking>
   1. 상황 분석
   2. 다음 테스트 케이스 식별
   3. 전략적 방향 수립
   4. 협력적 표현 준비
   </thinking>

   **제안**: ...
   **근거**: ...
   ```

10. **EXAMPLES**: `navigator/examples.md` 참조

**작성 규칙**:
- 영어로 작성 (AI 프롬프트)
- 명확한 제약 조건 (❌/✅ 형식)
- 예시는 별도 파일로 분리
- 스킬 참조는 상대 경로

**구조**:
```markdown
# ROLE

# AVAILABLE SKILLS

# SKILL USAGE PATTERNS
## 1. Proactive-Internal Pattern
## 2. Reactive-Instructional Pattern

# CONTEXT

# CORE RESPONSIBILITIES

### Proactive Workflow Mandate

### Guidance Adherence

# COMMUNICATION RULES
## Language Output
## Encoding Safety

# CONSTRAINTS

## PROGRESSIVE TEACHING PATTERN (2-Step Learning)

# RESPONSE FORMAT

# EXAMPLES

# REFERENCE DOCUMENTATION
```

---

#### agent/sub-agent/navigator/examples.md (Navigator 응답 예시)

**역할**: 9가지 상황별 Navigator 응답 패턴 제공

**포함된 예시**:

1. Suggesting Next Test (다음 테스트 제안)
2. Grammar Help Request (문법 도움 요청)
3. Next Direction Guidance (다음 방향 가이드)
4. Post-Task Analysis & Next Direction (작업 완료 후 분석)
5. Starting a Kata from README (README에서 Kata 시작)
6. Next Steps with catchup Skill (catchup으로 다음 단계)
7. Concept Explanation with 2-Step Learning (2단계 학습)
8. Execution Guidance with python-runner Skill (실행 가이드)
9. Taking Notes with study-note Skill (메모 작성)

**각 예시 구조**:
```markdown
## Example N: [제목]

**User**: "[사용자 질문]"

<thinking>
1. [분석 단계]
2. [식별 단계]
3. [수립 단계]
4. [준비 단계]
</thinking>

**제안**: "[한국어 제안]"
**근거**: "[이유 설명]"

[필요시 추가 섹션]
```

**작성 규칙**:
- 사용자 질문은 한국어
- 응답은 navigator.python.md의 RESPONSE FORMAT 준수
- 스킬 활용 예시 포함 (Invoke 명령)
- 실제 git/bash 명령어 제공

---

#### agent/sub-agent/reviewer.md (Reviewer 에이전트 프롬프트)

**역할**: Refactoring Mentor, Python 3.13 고급 패턴 및 Clean Code 원칙 적용

**주요 구성**:

1. **ROLE**: Python 3.13 리팩토링 멘토

2. **INTERVENTION RULE**:
   - TDD REFACTOR 단계에서만 개입
   - RED/GREEN 단계 방해 금지

3. **CORE RESPONSIBILITIES**:
   - Code Smell 감지
   - Python 3.13 고급 패턴 제안
   - 개선 이유 설명 (WHY)
   - 점진적 리팩토링 가이드

4. **PYTHON 3.13 FOCUS AREAS**:
   - Immutability (`@dataclass(frozen=True)`)
   - Advanced Type Hints (`Protocol`, `Literal`)
   - Pattern Matching (`match-case`)
   - Functional & Monadic Patterns (`returns` 라이브러리)
   - Dependency Inversion Principle (DIP)

5. **CODE SMELLS CHECKLIST**:
   - Long Functions (긴 함수)
   - Duplicate Code (중복 코드)
   - Magic Numbers (매직 넘버)
   - Unclear Naming (불명확한 네이밍)
   - Mutable Default Arguments (가변 기본 인자)
   - Tight Coupling (강한 결합)

6. **RESPONSE FORMAT**:
   ```markdown
   <thinking>
   1. REFACTOR 단계 확인
   2. 코드 스멜 분석
   3. 가장 영향력 있는 리팩토링 기회 식별
   4. 간결한 교육적 설명 작성
   </thinking>

   **발견된 스멜**: [한국어]
   **개선 제안**: [한국어]
   **핵심 이점**: [1-2문장, 한국어]
   **적용 코드**:
   # Before
   ...
   # After
   ...
   ```

7. **EXAMPLES**: 8가지 리팩토링 예시
   - Immutability with Dataclass
   - Pattern Matching for Complex Conditions
   - Type Hints for Clarity
   - Monadic Pattern for None Handling
   - Magic Number Elimination
   - Long Function Refactoring
   - Dependency Inversion with Protocol
   - Refactoring with Monads (returns library)

**작성 규칙**:
- 영어로 작성 (AI 프롬프트)
- 한국어 응답 (멘토 톤)
- Before/After 코드 비교
- UTF-8 인코딩 주석
- WHY에 집중 (간결하게 1-2문장)

**구조**:
```markdown
# ROLE

# INTERVENTION RULE

# CONTEXT

# CORE RESPONSIBILITIES

# COMMUNICATION RULES
## Language Output
## Encoding Safety

# PYTHON 3.13 FOCUS AREAS
## 1. Immutability
## 2. Advanced Type Hints
## 3. Pattern Matching
## 4. Functional & Monadic Patterns
## 5. Dependency Inversion Principle

# CODE SMELLS CHECKLIST

# RESPONSE FORMAT

# EXAMPLES
## Example 1: Immutability with Dataclass
## Example 2: Pattern Matching
## Example 3: Type Hints
## Example 4: Monadic Pattern
## Example 5: Magic Number Elimination
## Example 6: Long Function Refactoring
## Example 7: Dependency Inversion with Protocol
## Example 8: Refactoring with Monads
```

---

## 2. 파일 간 관계 및 참조 구조

```
AGENTS.md (마스터 인덱스, ~100줄 목표)
    ├─ references → agent/sub-agent/index.md (에이전트 명세)
    ├─ references → agent/skills/index.md (스킬 인덱스)
    ├─ references → docs/index.md (문서 네비게이션)
    └─ contains: 시스템 개요, 기술 스택, 설정 팁

docs/index.md (문서 네비게이션 허브)
    ├─ points to → docs/driver-guide.md (사용자 가이드)
    ├─ points to → docs/TDD-guide.md (TDD 사이클)
    ├─ points to → docs/directory-structure.md (구조 가이드)
    └─ points to → docs/contributing.md (기여 가이드)

agent/sub-agent/navigator.python.md (에이전트 프롬프트)
    ├─ references → agent/sub-agent/navigator/examples.python.md
    ├─ references → ../../.claude/skills/catchup/SKILL.md
    ├─ references → ../../.claude/skills/python-runner/SKILL.md
    └─ references → ../../docs/driver-guide.md

agent/sub-agent/reviewer.md (에이전트 프롬프트)
    └─ contains: 완전한 예시 (별도 파일 없음)

docs/TDD-guide.md
    ├─ references → agent/sub-agent/index.md
    └─ references → docs/directory-structure.md

docs/driver-guide.md
    └─ references → agent/sub-agent/navigator.md (암묵적)

docs/contributing.md
    ├─ references → AGENTS.md
    └─ references → all index files
```

---

## 3. 작성 규칙 및 원칙

### 📏 일반 원칙

| 원칙 | 설명 |
|------|------|
| **200줄 목표** | 파일은 가능한 200줄 이내로 유지 (250줄 초과 시 분리 고려) |
| **단일 진실 공급원** | 같은 내용을 여러 곳에 중복하지 않음 |
| **참조 우선** | 반복보다 파일 경로 참조 사용 |
| **토큰 최적화** | `@` 심볼 사용 금지, 상대 경로만 제공 |
| **언어 구분** | AI 프롬프트는 영어, 사용자 대면 문서는 한국어 |

---

### 📝 문서 타입별 규칙

#### Index 파일 (예: docs/index.md, agent/sub-agent/index.md)

**포함할 내용**:
- ✅ 네비게이션 테이블
- ✅ 빠른 참조 요약
- ✅ "언제 읽어야 하는지" 가이드
- ✅ 문서 구조 트리

**포함하지 않을 내용**:
- ❌ 전체 내용 복사
- ❌ 상세한 예시 (별도 파일로)

---

#### Guide 파일 (예: TDD-guide.md, driver-guide.md)

**포함할 내용**:
- ✅ 개념 설명
- ✅ 워크플로우 예시
- ✅ 문제 해결 팁
- ✅ 실제 명령어/프롬프트 제공

**포함하지 않을 내용**:
- ❌ 인덱스 정보 중복
- ❌ 다른 가이드의 내용 반복

---

#### Reference 파일 (예: navigator.md, reviewer.md)

**포함할 내용**:
- ✅ 완전한 명세서
- ✅ 모든 디테일
- ✅ 예시는 별도 파일 분리 가능

**포함하지 않을 내용**:
- ❌ 요약 정보 (인덱스에 위치)
- ❌ 사용자 가이드 내용

---

### 🎨 에이전트 프롬프트 작성 규칙

#### 표준 구조

```markdown
# ROLE
[1-2문장 역할 정의]

# AVAILABLE SKILLS
[상대 경로로 스킬 참조]

# CONTEXT
- [핵심 컨텍스트 3-5개]

# CORE RESPONSIBILITIES
1. **[책임 1]**: [설명]
2. **[책임 2]**: [설명]

# COMMUNICATION RULES
## Language Output
- **ALWAYS respond in Korean (한국어)**
- Use [tone]: "[example phrases]"

## Encoding Safety
- Always include `# -*- coding: utf-8 -*-`
- Ensure UTF-8 encoding

# [SPECIFIC FOCUS AREAS]
## 1. [Focus Area 1]
- [Details]

# RESPONSE FORMAT
[Define expected response structure]

# EXAMPLES
[Provide 3-5 examples with <thinking> tags]
또는 별도 파일 참조
```

#### 제약 표현 규칙

```markdown
# CONSTRAINTS
- ❌ [금지 사항 1]
- ❌ [금지 사항 2]
- ✅ OK: [허용 사항 1]
- ✅ OK: [허용 사항 2]
```

#### 예시 구조

```markdown
## Example N: [제목]

**User**: "[사용자 입력]"

<thinking>
1. [분석 단계]
2. [계획 단계]
3. [실행 단계]
</thinking>

**[응답 헤더]**: [내용]
**[응답 헤더]**: [내용]
```

#### 스킬 참조 형식

```markdown
# AVAILABLE SKILLS

../../.claude/skills/catchup/SKILL.md
../../.claude/skills/python-runner/SKILL.md
```

---

### 🔍 Clean Architecture 관련 규칙

#### 레이어별 Import 규칙

| 레이어 | 허용 Import | 금지 Import |
|--------|------------|------------|
| **Domain** | `dataclasses`, `typing` (표준 라이브러리만) | 외부 의존성 전체 |
| **App** | `domain/`, `typing.Protocol` | `infra/`, `ui/` (구체적 구현) |
| **Infra** | `domain/`, `app/`, 외부 라이브러리 | - |
| **UI** | `domain/`, `app/`, GUI 라이브러리 | `infra/` (직접 의존 금지) |

#### 절대 경로 Import 필수

```python
# ✅ CORRECT
from hidden-number.domain.game import Game
from hidden-number.app.game_service import GameService

# ❌ FORBIDDEN
from .domain.game import Game  # 상대 경로
from domain.game import Game    # 패키지 prefix 누락
```

#### 의존성 흐름

```
Domain Layer (domain/)
    ↑ depends on (imports from)
Application Layer (app/)
    ↑ depends on
Infrastructure Layer (infra/)
    ↑ implements
UI Layer (ui/) / Entry Point (main.py)
```

**핵심 원칙**:
- 의존성은 항상 안쪽(domain)을 향함
- Domain은 외부에 대해 아무것도 모름
- Infrastructure는 Protocol을 통해 추상화됨

---

### 🐍 Python 3.13 기능 활용 패턴

#### 1. 불변성 (Immutability)

```python
from dataclasses import dataclass, replace

@dataclass(frozen=True)
class Game:
    answer: int
    attempts: int

# 상태 변경 시 새 객체 생성
new_game = replace(game, attempts=game.attempts + 1)
```

#### 2. Protocol (의존성 역전)

```python
from typing import Protocol

class RandomGenerator(Protocol):
    def randint(self, a: int, b: int) -> int:
        ...

# 구체적 구현
class SystemRandomGenerator:
    def randint(self, a: int, b: int) -> int:
        import random
        return random.randint(a, b)
```

#### 3. 패턴 매칭 (Pattern Matching)

```python
match guess:
    case g if g > game.answer:
        return "Too High"
    case g if g < game.answer:
        return "Too Low"
    case _:
        return "Correct"
```

#### 4. 고급 타입 힌트

```python
from typing import Literal, Optional

def make_guess(game: Game, guess: int) -> GuessResult:
    ...

def find_game(id: str) -> Game | None:  # Union type
    ...

def process(mode: Literal["sum", "max"]) -> float:
    ...
```

---

## 4. Java 버전 전환 시 고려사항

### 🔄 직접 매핑 가능한 요소

| Python | Java 대응 | 비고 |
|--------|-----------|------|
| `@dataclass(frozen=True)` | `record` (Java 16+) | 또는 `@Value` (Lombok) |
| `typing.Protocol` | `interface` | 구조적 타이핑 → 명시적 인터페이스 |
| `match-case` | `switch` expression (Java 17+) | Pattern matching 지원 |
| `pytest` | JUnit 5 + AssertJ | 테스트 프레임워크 |
| `uv` | Maven / Gradle | 빌드 도구 |
| `pyproject.toml` | `pom.xml` / `build.gradle` | 프로젝트 설정 |
| `None` | `Optional<T>` | Null 처리 |
| `|` (Union type) | Generic 제네릭 | 타입 표현 |

---

### 🧩 구조적 변경 필요 사항

#### 1. 파일/패키지 구조

**Python**:
```
hidden-number/
├── domain/
│   └── game.py
├── app/
│   └── game_service.py
├── infra/
│   └── random_generator.py
└── ui/
    └── tkinter_ui.py
```

**Java**:
```
src/
├── main/java/com/kata/hiddennumber/
│   ├── domain/
│   │   └── Game.java
│   ├── app/
│   │   └── GameService.java
│   ├── infra/
│   │   └── RandomNumberGenerator.java
│   └── ui/
│       └── SwingUI.java
└── test/java/com/kata/hiddennumber/
    ├── domain/
    │   └── GameTest.java
    └── app/
        └── GameServiceTest.java
```

---

#### 2. 불변성 구현

**Python**:
```python
@dataclass(frozen=True)
class Game:
    answer: int
    attempts: int

# 상태 변경
new_game = replace(game, attempts=game.attempts + 1)
```

**Java 16+**:
```java
public record Game(int answer, int attempts) {
    // 상태 변경
    public Game incrementAttempts() {
        return new Game(answer, attempts + 1);
    }
}
```

**Java 14 이하 (Lombok)**:
```java
@Value
public class Game {
    int answer;
    int attempts;

    public Game incrementAttempts() {
        return new Game(answer, attempts + 1);
    }
}
```

---

#### 3. Protocol → Interface

**Python**:
```python
from typing import Protocol

class RandomGenerator(Protocol):
    def randint(self, a: int, b: int) -> int:
        ...
```

**Java**:
```java
public interface RandomGenerator {
    int randint(int a, int b);
}

// 구현
public class SystemRandomGenerator implements RandomGenerator {
    private final Random random = new Random();

    @Override
    public int randint(int a, int b) {
        return random.nextInt(b - a + 1) + a;
    }
}
```

---

#### 4. 의존성 주입

**Python** (수동 DI):
```python
# main.py
def main():
    random_gen = RandomNumberGenerator()
    service = GameService(random_gen)
    ui = HiddenNumberUI(service)
    ui.run()
```

**Java** (Spring Framework):
```java
@Configuration
public class AppConfig {
    @Bean
    public RandomGenerator randomGenerator() {
        return new SystemRandomGenerator();
    }

    @Bean
    public GameService gameService(RandomGenerator randomGenerator) {
        return new GameService(randomGenerator);
    }

    @Bean
    public SwingUI ui(GameService gameService) {
        return new SwingUI(gameService);
    }
}
```

---

#### 5. 테스트 프레임워크

**Python (pytest)**:
```python
def test_guess_higher_than_answer():
    # Given
    game = Game(answer=50, attempts=0)
    service = GameService()

    # When
    result = service.make_guess(game, 70)

    # Then
    assert result.message == "Too High"
    assert result.game.attempts == 1
```

**Java (JUnit 5 + AssertJ)**:
```java
@Test
void testGuessHigherThanAnswer() {
    // Given
    Game game = new Game(50, 0);
    GameService service = new GameService();

    // When
    GuessResult result = service.makeGuess(game, 70);

    // Then
    assertThat(result.getMessage()).isEqualTo("Too High");
    assertThat(result.getGame().attempts()).isEqualTo(1);
}
```

---

### 📋 문서 변경 사항

| 문서 | 변경 필요 내용 |
|------|---------------|
| **docs/directory-structure.md** | - Java 패키지 구조<br>- Maven/Gradle 설정<br>- `src/main/java`, `src/test/java` 구조 |
| **agent/sub-agent/reviewer.md** | - Java 리팩토링 패턴<br>- Stream API<br>- Optional 사용<br>- record 활용 |
| **docs/TDD-guide.md** | - JUnit 5 명령어<br>- `mvn test` / `./gradlew test`<br>- AssertJ 사용 패턴 |
| **agent/sub-agent/navigator.md** | - Java 문법 예시<br>- interface 설명<br>- record 예시 |
| **.claude/skills/python-runner/** | - `java-runner` 스킬로 대체<br>- 컴파일 검증 (`javac`)<br>- 테스트 실행 (`mvn test`) |

---

### 🔧 기술 스택 변경

| 항목 | Python | Java |
|------|--------|------|
| **언어 버전** | Python 3.13 | Java 17+ (record, switch expression) |
| **빌드 도구** | uv | Maven / Gradle |
| **테스트** | pytest | JUnit 5 + AssertJ |
| **GUI** | Tkinter | Swing / JavaFX |
| **불변성** | `@dataclass(frozen=True)` | `record` / `@Value` |
| **DI** | 수동 DI (main.py) | Spring Framework / Dagger |
| **타입** | Duck typing + Protocol | Static typing + interface |

---

## 5. 핵심 인사이트

### ✨ 이 구조의 강점

1. **명확한 역할 분리**
   - Navigator (전략), Driver (구현), Reviewer (개선)
   - TDD 사이클과 에이전트 역할 완벽 매핑

2. **교육적 설계**
   - 2-Step Learning Pattern (개념 → 코드)
   - Progressive Disclosure (점진적 정보 공개)

3. **토큰 효율성**
   - 200줄 목표
   - 참조 우선 (반복 최소화)
   - @ 사용 금지 (자동 로드 방지)

4. **Clean Architecture 강제**
   - 레이어별 import 규칙 명시
   - python-runner 스킬로 검증 자동화
   - Protocol을 통한 DIP 구현

5. **스킬 시스템**
   - catchup (Git 분석)
   - python-runner (테스트/검증)
   - 에이전트가 능동적으로 활용

---

### 🎯 Java 전환 시 유지할 핵심

#### 구조적 요소
- ✅ TDD 사이클 (RED-GREEN-REFACTOR)
- ✅ 에이전트 역할 분리 (Navigator-Driver-Reviewer-Coach)
- ✅ Clean Architecture 레이어 (domain-app-infra-ui)
- ✅ 절대 경로 import 전략

#### 문서 원칙
- ✅ Index-Guide-Reference 구조
- ✅ 200줄 목표
- ✅ 단일 진실 공급원
- ✅ 참조 우선 원칙

#### 교육 패턴
- ✅ 2-Step Learning Pattern
- ✅ Proactive Workflow Mandate
- ✅ `<thinking>` 태그로 사고 과정 공개

---

### 🚀 Java 전환 시 새로운 기회

1. **정적 타입 시스템 활용**
   - 컴파일 타임 타입 체크
   - IDE 지원 강화 (IntelliJ IDEA)

2. **풍부한 DI 프레임워크**
   - Spring Framework
   - 자동 의존성 관리

3. **강력한 빌드 도구**
   - Maven/Gradle 플러그인 생태계
   - 멀티 모듈 프로젝트 지원

4. **Enterprise 패턴**
   - DAO/Repository 패턴
   - Service Layer 패턴
   - DTO 활용

---

## 6. 요약

### 핵심 문서 구조

```
AGENTS.md (시스템 개요, ~100줄)
    └─ references to...

docs/
├── index.md (네비게이션 허브)
├── directory-structure.md (구조 가이드)
├── TDD-guide.md (TDD 사이클)
├── driver-guide.md (사용자 가이드, 한국어)
└── contributing.md (기여 가이드)

agent/sub-agent/
├── index.md (에이전트 인덱스)
├── navigator.python.md (전략, WHAT)
│   └── navigator/examples.python.md (9가지 예시)
├── reviewer.md (리팩토링, REFACTOR)
└── paircoding-coach.md (중재, 막혔을 때)
```

### 핵심 원칙

1. **200줄 목표** - 간결성
2. **참조 우선** - 중복 방지
3. **역할 분리** - TDD와 에이전트 매핑
4. **Clean Architecture** - 레이어별 책임
5. **토큰 최적화** - @ 금지, 상대 경로

### Java 전환 체크리스트

- [ ] 패키지 구조 변경 (`com.kata.hiddennumber`)
- [ ] 불변성 구현 (`record` / `@Value`)
- [ ] Protocol → interface 변환
- [ ] pytest → JUnit 5 + AssertJ
- [ ] python-runner → java-runner 스킬 개발
- [ ] 문서 업데이트 (예시 코드, 명령어)
- [ ] DI 프레임워크 선택 (Spring / 수동)

---

**Last Updated**: 2025-12-18
