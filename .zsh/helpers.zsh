# OS detection
IS_MACOS=false
IS_LINUX=false
IS_WSL=false

[[ "$OSTYPE" == "darwin"* ]] && IS_MACOS=true
[[ "$OSTYPE" == "linux-gnu"* && $(grep -i -c 'Microsoft' /proc/version) -eq 0 ]] && IS_LINUX=true
[[ "$OSTYPE" == "linux-gnu"* && $(grep -i -c 'Microsoft' /proc/version) -gt 0 ]] && IS_WSL=true
