## 자동 설치 (Windows 11 권장)

**필수 요구사항**: Windows 11, 관리자 권한

### 1. 스크립트 다운로드 및 실행

```powershell
# PowerShell 관리자 권한으로 실행 (Win+X > 'Windows PowerShell (관리자)')
# 프로젝트 폴더로 이동 후 실행
.\window_dev_installer.ps1
```

**설치되는 항목**:
- ✅ Java 21 LTS (Eclipse Temurin)
- ✅ Apache Maven
- ✅ Eclipse IDE 2025-12 (Windows x86_64)
- ✅ Python 3.13, VSCode, Git, Windows Terminal, NVM

**설치 후**: 터미널 재시작 → Eclipse 실행 → Workspace: `%USERPROFILE%\eclipse\java-study`

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