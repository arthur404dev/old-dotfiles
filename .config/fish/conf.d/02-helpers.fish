# OS detection
set -g IS_MACOS false
set -g IS_LINUX false
set -g IS_WSL false

if string match -q "*darwin*" (uname -s)
    set -g IS_MACOS true
else if string match -q "*Linux*" (uname -s)
    if test -f /proc/version; and string match -q "*Microsoft*" (cat /proc/version)
        set -g IS_WSL true
    else
        set -g IS_LINUX true
    end
end
