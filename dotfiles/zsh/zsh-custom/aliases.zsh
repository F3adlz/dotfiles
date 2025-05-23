# GLOBAL =======================================================================
alias -g RG=' | rg'

# VARIOUS ======================================================================

## Begin alternatives
alias cat="bat"
alias ping="prettyping --nolegend"
alias top="htop"
alias watch="viddy"
## End alternatives

alias edit="vim"
alias v="vim"
alias vimconfig="vim ~/.vimrc"

# change shell current directory to mc's current dir on exit 
# http://klimer.eu/2015/05/01/use-midnight-commander-like-a-pro/
alias mc=". /usr/lib/mc/mc-wrapper.sh"

alias cpr="cp -r"

alias rm="rm -vi"   # rm verbose, prompt before every removal
alias rr="rm -rfvI" # rm verbose, recursive, prompt once
alias rrs="rm -rvi" # rm verbose, recursive, prompt before every removal

alias catp="bat -p" # plain, no decorations


alias mount="mount | column -t"

alias wis="whatis"

alias glop="glow -p"
alias df="df -h"

alias jq="jq -C"

if is_macos; then
else
    alias open="xdg-open"

    # Pacman/Yay ===================================================================
    alias pacrer="sudo pacman -Rs"
    # clean yay cache (only AUR packages)
    # https://www.reddit.com/r/ManjaroLinux/comments/cst4ou/yay_cache_cleaning/
    alias yacl="yay -Sc --aur"

    # https://wiki.archlinux.org/index.php/Fzf#Pacman
    alias pacs="pacman -Sl | awk '{ if(\$4 != \"[installed]\") { print \$2 }}' | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
    alias yas="yay -Sl | awk '{ if(\$4 != \"[installed]\") { print \$2 }}' | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

    # Network ======================================================================
    alias bton='rfkill unblock bluetooth'
    alias btoff='rfkill block bluetooth'

    # Services =====================================================================
    alias restart_audio="systemctl --user restart pulseaudio"
fi

# ZSH ==========================================================================

alias zshconfig="$EDITOR ~/.zshrc"
alias aliases="$EDITOR ~/.zsh-custom/aliases.zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reload-the-zshrc-file
alias reload="omz reload && echo 'Zsh config reloaded from ~/.zshrc'" 

# EXA ==========================================================================

alias exa="eza --icons"

# display files (including hidden) as list
alias e="exa -la"
# display files (including hidden, . and ..) as list
alias ea="exa -laa"

alias eaa="exa -a -l --list-dirs .*" # show only hidden files (dotfiles)
alias dots=eaa

alias el="exa -l"

# display files (including hidden) and their git status as list
alias elg="exa -la --git"

alias l=el
alias ls=exa
alias la=e
alias lt="el -T"

# Ripgrep ======================================================================
alias rgi="rg -i"  # case insensitive search
alias rgl="rg -l"  # list only the files that match, not content
alias rgt="rg -t"  # match by file extension
alias rgu="rg -uu" # search including ignored and hidden files

# Fd ===========================================================================
alias fdf="fd --type f" # match only files
alias fdh="fdf -H" # also match hidden files and directories
alias fdd="fd --type d" # Match only directories
alias fde="fd --extension" # match by file extension

# Fzf ==========================================================================
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Job ==========================================================================
alias mvs_vpn="nmcli c up MVS"

# History ======================================================================
alias ht='h | tail -n '
alias ht10='h | tail'

# Kubernetes ===================================================================
alias kg="kubectl get"
alias kgn="kubectl get -n"

alias kgcmn="kubectl get cm -n"
alias kgsecn="kubectl get secret -n"

alias kd="kubectl describe"
alias kdn="kubectl describe -n"
alias kdpn="kubectl describe po -n"

alias ktpo="kubectl top po --use-protocol-buffers"
alias ktno="kubectl top no --use-protocol-buffers"

alias krr="kubectl rollout restart"
alias krrn="kubectl rollout restart -n"
alias krrd="kubectl rollout restart deployment"
alias krrdn="kubectl rollout restart deployment -n"

alias kln="kubectl logs -n"
alias klf="kubectl logs -f"
alias klfn="kubectl logs -f -n"

alias kgsn="kubectl get svc -n"

alias ke="kubectl edit"

# Ansible ======================================================================
alias av="ansible-vault"
alias avv="ansible-vault view"
alias ave="ansible-vault edit"
alias ap="ansible-playbook"

# Git ======================================================================
alias gla="git last"
alias gsla="git slast"
alias ghelp="git fuck"
alias gpup="git_push_upstream"
