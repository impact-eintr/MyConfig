## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
#export EDITOR=/usr/bin/nano
#export VISUAL=/usr/bin/nano
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# enable substitution for prompt
setopt prompt_subst

# Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
#PROMPT="%(!.%{$fg[red]%}[%n@%m %1~]%{$reset_color%}# .%{$fg[green]%}[%n@%m %1~]%{$reset_color%}$ "
# Maia prompt
PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b " # Print some system information when the shell is first started
# Print a greeting message when shell is started
echo $USER@$HOST  $(uname -srm) #$(lsb_release -rcs)
neofetch
## Prompt on right side:
#  - shows status of git when in git repository (code adapted from https://techanic.net/2012/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
#  - is invisible, if neither is the case

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
    # Show Git branch/tag, or name-rev if on detached head
    ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
    # Show different symbols as appropriate for various Git repository states
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi
    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi
    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi
    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

git_prompt_string() {
    local git_where="$(parse_git_branch)"

  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"

  # If not inside the Git repo, print exit codes of last command (only if it failed)
  [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

# Right prompt with exit status of previous command if not successful
#RPROMPT="%{$fg[red]%} %(?..[%?])"
# Right prompt with exit status of previous command marked with ✓ or ✗
#RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## Plugins section: Enable fish style features
# Use syntax highlighting
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
    login)
        RPROMPT="%{$fg[red]%} %(?..[%?])"
        alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
        ;;
    #  'tmux: server')
        #        RPROMPT='$(git_prompt_string)'
        #       ## Base16 Shell color themes.
        #       #possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
        #       #atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties,
        #       #embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
        #       #marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
        #       #solarized, summerfruit, tomorrow, twilight
        #       #theme="eighties"
        #       #Possible variants: dark and light
        #       #shade="dark"
        #       #BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
        #       #[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
        #       # Use autosuggestion
        #       source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        #       ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        #       ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
        #     ;;
    *)
        RPROMPT='$(git_prompt_string)'
        # Use autosuggestion
        #source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
        ;;
esac




export ZSH="/home/eintr/.oh-my-zsh"
ZSH_THEME="random"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
plugins=(git sudo)
source $ZSH/oh-my-zsh.sh
alias sl='ls'
alias grep='grep --color=auto'
alias lssh='ssh -o ServerAliveInterval=60'
alias rssh='lssh -fNTCR localhost:5000:localhost:22 yixingwei@175.24.24.112'
alias termux='lssh -p 8022 u0_a231@192.168.31.169'
alias sshr='autossh -M 55555  -NfR 0.0.0.0:23333:localhost:22 yixingwei@175.24.24.112'
alias chtop='lssh htoper@175.24.24.112'
alias centos='lssh yixingwei@175.24.24.112'
alias vcentos='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 yixingwei@175.24.24.112:$HOME ~/Share/Centos -p 22 -C'
alias varchfast='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 eintr@192.168.1.20:/home/eintr ~/Share/arch -p 22 -C'
alias varchnormal='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 eintr@192.168.31.235:/home/eintr ~/Share/arch -p 22 -C'
alias vtermux='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 u0_a231@192.168.31.169:/data/data/com.termux/files/home ~/Share/Termux -p 8022 -C'
alias vkali='sshfs -p 4022 yixingwei@localhost:$HOME ~/Share/Kali;lssh -p 4022 yixingwei@127.0.0.1'
alias vfedora='sshfs -p 5022 yixingwei@localhost:$HOME ~/Share/Fedora;lssh  -p 5022 yixingwei@127.0.0.1'
alias vubuntu='sshfs -p 6022 yixingwei@localhost:$HOME ~/Share/Fedora;lssh  -p 6022 yixingwei@127.0.0.1'

alias cvim='vim scp://yixingwei@175.24.24.112//home/yixingwei/'
alias cmongo='mongo 175.24.24.112:27017/admin -uyixingwei -p'
alias cmysql='mysql -h 175.24.24.112 -uroot -p'
alias watchnvidia='watch -n 1 nvidia-smi'
alias mongodb='mongod --dbpath ~/Share/mongodb/data'
alias xmind='cd /home/yixingwei/Share/XMind/XMind_amd64 ;nohup XMind>log&;cd -'
alias matlab='/run/media/yixingwei/新加卷/MATLAB/R2017a/bin/matlab'
#alias tf2='source activate tf2-gpu'
alias penv='python3 -m venv --system-site-packages /home/eintr/Projects/BigData/venv && source /home/eintr/Projects/BigData/venv/bin/activate'
#out : source deactivate
alias mat='matlab -nodesktop -nosplash'
alias rmt='Trash'
alias vi='vim'
alias ntfs='sudo ntfsfix /dev/sdc'
alias typora='Typora'
#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"
    #替换rm指令移动文件到~/.trash/中
Trash()
{
    mv $@ ~/.local/share/Trash/files/
}

tim()
{
    /usr/lib/gsd-xsettings &;
    sleep 3;
    /opt/deepinwine/apps/Deepin-TIM/run.sh
}
dict()
{
    wd $1 |bat
}
export GOPATH=$HOME/Projects/GOPATH  #默认安装包的路径
export GOBIN=$HOME/Projects/GOPATH/bin
export PATH=$PATH::/home/eintr/Share/XMind/XMind_amd64:$GOPATH/bin:/home/eintr/Share/openrefine-3.4.1:/home/eintr/.local/bin:/home/eintr/Share/typora/

export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export JAVA_HOME=/usr/lib64/jvm/jre-1.8.0-openjdk/
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}


