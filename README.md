# Java Study

AP Computer Science A 학습을 위한 Java 프로젝트입니다.

## 빠른 시작

### 1. 개발 환경 설치

**Windows 사용자 (자동 설치 권장)**

- [자동화 스크립트 다운로드 링크](https://github.com/TakSung/java-study/blob/main/window_dev_installer.ps1) 에서 다운로드(Download raw file) 

```powershell
# 1. PowerShell을 관리자 권한으로 실행 (방법 1 또는 2 선택)
# 방법 1: 시작 메뉴 → "PowerShell" 검색 → 우클릭 → "관리자 권한으로 실행"
# 방법 2: win+r → powershell 입력후 ctrl+shift+enter → "Windows PowerShell (관리자)"

# 2. 프로젝트 디렉토리로 이동
cd ~\Downloads
.\window_dev_installer.ps1
```

- 안돼면 아래 명령어 powershell에서 실행해 보기

```powershell
# 현재 사용자에 대해서만 스크립트 실행 허용 (권장)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

상세 가이드: [Windows 자동 설치](docs/dev-setting/windows-auto-install.md)

**수동 설치 (모든 OS)**

상세 가이드: [수동 설치](docs/dev-setting/manual-install.md)

### 2. 프로젝트 Clone

**Windows PowerShell**

```powershell
cd ~\eclipse
git clone https://github.com/TakSung/java-study.git
cd java-study
```

**macOS/Linux**

```sh
cd ~/eclipse
git clone https://github.com/TakSung/java-study.git
cd java-study
```

### 3. IDE 실행

- Eclipse Workspace: `{홈 폴더}/eclipse/java-study`
- Java 버전: Java 21 LTS

## 주요 도구

- ✅ Java 21 LTS (Eclipse Temurin)
- ✅ Apache Maven
- ✅ Eclipse IDE / IntelliJ IDEA
- ✅ Git

## 학습 자료

### APCS 공식 자료

- [APCS A vs APCS P](https://citcoding.com/APCS_A_VS_APCS_P.html)
- [AP CS Exam Prep](https://www.apcsexamprep.com/pages/test-ap-csa-resources)
- [APCS Course and Exam Description (PDF)](https://apcentral.collegeboard.org/media/pdf/ap-computer-science-a-course-and-exam-description.pdf)

## 문서

- [Windows 자동 설치](docs/dev-setting/windows-auto-install.md) - PowerShell 스크립트로 자동 설치
- [수동 설치](docs/dev-setting/manual-install.md) - Eclipse, IntelliJ, JDK 등 수동 설치
- [문제 해결](docs/dev-setting/troubleshooting.md) - 설치 및 환경 설정 문제 해결