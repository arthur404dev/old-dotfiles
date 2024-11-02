_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

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
