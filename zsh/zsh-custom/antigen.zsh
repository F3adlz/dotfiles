source /usr/share/zsh/share/antigen.zsh

# antigen use oh-my-zsh

antigen bundle ansible
antigen bundle archlinux
# antigen bundle autojump
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle fzf
antigen bundle git
antigen bundle gradle
antigen bundle helm # completions
antigen bundle history
antigen bundle httpie
antigen bundle kubectl
antigen bundle npm
antigen bundle pip
antigen bundle systemd
antigen bundle terraform
antigen bundle yarn
antigen bundle zoxide

# antigen bundle marlonrichert/zsh-autocomplete@main
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# antigen theme Chill/chill

antigen apply
