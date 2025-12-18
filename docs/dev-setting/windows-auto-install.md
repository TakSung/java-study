# Windows 11 개발 환경 자동 설치

Windows 11에서 Java, Maven, Eclipse 등의 개발 도구를 자동으로 설치하는 가이드입니다.

## 개요

이 자동 설치 스크립트는 Windows 11에서 Java 개발 환경을 빠르게 구축할 수 있도록 도와줍니다. 수동으로 각 도구를 다운로드하고 설치하는 대신, PowerShell 스크립트 하나로 모든 필수 도구를 설치할 수 있습니다.

## 설치되는 도구

자동 설치 스크립트는 다음 도구들을 설치합니다:

- ✅ **Java 21 LTS** (Eclipse Temurin)
- ✅ **Apache Maven** - Java 프로젝트 빌드 도구
- ✅ **Eclipse IDE for Java Developers 2025-12** (Windows x86_64)
- ✅ **Python 3.13** - 스크립팅 및 추가 도구용
- ✅ **Visual Studio Code** - 범용 코드 에디터
- ✅ **Git** - 버전 관리 시스템
- ✅ **Windows Terminal** - 향상된 터미널 환경
- ✅ **NVM** (Node Version Manager) - Node.js 버전 관리
- ✅ **Chocolatey** (패키지 매니저) - 자동으로 먼저 설치됨

## 필수 요구사항

### 시스템 요구사항

- **운영체제**: Windows 11 (Windows 10에서도 작동 가능)
- **관리자 권한**: PowerShell을 관리자 권한으로 실행할 수 있어야 함
- **인터넷 연결**: 각 도구를 다운로드하기 위해 필요
- **디스크 공간**: 최소 5GB 이상의 여유 공간

### 사전 확인사항

1. PowerShell 버전 확인 (5.1 이상 권장)
   ```powershell
   $PSVersionTable.PSVersion
   ```

2. 실행 정책 확인
   ```powershell
   Get-ExecutionPolicy
   ```

## 스크립트 실행 방법

### 1단계: PowerShell 관리자 권한으로 실행

다음 중 한 가지 방법을 선택하세요:

**방법 1**: 시작 메뉴 사용
1. 시작 메뉴 열기 (Windows 키)
2. "PowerShell" 검색
3. 우클릭 → "관리자 권한으로 실행" 선택

**방법 2**: Windows+X 단축키 사용
1. `Windows + X` 키 누르기
2. "Windows PowerShell (관리자)" 또는 "터미널 (관리자)" 선택

### 2단계: 프로젝트 디렉토리로 이동

```powershell
# 다운로드 폴더에 프로젝트가 있는 경우
cd ~\Downloads\java-study

# 또는 특정 경로에 있는 경우
cd C:\Path\To\java-study
```

### 3단계: 스크립트 실행

```powershell
.\window_dev_installer.ps1
```

스크립트가 실행되면 자동으로 모든 도구를 순서대로 설치합니다.

## 설치 과정

스크립트는 다음 순서로 진행됩니다:

1. **Chocolatey 설치**: 패키지 매니저 설치
2. **개발 도구 설치**: Java, Maven, Git 등 필수 도구
3. **Eclipse 설치**: IDE 다운로드 및 설치
4. **환경 변수 설정**: 자동으로 PATH 설정
5. **Workspace 생성**: Eclipse workspace 디렉토리 생성

### 예상 소요 시간

- 인터넷 속도에 따라 **10~20분** 소요
- Eclipse IDE 다운로드가 가장 오래 걸립니다 (약 400MB)

## 설치 완료 후 확인

### 1. 터미널 재시작

환경 변수가 적용되도록 PowerShell을 완전히 종료하고 다시 실행합니다.

### 2. 설치 확인

새 PowerShell 창에서 다음 명령어로 설치를 확인합니다:

```powershell
# Java 설치 확인
java -version

# Maven 설치 확인
mvn -version

# Git 설치 확인
git --version

# Python 설치 확인
python --version

# Node.js 설치 확인 (NVM 통해)
nvm list
```

**올바른 출력 예시**:
```
java version "21.0.x" ...
Apache Maven 3.9.x
git version 2.x.x
Python 3.13.x
```

### 3. Eclipse Workspace 설정

자동 설치 스크립트는 workspace를 다음 경로에 생성합니다:

```
%USERPROFILE%\eclipse\java-study
```

실제 경로 예시:
```
C:\Users\YourName\eclipse\java-study
```

Eclipse를 처음 실행할 때 이 경로를 workspace로 선택하세요.

## Eclipse 초기 설정

### 1. Eclipse 실행

- 시작 메뉴에서 "Eclipse" 검색
- 또는 바탕화면 바로가기 실행

### 2. Workspace 선택

1. Eclipse 실행 시 나타나는 Workspace Launcher에서:
   ```
   C:\Users\YourName\eclipse\java-study
   ```
   입력

2. "Use this as the default and do not ask again" 체크 (선택사항)

3. "Launch" 버튼 클릭

### 3. Perspective 설정

1. "Welcome" 화면에서 "Workbench" 아이콘 클릭
2. 우측 상단에 "Java" perspective가 선택되어 있는지 확인

## 주의사항

### 필수 주의사항

1. **관리자 권한 필수**
   - 반드시 PowerShell을 관리자 권한으로 실행해야 합니다
   - 일반 권한으로 실행하면 설치가 실패할 수 있습니다

2. **터미널 재시작 필수**
   - 설치 완료 후 반드시 터미널을 재시작해야 환경 변수가 적용됩니다
   - 재시작하지 않으면 `java`, `git` 등의 명령어가 인식되지 않습니다

3. **백신 프로그램 경고**
   - 일부 백신 프로그램이 Chocolatey 설치를 차단할 수 있습니다
   - 신뢰할 수 있는 소스이므로 허용해주세요

### 권장사항

1. **설치 중 다른 작업 자제**
   - 설치가 완료될 때까지 PowerShell 창을 닫지 마세요
   - 컴퓨터를 절전 모드로 전환하지 마세요

2. **인터넷 연결 유지**
   - 안정적인 인터넷 연결 필요
   - 대용량 파일 다운로드가 포함되어 있습니다

## 문제 해결

### 스크립트 실행 정책 오류

**오류 메시지**: "이 시스템에서 스크립트를 실행할 수 없습니다"

**해결 방법**: [문제 해결 가이드](troubleshooting.md#powershell-스크립트-실행-오류) 참조

### Chocolatey 설치 실패

Chocolatey가 자동으로 설치되지 않는 경우, [문제 해결 가이드](troubleshooting.md#chocolatey-자동-설치-실패)를 참조하여 수동으로 설치할 수 있습니다.

### 환경 변수 미적용

설치 후 명령어가 인식되지 않는 경우, [문제 해결 가이드](troubleshooting.md#환경-변수가-적용되지-않음)를 참조하세요.

## 다음 단계

설치가 완료되었다면:

1. **프로젝트 Clone**
   ```powershell
   cd ~\eclipse
   git clone https://github.com/TakSung/java-study.git
   cd java-study
   ```

2. **Eclipse에서 프로젝트 열기**
   - `File` > `Open Projects from File System...`
   - 프로젝트 디렉토리 선택

3. **학습 시작**
   - 프로젝트의 Java 파일 탐색
   - 코드 실행 및 수정

## 수동 설치 대안

자동 설치 스크립트가 동작하지 않거나 특정 도구만 설치하고 싶은 경우:

- [수동 설치 가이드](manual-install.md) 참조

## 관련 문서

- [문제 해결 가이드](troubleshooting.md) - 설치 중 발생하는 문제 해결
- [수동 설치 가이드](manual-install.md) - 도구별 수동 설치 방법
- [Eclipse 공식 문서](https://help.eclipse.org/) - Eclipse IDE 사용법
- [Chocolatey 공식 문서](https://docs.chocolatey.org/) - Chocolatey 패키지 매니저
