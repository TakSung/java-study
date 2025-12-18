# 수동 설치 가이드

모든 운영체제에서 Java 개발 환경을 수동으로 설치하는 가이드입니다.

## 개요

이 가이드는 Windows, macOS, Linux에서 Java 개발 환경을 수동으로 설치하는 방법을 안내합니다. 자동 설치 스크립트를 사용할 수 없거나, 특정 버전의 도구를 설치하고 싶은 경우 이 가이드를 참조하세요.

## Git Clone

개발 환경 설치 전 또는 후에 프로젝트를 먼저 클론할 수 있습니다.

### Windows PowerShell

**추천 방법**: Windows에서 가장 권장되는 방식입니다.

```powershell
# 1. eclipse 폴더 생성 (없는 경우)
New-Item -ItemType Directory -Path ~\eclipse -Force

# 2. eclipse 폴더로 이동
Set-Location ~\eclipse

# 3. 프로젝트 클론
git clone https://github.com/TakSung/java-study.git

# 4. 프로젝트 폴더로 이동
Set-Location java-study
```

**PowerShell 실행 방법**:
1. `Win + R` 키 누르기
2. "powershell" 입력
3. Enter 키 누르기

### Windows CMD

PowerShell을 사용할 수 없는 경우 CMD를 사용할 수 있습니다.

```cmd
REM 1. eclipse 폴더 생성 (없는 경우)
mkdir %USERPROFILE%\eclipse 2>nul

REM 2. eclipse 폴더로 이동
cd %USERPROFILE%\eclipse

REM 3. 프로젝트 클론
git clone https://github.com/TakSung/java-study.git

REM 4. 프로젝트 폴더로 이동
cd java-study
```

**CMD 실행 방법**:
1. `Win + R` 키 누르기
2. "cmd" 입력
3. Enter 키 누르기

### macOS / Linux

```sh
# 1. eclipse 폴더 생성 (없는 경우)
mkdir -p ~/eclipse

# 2. eclipse 폴더로 이동
cd ~/eclipse

# 3. 프로젝트 클론
git clone https://github.com/TakSung/java-study.git

# 4. 프로젝트 폴더로 이동
cd java-study
```

**터미널 실행 방법**:
- **macOS**: `Cmd + Space` → "Terminal" 검색 → Enter
- **Linux**: `Ctrl + Alt + T` 또는 애플리케이션 메뉴에서 "Terminal" 실행

## IDE 설치

Java 개발을 위한 통합 개발 환경(IDE)을 설치합니다. Eclipse 또는 IntelliJ 중 하나를 선택하세요.

### Eclipse 설치

Eclipse는 Java 개발에 최적화된 무료 오픈소스 IDE입니다.

#### 1. Eclipse 다운로드

[Eclipse 공식 다운로드 페이지](https://www.eclipse.org/downloads/)

1. "Get Eclipse IDE 2025-12" 버튼 클릭
2. "Download x86_64" 버튼 클릭
3. 설치 파일 다운로드 대기

#### 2. Eclipse 설치 (Windows)

1. 다운로드한 `eclipse-inst-win64.exe` 실행
2. **"Eclipse IDE for Java Developers"** 선택
3. 설치 옵션 설정:
   - **Java 21 VM**: Java 21 JDK 선택
   - **Installation Folder**: `C:\Users\YourName\eclipse\java-2025-12`
   - **Create start menu entry**: 체크
   - **Create desktop shortcut**: 체크
4. "Install" 버튼 클릭
5. 라이선스 동의 후 설치 진행
6. 설치 완료 후 "Launch" 버튼 클릭

#### 3. Eclipse 설치 (macOS)

1. 다운로드한 `eclipse-inst-macos.dmg` 열기
2. Eclipse Installer를 Applications 폴더로 드래그
3. Eclipse Installer 실행
4. **"Eclipse IDE for Java Developers"** 선택
5. 설치 옵션 설정:
   - **Java 21 VM**: Java 21 JDK 선택 (자동 감지)
   - **Installation Folder**: `/Applications/Eclipse.app`
6. "Install" 버튼 클릭

#### 4. Eclipse 설치 (Linux)

```sh
# 다운로드한 설치 파일에 실행 권한 부여
chmod +x eclipse-inst-linux64

# 설치 프로그램 실행
./eclipse-inst-linux64
```

나머지는 macOS와 동일합니다.

#### 5. Eclipse 초기 세팅

Eclipse를 처음 실행할 때:

1. **Workspace 경로 설정**
   - Windows: `C:\Users\YourName\eclipse\java-study`
   - macOS/Linux: `/Users/YourName/eclipse/java-study` 또는 `~/eclipse/java-study`

2. **Perspective 설정**
   - Welcome 화면에서 "Workbench" 클릭
   - 자동으로 "Java" perspective가 활성화됨

3. **프로젝트 가져오기**
   - `File` > `Open Projects from File System...`
   - "Directory" 버튼 클릭 → workspace 폴더 선택
   - "Finish" 버튼 클릭

### IntelliJ IDEA 설치

IntelliJ IDEA는 강력한 기능을 제공하는 Java IDE입니다. Community Edition은 무료입니다.

#### 1. IntelliJ IDEA 다운로드

[IntelliJ IDEA 다운로드 페이지](https://www.jetbrains.com/ko-kr/idea/download/other.html)

1. **IntelliJ IDEA Community Edition** 섹션 찾기
2. 운영체제에 맞는 버전 선택:
   - **Windows**: `Windows x64 (exe)` 또는 `Windows x64 (zip)`
   - **macOS**: `macOS (Intel)` 또는 `macOS (Apple Silicon)`
   - **Linux**: `Linux (tar.gz)`
3. 다운로드 버튼 클릭

#### 2. IntelliJ IDEA 설치 (Windows)

1. 다운로드한 `ideaIC-{version}.exe` 실행
2. 설치 마법사 진행:
   - Installation Options:
     - ✅ 64-bit launcher
     - ✅ Add "bin" folder to the PATH
     - ✅ Add "Open Folder as Project"
     - ✅ .java file association
3. "Install" 버튼 클릭
4. 설치 완료 후 "Run IntelliJ IDEA Community Edition" 선택

#### 3. IntelliJ IDEA 설치 (macOS)

1. 다운로드한 `ideaIC-{version}.dmg` 열기
2. IntelliJ IDEA를 Applications 폴더로 드래그
3. Applications 폴더에서 IntelliJ IDEA 실행

#### 4. IntelliJ IDEA 설치 (Linux)

```sh
# 압축 해제
tar -xzf ideaIC-{version}.tar.gz

# IntelliJ IDEA 폴더로 이동
cd idea-IC-{version}/bin

# 실행
./idea.sh
```

## JDK 설치

Java Development Kit (JDK)는 Java 프로그램을 개발하고 실행하는 데 필요합니다.

### JDK 다운로드

[Eclipse Temurin 다운로드 페이지](https://adoptium.net/temurin/releases/)

1. **Version**: 21 - LTS 선택
2. **Operating System**: 운영체제 선택
3. **Architecture**: 아키텍처 선택 (대부분 x64)
4. **Package Type**: JDK 선택
5. ".pkg" (macOS) 또는 ".msi" (Windows) 다운로드

### JDK 설치 (Windows)

1. 다운로드한 `.msi` 파일 실행
2. 설치 마법사 진행
3. 기본 설정 유지하고 "Next" 클릭
4. 설치 완료

**환경 변수 설정** (자동으로 설정되지 않은 경우):

```powershell
# JAVA_HOME 설정
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Eclipse Adoptium\jdk-21.0.x.x-hotspot', 'Machine')

# PATH에 추가
$path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
[System.Environment]::SetEnvironmentVariable('Path', "$path;%JAVA_HOME%\bin", 'Machine')
```

### JDK 설치 (macOS)

1. 다운로드한 `.pkg` 파일 실행
2. 설치 마법사 진행
3. "Install" 버튼 클릭
4. 관리자 비밀번호 입력

**환경 변수 설정** (`~/.zshrc` 또는 `~/.bash_profile` 파일에 추가):

```sh
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH=$JAVA_HOME/bin:$PATH
```

### JDK 설치 (Linux)

```sh
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-21-jdk

# Fedora/CentOS/RHEL
sudo dnf install java-21-openjdk-devel
```

**환경 변수 설정** (`~/.bashrc` 또는 `~/.profile` 파일에 추가):

```sh
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```

## Maven 설치

Apache Maven은 Java 프로젝트를 빌드하고 의존성을 관리하는 도구입니다.

### Maven 다운로드

[Apache Maven 다운로드 페이지](https://maven.apache.org/download.cgi)

1. "Binary zip archive" 다운로드 (Windows)
2. "Binary tar.gz archive" 다운로드 (macOS/Linux)

### Maven 설치 (Windows)

1. 다운로드한 `apache-maven-{version}-bin.zip` 압축 해제
2. `C:\Program Files\Apache\maven` 폴더로 이동

**환경 변수 설정**:

```powershell
# MAVEN_HOME 설정
[System.Environment]::SetEnvironmentVariable('MAVEN_HOME', 'C:\Program Files\Apache\maven', 'Machine')

# PATH에 추가
$path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
[System.Environment]::SetEnvironmentVariable('Path', "$path;%MAVEN_HOME%\bin", 'Machine')
```

### Maven 설치 (macOS)

```sh
# Homebrew 사용 (권장)
brew install maven
```

또는 수동 설치:

```sh
# 압축 해제
tar -xzf apache-maven-{version}-bin.tar.gz

# /usr/local로 이동
sudo mv apache-maven-{version} /usr/local/maven

# 환경 변수 설정 (~/.zshrc 또는 ~/.bash_profile)
export MAVEN_HOME=/usr/local/maven
export PATH=$MAVEN_HOME/bin:$PATH
```

### Maven 설치 (Linux)

```sh
# Ubuntu/Debian
sudo apt install maven

# Fedora/CentOS/RHEL
sudo dnf install maven
```

## Git 설치

Git은 버전 관리 시스템으로, 코드 변경사항을 추적하고 협업할 수 있게 해줍니다.

### Git 설치 (Windows)

[Git for Windows 다운로드](https://git-scm.com/download/win)

1. 다운로드한 설치 파일 실행
2. 기본 설정 유지하고 "Next" 클릭
3. "Git Bash Here" 옵션 활성화 (권장)
4. 설치 완료

### Git 설치 (macOS)

```sh
# Homebrew 사용 (권장)
brew install git

# 또는 Xcode Command Line Tools
xcode-select --install
```

### Git 설치 (Linux)

```sh
# Ubuntu/Debian
sudo apt install git

# Fedora/CentOS/RHEL
sudo dnf install git
```

## 설치 확인

모든 도구가 올바르게 설치되었는지 확인합니다.

### Java 확인

```bash
java -version
```

**예상 출력**:
```
openjdk version "21.0.x" 2024-xx-xx
OpenJDK Runtime Environment Temurin-21.0.x+x (build 21.0.x+x)
OpenJDK 64-Bit Server VM Temurin-21.0.x+x (build 21.0.x+x, mixed mode)
```

### Maven 확인

```bash
mvn -version
```

**예상 출력**:
```
Apache Maven 3.9.x (xxxxx)
Maven home: /path/to/maven
Java version: 21.0.x, vendor: Eclipse Adoptium
```

### Git 확인

```bash
git --version
```

**예상 출력**:
```
git version 2.x.x
```

## 시스템 아키텍처 확인

개발 도구를 다운로드할 때 올바른 버전을 선택하려면 시스템 아키텍처를 확인해야 합니다.

### Windows

```cmd
# CMD 또는 PowerShell에서
echo %PROCESSOR_ARCHITECTURE%
```

### macOS / Linux

```sh
uname -m
```

**결과 해석**:
- `AMD64` 또는 `x86_64`: 64비트 Intel/AMD 프로세서
- `ARM64` 또는 `aarch64`: ARM 아키텍처 (Apple Silicon 등)

## 다음 단계

설치가 완료되었다면:

1. Eclipse 또는 IntelliJ IDEA 실행
2. 프로젝트 열기 (`~/eclipse/java-study`)
3. Java 파일 작성 및 실행

## 문제 해결

설치 중 문제가 발생한 경우:

- [문제 해결 가이드](troubleshooting.md) 참조
- 각 도구의 공식 문서 확인

## 관련 문서

- [Windows 자동 설치 가이드](windows-auto-install.md) - Windows에서 자동으로 설치하기
- [문제 해결 가이드](troubleshooting.md) - 일반적인 문제 해결 방법
- [Eclipse 공식 문서](https://help.eclipse.org/)
- [IntelliJ IDEA 공식 문서](https://www.jetbrains.com/help/idea/)
- [Git 공식 문서](https://git-scm.com/doc)
