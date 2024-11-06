# Downloads starship if not installed
if [ ! -f /usr/local/bin/starship ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# find out which distribution we are running on
LFILE="*-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"
if find /etc/ -maxdepth 1 -name $LFILE 2>/dev/null | grep -q .; then
    _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
elif [[ -f $MFILE ]]; then
    _distro="macos"

    # on mac os use the systemprofiler to determine the current model
    _device=$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5,$6,$7}')

    case $_device in
    *MacBook*) DEVICE="" ;;
    *mini*) DEVICE="󰇄" ;;
    *) DEVICE="" ;;
    esac
fi

# Checks the device based if a power-suppy is present or not
if [ -d "/proc/acpi/battery/BAT*" ]; then
    DEVICE=""
else
    DEVICE="󰟀"
fi

# set an icon based on the distro
case $_distro in
*kali*) ICON="" ;;
*arch*) ICON="" ;;
*debian*) ICON="" ;;
*raspbian*) ICON="" ;;
*ubuntu*) ICON="" ;;
*elementary*) ICON="" ;;
*fedora*) ICON="" ;;
*coreos*) ICON="" ;;
*gentoo*) ICON="" ;;
*garuda*) ICON="" ;;
*mageia*) ICON="" ;;
*centos*) ICON="" ;;
*opensuse* | *tumbleweed*) ICON="" ;;
*sabayon*) ICON="" ;;
*slackware*) ICON="" ;;
*linuxmint*) ICON="" ;;
*alpine*) ICON="" ;;
*aosc*) ICON="" ;;
*nixos*) ICON="" ;;
*devuan*) ICON="" ;;
*manjaro*) ICON="" ;;
*rhel*) ICON="" ;;
*macos*) ICON="" ;;
*) ICON="󰌽" ;;
esac

export STARSHIP_DISTRO="$ICON"
export STARSHIP_DEVICE="$DEVICE"

# Load Starship
# Fixes: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null ||
    {
        eval "$(/usr/local/bin/starship init zsh)"
    }
