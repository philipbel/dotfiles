alias pkguu='pkgu && pkgupg'

if hash aptitude >/dev/null 2>&1
    alias pkgi='sudo aptitude install'
    alias pkgr='sudo aptitude remove'
    alias pkgu='sudo aptitude update'
    alias pkgupg='sudo aptitude upgrade'
    alias pkgs='apt-cache search'
    alias pkgl='dpkg -L'
else if hash apt-get >/dev/null 2>&1
    alias pkgi='sudo apt-get install'
    alias pkgr='sudo apt-get remove'
    alias pkgu='sudo apt-get update'
    alias pkgupg='sudo apt-get upgrade'
    alias pkgs='apt-cache search'
else if hash dnf >/dev/null 2>&1
    alias pkgi='sudo dnf install'
    alias pkgr='sudo dnf remove'
    alias pkgu='sudo dnf update'
    alias pkgupg='sudo dnf upgrade'
    alias pkgs='dnf search'
    alias pkgl='rpm -q --filesbypkg'
    alias pkgl='dpkg -L'
else if hash yum >/dev/null 2>&1
    alias pkgi='sudo yum install'
    alias pkgr='sudo yum remove'
    alias pkgu='sudo yum update'
    alias pkgupg='sudo yum upgrade'
    alias pkgs='yum search'
    alias pkgl='rpm -q --filesbypkg'
else if hash pacman >/dev/null 2>&1
    alias pkgi='sudo pacman -S'
    alias pkgr='sudo pacman -R'
    alias pkgu='sudo pacman -U'
    alias pkgupg='sudo pacman -Su'
    alias pkgs='pacman -Qs'
    alias pkgl='pacman -Qn'
else if hash brew >/dev/null 2>&1
    alias pkgi='brew install'
    alias pkgr='brew uninstall'
    alias pkgu='brew update'
    alias pkgupg='brew upgrade'
    alias pkgs='brew search'
    alias pkgl='brew list'
end
