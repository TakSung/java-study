---
name: study-note
description: 학습 중 떠오른 아이디어와 메모를 아카이브 파일에 시간순으로 기록합니다. `scripts/study-note-helper.sh`를 사용하여 현재 LESSON 프로젝트의 docs/study/아카이브.md에 노트를 추가합니다.
allowed-tools: Bash
---

# Study Note - 학습 노트 기록 스킬

이 스킬은 `scripts/study-note-helper.sh` 스크립트를 사용하여 학습 과정에서 떠오른 아이디어, 메모, 질문을 체계적으로 아카이브에 기록합니다.

모든 노트는 **스택 형식**(LIFO - Last In First Out)으로 파일 끝에 추가되어, 최신 노트가 아래쪽에 위치합니다. 각 노트에는 타임스탬프가 자동으로 추가됩니다.

## 주요 기능

- **자동 경로 해결**: `.katarc`에서 `CURRENT_LESSON`을 읽어 대상 레슨 자동 결정
- **타임스탬프 자동 생성**: KST(한국 표준시) 기준으로 기록 시점 추가
- **키워드 태깅**: 나중에 검색 가능하도록 키워드 지정
- **UTF-8 인코딩**: 한글 학습 내용 완벽 지원
- **자동 파일 초기화**: 아카이브 파일이 없으면 자동 생성
- **레슨별 독립 아카이브**: 각 레슨마다 별도의 아카이브 파일 관리

## 파일 위치

```
${CURRENT_LESSON}/docs/study/아카이브.md
```

예시: `01-hello-world/docs/study/아카이브.md`

## 명령어

모든 기능은 `./scripts/study-note-helper.sh`를 통해 접근합니다.

| 작업 | 명령어 | 설명 |
|---|---|---|
| **노트 추가** | `./scripts/study-note-helper.sh add --keyword "<키워드>" --content "<내용>"` | 현재 레슨의 아카이브에 새 학습 노트를 추가합니다. |
| **키워드 검색** | `./scripts/study-note-helper.sh search --keyword "<키워드>"` | 특정 키워드를 포함하는 모든 노트를 검색합니다. |
| **키워드 통계** | `./scripts/study-note-helper.sh stats` | 모든 키워드의 사용 빈도를 확인합니다. |
| **도움말** | `./scripts/study-note-helper.sh help` | 사용법을 확인합니다. |

### 인자 설명

**add 명령어:**
- `--keyword`: 노트를 분류할 키워드 (쉼표로 구분하여 여러 개 가능)
  - 예: `"변수, 타입"`, `"조건문, if-else"`, `"배열"`
- `--content`: 학습 내용, 아이디어, 질문 등 (자유 형식)
  - 여러 줄도 가능 (따옴표로 감싸기)

**search 명령어:**
- `--keyword`: 검색할 키워드 (대소문자 구분 안 함)
  - 부분 일치로 검색됩니다 (예: "변수"로 "변수, 타입" 검색 가능)

---

## 아카이브 파일 형식

```markdown
# 학습 아카이브

이 파일은 학습 중 떠오른 아이디어, 메모, 질문을 시간순으로 기록합니다.

---

# [2025-12-24 14:30:00 KST]

**키워드**: 변수, 타입

**내용**: Java에서 int는 4바이트 정수형이다. 범위는 -2^31 ~ 2^31-1이다.

---

# [2025-12-24 15:45:22 KST]

**키워드**: 조건문, if-else

**내용**: if-else 문을 사용하여 조건부 실행을 구현할 수 있다. else if로 여러 조건을 체크할 수 있다.

---
```

---

## 사용 예시

### 예시 1: 개념 학습 중 메모

**사용자 요청:**
> "Java의 변수 타입에 대해 배웠는데 이걸 노트에 기록해줘. int는 4바이트 정수형이야."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh add --keyword "변수, 타입, int" --content "Java에서 int는 4바이트 정수형이다. 범위는 -2^31 ~ 2^31-1이다."
```

### 예시 2: 코드 작성 중 발견한 패턴

**사용자 요청:**
> "조건문 사용할 때 중괄호를 항상 쓰는 게 좋다는 걸 배웠어. 이거 아카이브에 남겨줘."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh add --keyword "조건문, 코딩 스타일" --content "if 문에서 한 줄이어도 중괄호를 항상 사용하는 것이 좋은 습관이다. 코드 가독성과 유지보수에 도움된다."
```

### 예시 3: 실수 기록

**사용자 요청:**
> "== 와 = 를 헷갈려서 컴파일 에러가 났어. 이거 기록해줘."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh add --keyword "실수, 연산자" --content "조건문에서 ==를 써야 하는데 =를 써서 컴파일 에러 발생. ==는 비교 연산자, =는 대입 연산자임을 기억하자."
```

### 예시 4: 질문이나 TODO 항목

**사용자 요청:**
> "배열의 크기를 동적으로 변경할 수 있는지 나중에 알아봐야겠어. TODO로 남겨줘."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh add --keyword "TODO, 배열" --content "질문: Java 배열의 크기를 동적으로 변경할 수 있는지? ArrayList와 차이점은? 다음 학습 세션에서 조사 필요."
```

### 예시 5: 키워드로 노트 검색

**사용자 요청:**
> "변수 관련 노트들 다시 보고 싶어. 검색해줘."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh search --keyword "변수"
```

**출력 예시:**
```
ℹ  현재 레슨: 01-hello-world
ℹ  키워드 '변수' 검색 중...

# [2025-12-24 14:30:00 KST]
**키워드**: 변수, 타입, int
**내용**: Java에서 int는 4바이트 정수형이다. 범위는 -2^31 ~ 2^31-1이다.
---

✅ 총 1개의 노트를 찾았습니다.
```

### 예시 6: 키워드 사용 통계 확인

**사용자 요청:**
> "어떤 주제를 많이 공부했는지 통계 보여줘."

**스킬 동작:**
```bash
./scripts/study-note-helper.sh stats
```

**출력 예시:**
```
ℹ  현재 레슨: 01-hello-world
ℹ  키워드 통계 분석 중...

키워드 사용 빈도:

    3회 | 변수
    2회 | 조건문
    2회 | 타입
    1회 | 배열
    1회 | 연산자

✅ 총 5개의 고유 키워드
```

---

## 레슨별 아카이브 관리

각 레슨마다 독립적인 아카이브 파일이 생성됩니다:

```
java-study/
├── 01-hello-world/
│   └── docs/
│       └── study/
│           └── 아카이브.md  (01-hello-world 레슨의 학습 노트)
├── 02-variables/
│   └── docs/
│       └── study/
│           └── 아카이브.md  (02-variables 레슨의 학습 노트)
└── .katarc (CURRENT_LESSON 설정)
```

현재 작업 중인 레슨은 `.katarc` 파일의 `CURRENT_LESSON` 값으로 결정됩니다.

---

## 참고사항

### 인코딩

- 모든 파일은 UTF-8로 저장됩니다.
- 한글 키워드와 내용을 완벽하게 지원합니다.
- 쉘에서 입력 시 따옴표로 감싸야 합니다.

### 타임스탬프

- KST(한국 표준시, UTC+9) 기준으로 자동 생성됩니다.
- 형식: `YYYY-MM-DD HH:MM:SS KST`

### 파일 위치 확인

아카이브 파일 위치를 확인하려면:

```bash
cat .katarc  # CURRENT_LESSON 확인
# 아카이브 위치: ${CURRENT_LESSON}/docs/study/아카이브.md
```

### 멀티라인 콘텐츠

여러 줄의 내용을 입력하려면:

```bash
./scripts/study-note-helper.sh add \
  --keyword "배열, 기초" \
  --content "학습 내용:
1. 배열은 같은 타입의 데이터를 연속된 메모리에 저장
2. 인덱스는 0부터 시작
3. 배열 크기는 선언 시 결정되고 변경 불가"
```

### 키워드 검색

나중에 특정 키워드가 포함된 노트를 찾으려면:

```bash
# 스킬의 search 명령어 사용 (권장)
./scripts/study-note-helper.sh search --keyword "변수"

# 또는 직접 grep 사용
grep -A 5 "키워드.*변수" 01-hello-world/docs/study/아카이브.md
```
