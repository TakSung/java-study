# 문제 해결 가이드

개발 환경 설치 및 설정 중 발생할 수 있는 일반적인 문제와 해결 방법을 안내합니다.

## Windows 관련 문제

### PowerShell 스크립트 실행 오류

**증상**: "이 시스템에서 스크립트를 실행할 수 없습니다" 오류 발생

**원인**: PowerShell 스크립트 실행 정책이 제한되어 있음

**해결 방법**:

```powershell
# 현재 사용자에 대해서만 스크립트 실행 허용 (권장)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**명령어 설명**:
- `RemoteSigned`: 로컬 스크립트는 실행 가능, 다운로드한 스크립트는 서명 필요
- `Scope CurrentUser`: 현재 사용자에게만 적용 (관리자 권한 불필요)

### Chocolatey 자동 설치 실패

**증상**: 자동 설치 스크립트 실행 시 Chocolatey 설치 실패

**해결 방법**: Chocolatey를 수동으로 설치

```powershell
# PowerShell을 관리자 권한으로 실행 후
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**명령어 설명**:
- `Set-ExecutionPolicy Bypass -Scope Process`: 현재 프로세스에서만 일시적으로 스크립트 실행 허용
- `SecurityProtocol` 설정: TLS 1.2 보안 프로토콜 활성화 (HTTPS 다운로드 필수)
- `iex`: 다운로드한 Chocolatey 설치 스크립트를 즉시 실행

### 환경 변수가 적용되지 않음

**증상**: 설치 완료 후에도 명령어가 인식되지 않음 (예: `java`, `git` 등)

**해결 방법**:

1. 터미널 재시작
   ```powershell
   # PowerShell을 완전히 종료하고 다시 실행
   ```

2. 환경 변수 확인
   ```powershell
   # PATH 환경 변수 확인
   echo $env:PATH

   # Java 설치 확인
   java -version

   # Maven 설치 확인
   mvn -version
   ```

3. 시스템 재시작 (재시작 후에도 해결되지 않는 경우)

## Eclipse 관련 문제

### Workspace 경로 설정 오류

**증상**: Eclipse 실행 시 workspace를 찾을 수 없음

**해결 방법**:

1. 올바른 workspace 경로 사용
   - Windows: `%USERPROFILE%\eclipse\java-study`
   - macOS/Linux: `~/eclipse/java-study`

2. 디렉토리가 없는 경우 수동 생성
   ```powershell
   # Windows PowerShell
   mkdir %USERPROFILE%\eclipse\java-study
   ```

   ```sh
   # macOS/Linux
   mkdir -p ~/eclipse/java-study
   ```

### JDK 인식 문제

**증상**: Eclipse에서 JDK를 찾을 수 없음

**해결 방법**:

1. Eclipse 메뉴: `Window` > `Preferences`
2. `Java` > `Installed JREs` 선택
3. `Add` 버튼 클릭
4. JDK 설치 경로 지정
   - Windows: `C:\Program Files\Eclipse Adoptium\jdk-21.x.x.x-hotspot`
   - macOS: `/Library/Java/JavaVirtualMachines/temurin-21.jdk`

## Git 관련 문제

### Git Clone 실패

**증상**: `git clone` 명령어 실행 시 오류 발생

**일반적인 원인과 해결 방법**:

1. **Git이 설치되지 않음**
   ```powershell
   # Git 설치 확인
   git --version

   # Windows: Chocolatey로 설치
   choco install git -y
   ```

2. **네트워크 연결 문제**
   - 인터넷 연결 확인
   - 방화벽 설정 확인

3. **권한 문제**
   - 대상 디렉토리에 쓰기 권한이 있는지 확인

### 권한 문제 (Permission Denied)

**증상**: Git 작업 시 "Permission denied" 오류

**해결 방법**:

1. 디렉토리 권한 확인
   ```powershell
   # Windows: 관리자 권한으로 PowerShell 실행
   ```

   ```sh
   # macOS/Linux: 소유자 변경
   sudo chown -R $USER ~/eclipse/java-study
   ```

## 일반적인 문제

### 시스템 아키텍처 확인

개발 도구를 다운로드할 때 올바른 버전(x64, ARM64 등)을 선택하려면:

**Windows**:
```cmd
# CMD 또는 PowerShell에서 실행
echo %PROCESSOR_ARCHITECTURE%
```

**macOS/Linux**:
```sh
uname -m
```

**결과 해석**:
- `AMD64` 또는 `x86_64`: 64비트 Intel/AMD 프로세서
- `ARM64` 또는 `aarch64`: ARM 아키텍처 (Apple Silicon 등)

### Java 버전 충돌

**증상**: 여러 Java 버전이 설치되어 있어 혼란

**해결 방법**:

1. 현재 사용 중인 Java 버전 확인
   ```bash
   java -version
   ```

2. 설치된 모든 Java 버전 확인
   ```powershell
   # Windows
   where java
   ```

   ```sh
   # macOS
   /usr/libexec/java_home -V
   ```

3. 원하는 Java 버전으로 설정
   - 환경 변수 `JAVA_HOME`을 원하는 JDK 경로로 설정
   - PATH의 첫 부분에 해당 JDK의 bin 디렉토리 추가

## 추가 도움

위의 해결 방법으로 문제가 해결되지 않는 경우:

1. [수동 설치 가이드](manual-install.md)를 참조하여 재설치 시도
2. [Windows 자동 설치 가이드](windows-auto-install.md)의 주의사항 확인
3. 각 도구의 공식 문서 참조
   - [Eclipse 공식 문서](https://help.eclipse.org/)
   - [Git 공식 문서](https://git-scm.com/doc)
   - [Chocolatey 트러블슈팅](https://docs.chocolatey.org/en-us/troubleshooting)
