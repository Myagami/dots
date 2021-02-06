#compinit
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#path
PATH="$PATH:/home/karen/.cask/bin"
PATH="$PATH:/home/karen/Tools"
PATH="$PATH:/home/karen/Tools/SimuTools/Automake_Tools_rb"
PATH="$PATH:/home/karen/Tools/SimuTools/Thumb_Create"
PATH="$PATH:/home/karen/Tools/SimuTools/Dat_Inspection"
PATH="$PATH:/home/karen/sh"

export PATH

#prompt
PROMPT='[%n@%m]
%~:'

#zsh
#RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

#history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

#terminal title
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

#alias
#grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#ls
alias ls='ls --color=auto'
alias la='ls -a'
alias lla='ls -la'
alias ll='ls -lh'
alias lq='ls -Q'
alias ld='ls -F | grep /'
alias lf='ls -F | grep -v /'

#git
alias gstat='git status'
alias gadd='git add'
alias gcom='git commit'

#shell
alias cpr='cp -r'
alias cdu='cd ../'
alias relogin='exec $SHELL -l'
alias reload='source ~/.zshrc'

#tmux
alias tnews='tmux new-session -s'
alias tats='tmux a -t'
alias tlst='tmux list-session'

#shortcut
alias java8='/usr/lib/jvm/java-8-openjdk-i386/jre/bin/java'
alias emacsc='/usr/bin/emacsclient -a "" -c'


#PERL5LIB="/home/honoka/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/honoka/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/honoka/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/honoka/perl5"; export PERL_MM_OPT;

if [ "$LANGUAGE" = "ja_JP:en" ]; then
    export UNZIP="-O cp932"
    export ZIPINFO="-O cp932"
fi

#wsl
setopt no_beep
