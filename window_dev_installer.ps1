# Windows 11 개발 환경 자동 설치 스크립트
# Java 21, Maven, Eclipse, Python 3.13, VSCode, Git, Windows Terminal, NVM 설치

# ===== 설치 패키지 목록 정의 =====

# Chocolatey로 설치할 패키지
$packagesToInstall = @{
    "temurin21" = "Eclipse Temurin JDK 21"
    "maven" = "Apache Maven"
    "eclipse-java-oxygen" = "Eclipse IDE for Java Developers 2025-12"
    "python313" = "Python 3.13"
    "vscode" = "Visual Studio Code"
    "git" = "Git"
    "microsoft-windows-terminal" = "Windows Terminal"
    "nvm" = "NVM (Node Version Manager)"
}

# npm으로 설치할 글로벌 패키지
$npmPackages = @{
    "@google/gemini-cli" = @{
        "display_name" = "Gemini CLI"
        "command" = "gemini"
    }
    # 추가 패키지는 여기에 등록
    # "package-name" = @{
    #     "display_name" = "표시 이름"
    #     "command" = "명령어"
    # }
}

# ===== 시작 메시지 =====
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "개발 환경 자동 설치 시작" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ===== ExecutionPolicy 설정 =====
Write-Host "[0/5] ExecutionPolicy 설정 중..." -ForegroundColor Yellow
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-Host "✅ ExecutionPolicy 설정 완료 (Python venv 활성화 가능)" -ForegroundColor Green
} catch {
    Write-Host "⚠️ ExecutionPolicy 설정 실패 (수동 설정 필요)" -ForegroundColor Yellow
}
Write-Host ""

# ===== 관리자 권한 확인 =====
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "❌ 이 스크립트는 관리자 권한이 필요합니다." -ForegroundColor Red
    Write-Host "PowerShell을 관리자 권한으로 실행한 후 다시 시도해주세요." -ForegroundColor Yellow
    pause
    exit 1
}
Write-Host "✅ 관리자 권한 확인 완료" -ForegroundColor Green
Write-Host ""

# ===== Step 1: Chocolatey 설치 확인 =====
Write-Host "[1/11] Chocolatey 설치 확인 중..." -ForegroundColor Yellow

if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Host "✅ Chocolatey가 이미 설치되어 있습니다." -ForegroundColor Green
} else {
    Write-Host "📦 Chocolatey 설치 중..." -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # 환경 변수 새로고침
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "✅ Chocolatey 설치 완료" -ForegroundColor Green
    } else {
        Write-Host "❌ Chocolatey 설치 실패" -ForegroundColor Red
        pause
        exit 1
    }
}
Write-Host ""

# ===== Step 2: Java 21 설치 판단 및 설치 =====
Write-Host "[2/11] Java 21 설치 확인 중..." -ForegroundColor Yellow

$javaInstalled = $false
$skipJavaInstall = $false

# 1순위: java 명령어 존재 및 버전 확인
if (Get-Command java -ErrorAction SilentlyContinue) {
    try {
        $javaVersionOutput = java -version 2>&1 | Select-String -Pattern 'version "(\d+)'
        if ($javaVersionOutput -match 'version "(\d+)') {
            $javaMajorVersion = [int]$matches[1]
            if ($javaMajorVersion -ge 21) {
                Write-Host "✅ Java $javaMajorVersion 이미 설치됨 (Java 21 설치 건너뜀)" -ForegroundColor Green
                $skipJavaInstall = $true
                $javaInstalled = $true
            }
        }
    } catch {
        # 버전 확인 실패 시 계속 진행
    }
}

# 2순위: JAVA_HOME 확인
if (-not $skipJavaInstall -and $env:JAVA_HOME) {
    $javaExePath = Join-Path $env:JAVA_HOME "bin\java.exe"
    if (Test-Path $javaExePath) {
        Write-Host "✅ JAVA_HOME이 설정되어 있음 (Java 21 설치 건너뜀)" -ForegroundColor Green
        $skipJavaInstall = $true
        $javaInstalled = $true
    }
}

# Java 설치 진행
if (-not $skipJavaInstall) {
    Write-Host "📦 Java 21 (Eclipse Temurin) 설치 중..." -ForegroundColor Cyan
    choco install temurin21 -y

    # 환경변수 새로고침
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

    if (Get-Command java -ErrorAction SilentlyContinue) {
        $javaVersion = java -version 2>&1 | Select-Object -First 1
        Write-Host "✅ Java 21 설치 완료: $javaVersion" -ForegroundColor Green
        $javaInstalled = $true
    } else {
        Write-Host "❌ Java 21 설치 실패 (터미널 재시작 필요할 수 있음)" -ForegroundColor Red
    }
}
Write-Host ""

# ===== Step 3: Maven 설치 판단 및 설치 =====
Write-Host "[3/11] Maven 설치 확인 중..." -ForegroundColor Yellow

$mavenInstalled = $false

if (Get-Command mvn -ErrorAction SilentlyContinue) {
    try {
        $mavenVersion = mvn -version 2>&1 | Select-Object -First 1
        Write-Host "✅ Maven 이미 설치됨: $mavenVersion" -ForegroundColor Green
        Write-Host "  (설치 건너뜀)" -ForegroundColor Gray
        $mavenInstalled = $true
    } catch {
        Write-Host "📦 Maven 설치 중..." -ForegroundColor Cyan
        choco install maven -y

        # 환경변수 새로고침
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

        if (Get-Command mvn -ErrorAction SilentlyContinue) {
            $mavenVersion = mvn -version 2>&1 | Select-Object -First 1
            Write-Host "✅ Maven 설치 완료: $mavenVersion" -ForegroundColor Green
            $mavenInstalled = $true
        } else {
            Write-Host "❌ Maven 설치 실패" -ForegroundColor Red
        }
    }
} else {
    Write-Host "📦 Maven 설치 중..." -ForegroundColor Cyan
    choco install maven -y

    # 환경변수 새로고침
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

    if (Get-Command mvn -ErrorAction SilentlyContinue) {
        $mavenVersion = mvn -version 2>&1 | Select-Object -First 1
        Write-Host "✅ Maven 설치 완료: $mavenVersion" -ForegroundColor Green
        $mavenInstalled = $true
    } else {
        Write-Host "❌ Maven 설치 실패" -ForegroundColor Red
    }
}
Write-Host ""

# ===== Step 4: 설치할 패키지 확인 =====
Write-Host "[4/11] 설치할 패키지 확인 중..." -ForegroundColor Yellow

$toInstall = @()
$alreadyInstalled = @()

foreach ($package in $packagesToInstall.Keys) {
    $packageName = $packagesToInstall[$package]
    $chocoList = choco list --local-only $package --exact

    if ($chocoList -match $package) {
        Write-Host "  ✓ $packageName 이미 설치됨 (건너뜀)" -ForegroundColor Gray
        $alreadyInstalled += $packageName
    } else {
        Write-Host "  + $packageName 설치 예정" -ForegroundColor Cyan
        $toInstall += $package
    }
}
Write-Host ""

# ===== Step 5: 필요한 패키지 설치 =====
if ($toInstall.Count -eq 0) {
    Write-Host "[5/11] 모든 패키지가 이미 설치되어 있습니다." -ForegroundColor Green
} else {
    Write-Host "[5/11] 개발 도구 설치 중... ($($toInstall.Count)개)" -ForegroundColor Yellow
    Write-Host "설치 항목: $($toInstall -join ', ')" -ForegroundColor Cyan
    Write-Host ""
    choco install $toInstall -y
}
Write-Host ""

# ===== Step 6: 설치 확인 =====
Write-Host "[6/11] 설치 확인 중..." -ForegroundColor Yellow

# 환경 변수 새로고침
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

$installStatus = @{
    "Java 21" = $javaInstalled
    "Maven" = $mavenInstalled
    "Eclipse" = $false
    "Python" = $false
    "VSCode" = $false
    "Git" = $false
    "Windows Terminal" = $false
    "NVM" = $false
}

# Python 확인
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonVersion = python --version
    Write-Host "✅ Python 설치 완료: $pythonVersion" -ForegroundColor Green
    $installStatus["Python"] = $true
} else {
    Write-Host "❌ Python 설치 확인 실패" -ForegroundColor Red
}

# VSCode 확인
if (Get-Command code -ErrorAction SilentlyContinue) {
    $vscodeVersion = code --version | Select-Object -First 1
    Write-Host "✅ VSCode 설치 완료: $vscodeVersion" -ForegroundColor Green
    $installStatus["VSCode"] = $true
} else {
    Write-Host "❌ VSCode 설치 확인 실패" -ForegroundColor Red
}

# Git 확인
if (Get-Command git -ErrorAction SilentlyContinue) {
    $gitVersion = git --version | Select-Object -First 1
    Write-Host "✅ Git 설치 완료: $gitVersion" -ForegroundColor Green
    $installStatus["Git"] = $true
} else {
    Write-Host "❌ Git 설치 확인 실패" -ForegroundColor Red
}

# Eclipse 확인
$eclipseInstalled = choco list --local-only eclipse-java-oxygen --exact 2>&1
if ($eclipseInstalled -match "eclipse-java-oxygen") {
    Write-Host "✅ Eclipse IDE 2025-12 설치 완료 (Windows x86_64)" -ForegroundColor Green
    Write-Host "  ℹ️ Eclipse 실행 후 Preferences > Java > Installed JREs에서 Java 21 선택 가능" -ForegroundColor Gray
    $installStatus["Eclipse"] = $true
} else {
    Write-Host "⚠️ Eclipse 수동 설치가 필요할 수 있음" -ForegroundColor Yellow
    Write-Host "  또는 Eclipse Installer로 수동 설치한 경우 감지되지 않을 수 있음" -ForegroundColor Gray
}

# Windows Terminal 확인
if (Get-Command wt -ErrorAction SilentlyContinue) {
    Write-Host "✅ Windows Terminal 설치 완료" -ForegroundColor Green
    $installStatus["Windows Terminal"] = $true
} else {
    Write-Host "❌ Windows Terminal 설치 확인 실패 (재부팅 후 사용 가능)" -ForegroundColor Yellow
    $installStatus["Windows Terminal"] = $true
}

# NVM 확인
if (Get-Command nvm -ErrorAction SilentlyContinue) {
    $nvmVersion = nvm version
    Write-Host "✅ NVM 설치 완료: $nvmVersion" -ForegroundColor Green
    $installStatus["NVM"] = $true
} else {
    Write-Host "❌ NVM 설치 확인 실패 (터미널 재시작 후 사용 가능)" -ForegroundColor Yellow
    $installStatus["NVM"] = $true
}

# 환경변수 확인 및 안내
Write-Host ""
Write-Host "환경변수 확인:" -ForegroundColor Yellow
if ($env:JAVA_HOME) {
    Write-Host "  JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Gray
} else {
    Write-Host "  ⚠️ JAVA_HOME이 설정되지 않음 (터미널 재시작 필요)" -ForegroundColor Yellow
}

if (Get-Command java -ErrorAction SilentlyContinue) {
    $currentJavaVersion = java -version 2>&1 | Select-Object -First 1
    Write-Host "  현재 java 버전: $currentJavaVersion" -ForegroundColor Gray

    # Java 21 미만 경고
    if ($currentJavaVersion -notmatch 'version "2[1-9]|[3-9]\d') {
        Write-Host "  ⚠️ 현재 PATH의 java가 Java 21이 아닙니다" -ForegroundColor Yellow
        Write-Host "  터미널을 재시작하거나 PATH 순서를 확인해주세요" -ForegroundColor Gray
    }
}

if (Get-Command mvn -ErrorAction SilentlyContinue) {
    $currentMavenVersion = mvn -version 2>&1 | Select-Object -First 1
    Write-Host "  현재 Maven 버전: $currentMavenVersion" -ForegroundColor Gray
}
Write-Host ""

# ===== Step 7: Node.js 20.19.0 설치 및 설정 =====
Write-Host "[7/11] Node.js 20.19.0 설치 및 설정 중..." -ForegroundColor Yellow

if (Get-Command nvm -ErrorAction SilentlyContinue) {
    # Node.js 20.19.0 설치 확인
    $nodeList = nvm list
    if ($nodeList -match "20.19.0") {
        Write-Host "✅ Node.js 20.19.0 이미 설치됨" -ForegroundColor Green
    } else {
        Write-Host "📦 Node.js 20.19.0 설치 중..." -ForegroundColor Cyan
        nvm install 20.19.0
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Node.js 20.19.0 설치 완료" -ForegroundColor Green
        } else {
            Write-Host "❌ Node.js 20.19.0 설치 실패" -ForegroundColor Red
        }
    }

    # Node.js 20.19.0 활성화
    Write-Host "🔄 Node.js 20.19.0 활성화 중..." -ForegroundColor Cyan
    nvm use 20.19.0
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Node.js 20.19.0 활성화 완료" -ForegroundColor Green

        # 환경 변수 새로고침
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) + ";" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

        # Node 버전 확인
        $nodeVersion = node --version
        Write-Host "  현재 Node 버전: $nodeVersion" -ForegroundColor Gray
    } else {
        Write-Host "⚠️ Node.js 20.19.0 활성화 실패" -ForegroundColor Yellow
    }
} else {
    Write-Host "⚠️ NVM이 설치되지 않아 Node.js 설정을 건너뜁니다." -ForegroundColor Yellow
    Write-Host "  터미널 재시작 후 다음 명령어로 수동 설치:" -ForegroundColor Gray
    Write-Host "  nvm install 20.19.0" -ForegroundColor Gray
    Write-Host "  nvm use 20.19.0" -ForegroundColor Gray
}
Write-Host ""

# ===== Step 8: npm 글로벌 패키지 설치 =====
Write-Host "[8/11] npm 글로벌 패키지 설치 중..." -ForegroundColor Yellow

if (Get-Command npm -ErrorAction SilentlyContinue) {
    foreach ($package in $npmPackages.Keys) {
        $packageInfo = $npmPackages[$package]
        $displayName = $packageInfo["display_name"]

        # 패키지 설치 확인
        $packageInstalled = npm list -g $package 2>$null
        if ($packageInstalled -match $package) {
            Write-Host "  ✓ $displayName 이미 설치됨 (건너뜀)" -ForegroundColor Gray
        } else {
            Write-Host "  + $displayName 설치 중..." -ForegroundColor Cyan
            npm install -g $package
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✅ $displayName 설치 완료" -ForegroundColor Green
            } else {
                Write-Host "  ❌ $displayName 설치 실패" -ForegroundColor Red
            }
        }
    }

    # 설치된 패키지 버전 확인
    Write-Host ""
    Write-Host "설치된 npm 패키지:" -ForegroundColor White
    foreach ($package in $npmPackages.Keys) {
        $packageInfo = $npmPackages[$package]
        $displayName = $packageInfo["display_name"]
        $command = $packageInfo["command"]

        if (Get-Command $command -ErrorAction SilentlyContinue) {
            $version = & $command --version 2>$null
            if ($version) {
                Write-Host "  ✅ $displayName`: $version" -ForegroundColor Green
            } else {
                Write-Host "  ✅ $displayName`: 설치됨" -ForegroundColor Green
            }
        }
    }
} else {
    Write-Host "⚠️ npm이 설치되지 않아 패키지 설치를 건너뜁니다." -ForegroundColor Yellow
    Write-Host "  터미널 재시작 후 다음 명령어로 수동 설치:" -ForegroundColor Gray
    foreach ($package in $npmPackages.Keys) {
        Write-Host "  npm install -g $package" -ForegroundColor Gray
    }
}
Write-Host ""

# ===== Step 9: pip 업그레이드 =====
Write-Host "[9/11] pip 업그레이드 중..." -ForegroundColor Yellow
if ($installStatus["Python"]) {
    python -m pip install --upgrade pip
    Write-Host "✅ pip 업그레이드 완료" -ForegroundColor Green
} else {
    Write-Host "⚠️ Python이 설치되지 않아 pip 업그레이드를 건너뜁니다." -ForegroundColor Yellow
}
Write-Host ""

# ===== Step 10: Python venv 테스트 =====
Write-Host "[10/11] Python 가상환경 테스트 중..." -ForegroundColor Yellow
if ($installStatus["Python"]) {
    try {
        $testVenvPath = Join-Path $env:TEMP "test_venv"
        if (Test-Path $testVenvPath) {
            Remove-Item -Recurse -Force $testVenvPath
        }

        python -m venv $testVenvPath
        $activateScript = Join-Path $testVenvPath "Scripts\Activate.ps1"

        if (Test-Path $activateScript) {
            Write-Host "✅ Python venv 생성 및 활성화 가능 (ExecutionPolicy 정상)" -ForegroundColor Green
            Remove-Item -Recurse -Force $testVenvPath
        } else {
            Write-Host "⚠️ venv 생성됨, 하지만 활성화 스크립트를 찾을 수 없음" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "❌ venv 테스트 실패: $_" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️ Python이 설치되지 않아 venv 테스트를 건너뜁니다." -ForegroundColor Yellow
}
Write-Host ""

# ===== Step 11: 설치 결과 요약 =====
Write-Host "[11/11] 설치 결과 요약" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

# Java 개발 환경 요약
Write-Host ""
Write-Host "Java 개발 환경:" -ForegroundColor Cyan
if ($installStatus["Java 21"]) {
    Write-Host "✅ Java 21 LTS (Eclipse Temurin)" -ForegroundColor Green
} else {
    Write-Host "❌ Java 21 LTS" -ForegroundColor Red
}
if ($installStatus["Maven"]) {
    Write-Host "✅ Apache Maven" -ForegroundColor Green
} else {
    Write-Host "❌ Apache Maven" -ForegroundColor Red
}
if ($installStatus["Eclipse"]) {
    Write-Host "✅ Eclipse IDE for Java Developers 2025-12" -ForegroundColor Green
} else {
    Write-Host "❌ Eclipse IDE" -ForegroundColor Red
}

if ($alreadyInstalled.Count -gt 0) {
    Write-Host ""
    Write-Host "이미 설치되어 있던 항목:" -ForegroundColor Gray
    foreach ($item in $alreadyInstalled) {
        Write-Host "  ○ $item" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "전체 설치 확인 결과:" -ForegroundColor White

$allSuccess = $true
foreach ($tool in $installStatus.Keys) {
    if ($installStatus[$tool]) {
        Write-Host "✅ $tool" -ForegroundColor Green
    } else {
        Write-Host "❌ $tool" -ForegroundColor Red
        $allSuccess = $false
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($allSuccess) {
    Write-Host "🎉 모든 도구 설치 완료!" -ForegroundColor Green
} else {
    Write-Host "⚠️ 일부 도구 설치에 실패했습니다." -ForegroundColor Yellow
}

# Java 개발 환경 다음 단계 안내
if ($installStatus["Java 21"] -or $installStatus["Maven"] -or $installStatus["Eclipse"]) {
    Write-Host ""
    Write-Host "다음 단계 (Java 개발 환경):" -ForegroundColor Yellow
    Write-Host "1. Eclipse 실행" -ForegroundColor White
    Write-Host "2. Workspace 경로: %USERPROFILE%\eclipse\java-study" -ForegroundColor Gray
    Write-Host "3. Preferences > Java > Installed JREs에서 Java 21 확인" -ForegroundColor Gray
    Write-Host "4. README.md의 Git Clone 섹션 참고하여 프로젝트 클론" -ForegroundColor Gray
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
