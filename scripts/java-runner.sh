#!/bin/bash
# ==============================================================================
# java-runner.sh - Platform-agnostic launcher
# Detects platform and delegates to appropriate script
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Detect platform
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    # Linux or macOS
    exec "$PROJECT_ROOT/platforms/linux/scripts/java-runner.sh" "$@"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash, MSYS, Cygwin)
    exec "$PROJECT_ROOT/platforms/windows/scripts/java-runner.bat" "$@"
else
    echo "Unsupported platform: $OSTYPE"
    exit 1
fi
