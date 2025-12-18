## 0. Windows 11 개발 환경 자동 설치 (선택사항)

Windows 11에서 Java, Maven, Eclipse 등의 개발 도구가 없는 경우, 자동 설치 스크립트를 사용할 수 있습니다.

### 스크립트 실행 방법

```powershell
# 1. PowerShell을 관리자 권한으로 실행 (방법 1 또는 2 선택)
# 방법 1: 시작 메뉴 → "PowerShell" 검색 → 우클릭 → "관리자 권한으로 실행"
# 방법 2: Windows+X → "Windows PowerShell (관리자)"

# 2. 프로젝트 디렉토리로 이동
cd C:\Users\YourName\Downloads\java-study

# 3. 스크립트 실행
.\window_dev_installer.ps1
```

**설치되는 도구:**
- ✅ Java 21 LTS (Eclipse Temurin)
- ✅ Apache Maven
- ✅ Eclipse IDE for Java Developers 2025-12 (Windows x86_64)
- ✅ Python 3.13
- ✅ Visual Studio Code
- ✅ Git
- ✅ Windows Terminal
- ✅ NVM (Node Version Manager)
- ✅ Chocolatey (패키지 매니저) - 자동으로 설치됨

**주의사항:**
- 반드시 **관리자 권한**으로 PowerShell을 실행해야 합니다
- 설치 완료 후 터미널을 재시작하여 환경 변수를 적용합니다
- Eclipse Workspace 경로: `%USERPROFILE%\eclipse\java-study`

### 문제 해결

**1. "이 시스템에서 스크립트를 실행할 수 없습니다" 오류**

PowerShell 스크립트 실행 정책 때문에 발생하는 오류입니다. 아래 명령어로 해결:

```powershell
# 현재 사용자에 대해서만 스크립트 실행 허용 (권장)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**명령어 설명:**
- `RemoteSigned`: 로컬 스크립트는 실행 가능, 다운로드한 스크립트는 서명 필요
- `Scope CurrentUser`: 현재 사용자에게만 적용 (관리자 권한 불필요)

**2. Chocolatey 수동 설치가 필요한 경우**

자동 설치 스크립트가 실패한 경우, Chocolatey를 수동으로 설치:

```powershell
# PowerShell 관리자 권한으로 실행 후
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**명령어 설명:**
- `Set-ExecutionPolicy Bypass -Scope Process`: 현재 프로세스에서만 일시적으로 스크립트 실행 허용
- `SecurityProtocol` 설정: TLS 1.2 보안 프로토콜 활성화 (HTTPS 다운로드 필수)
- `iex`: 다운로드한 Chocolatey 설치 스크립트를 즉시 실행

---

## 수동 설치

### Git Clone

**Windows PowerShell:** (window 일시 택1)

- powershell 창 오픈 : `Win+r` -> powershell 입력 -> 엔터
- `java-study`를 eclipse 폴더 아래 설정

```powershell
New-Item -ItemType Directory -Path ~\eclipse -Force
Set-Location ~\eclipse
git clone https://github.com/TakSung/java-study.git
Set-Location java-study
```

**macOS/Linux:**

```sh
mkdir -p ~/eclipse
cd ~/eclipse
git clone https://github.com/TakSung/java-study.git
cd java-study
```

### [Eclips 설치 링크](https://www.eclipse.org/downloads/)
- Install your favorite desktop IDE packages
- Download x86_64

- 인스톨러

```md
1. Eclipse IDE for java Developers
2. 기본설정 하고 install
    - 버전 : java 21 vm
    - 설치경로 : 홈/eclipse/java-2025-12
    - 체크박스 : start menu, desctop shortcut 
```

- 초기 세팅

```md
1. 워크스페이스 경로 설정 : {유저 홈 폴더}/eclipse/java-study
2. `java developer`로 설정
3. 
```

### [intellij 설치 링크](https://www.jetbrains.com/ko-kr/idea/download/other.html)
- IntelliJ IDEA Community Edition
- 최신 `Windows x64 (exe)` 다운로드

### APCS 자료 
- [citcoding](https://citcoding.com/APCS_A_VS_APCS_P.html)
- [AP CS Exam Prep](https://www.apcsexamprep.com/pages/test-ap-csa-resources?utm_source=chatgpt.com)
- [COURSE AND EXAM DESCRIPTION](https://apcentral.collegeboard.org/media/pdf/ap-computer-science-a-course-and-exam-description.pdf?utm_source=chatgpt.com)


# 기타

### Git Clone - window cmd

**Windows CMD:** (window 일시 택1)

- cmd 창 오픈 : `Win+r` -> cmd 입력 -> 엔터
- `java-study`를 eclipse 폴더 아래 설정

```cmd
mkdir %USERPROFILE%\eclipse 2>nul
cd %USERPROFILE%\eclipse
git clone https://github.com/TakSung/java-study.git
cd java-study
```

### 본인 컴퓨터 아키텍쳐 확인하기
- win + r
```cmd
echo %PROCESSOR_ARCHITECTURE%
```