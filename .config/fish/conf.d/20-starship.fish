# Downloads starship if not installed
if test ! -f /usr/local/bin/starship
    curl -sS https://starship.rs/install.sh | sh -s -- -y
end

# Find out which distribution we are running on
set -l _distro ""
set -l LFILE "*-release"
set -l MFILE "/System/Library/CoreServices/SystemVersion.plist"

if test -f /etc/*-release
    set _distro (awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
else if test -f $MFILE
    set _distro "macos"
    # On macOS use the systemprofiler to determine the current model
    set -l _device (system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5,$6,$7}')

    switch $_device
        case '*MacBook*'
            set DEVICE ""
        case '*mini*'
            set DEVICE "󰇄"
        case '*'
            set DEVICE ""
    end
end

# Checks the device based if a power-supply is present or not
if test -d "/proc/acpi/battery/BAT*"
    set DEVICE ""
else
    set DEVICE "󰟀"
end

# Set an icon based on the distro
switch $_distro
    case '*kali*'
        set ICON ""
    case '*arch*'
        set ICON ""
    case '*debian*'
        set ICON ""
    case '*raspbian*'
        set ICON ""
    case '*ubuntu*'
        set ICON ""
    case '*elementary*'
        set ICON ""
    case '*fedora*'
        set ICON ""
    case '*coreos*'
        set ICON ""
    case '*gentoo*'
        set ICON ""
    case '*garuda*'
        set ICON ""
    case '*mageia*'
        set ICON ""
    case '*centos*'
        set ICON ""
    case '*opensuse*' '*tumbleweed*'
        set ICON ""
    case '*sabayon*'
        set ICON ""
    case '*slackware*'
        set ICON ""
    case '*linuxmint*'
        set ICON ""
    case '*alpine*'
        set ICON ""
    case '*aosc*'
        set ICON ""
    case '*nixos*'
        set ICON ""
    case '*devuan*'
        set ICON ""
    case '*manjaro*'
        set ICON ""
    case '*rhel*'
        set ICON ""
    case '*macos*'
        set ICON ""
    case '*'
        set ICON "󰌽"
end

set -gx STARSHIP_DISTRO "$ICON"
set -gx STARSHIP_DEVICE "$DEVICE"

# Load Starship
if command -v starship >/dev/null
    starship init fish | source
end
