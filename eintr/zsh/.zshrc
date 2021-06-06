# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

echo $USER@$HOST  $(uname -srm) #$(lsb_release -rcs)
neofetch|lolcat
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/eintr/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


alias ls='exa'
alias ll='ls -l'
alias sl='ls'

alias ems='emacsclient -c -nw'

alias lssh='ssh -o ServerAliveInterval=60'
alias rssh='lssh -fNTCR localhost:2333:localhost:22 eintr@192.168.23.169'

alias h3c1='lssh -p 20122 h3c@220.194.140.188'
alias h3c2='lssh -p 20222 h3c@220.194.140.188'
alias vh3c1='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 -p 20122 root@220.194.140.188:/root ~/Share/H3C1 -p 22 -C'
alias vh3c2='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 -p 20222 root@220.194.140.188:/root ~/Share/H3C2 -p 22 -C'

alias tyut='lssh root@192.168.23.169'
alias ubuntu='lssh eintr@121.196.144.74'
alias subuntu='lssh eintr@116.62.132.195'

alias vubuntu='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 eintr@121.196.144.74:$HOME ~/Share/Ubuntu -p 22 -C'
alias vtyut='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 root@192.168.23.169:/home ~/Share/Tyut -p 22 -C'

alias reboot='sudo reboot'
alias gbkunzip='unzip -O cp936'
alias cvim='vim scp://eintr@175.24.24.112//home/eintr/'
alias watchnvidia='watch -n 1 nvidia-smi'
alias mongodb='mongod --dbpath ~/Share/mongodb/data'

alias xmind='cd /home/eintr/Share/XMind/XMind_amd64 ;nohup XMind 2> /dev/null&;cd -'
alias vi='vim'
alias ntfs='sudo ntfsfix /dev/sdc'
filehash(){
    cat $1 | openssl dgst -sha256 | base64
}
#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"

 #替换rm指令移动文件到~/.trash/中
alias rmt='Trash'
Trash()
{
    mv $@ ~/.local/share/Trash/files/
}

dict()
{
    wd $1 |bat
}

export GOPATH=~/GOPATH  #默认安装包的路径
export GOBIN=~/GOPATH/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

export PATH=$PATH:$GOBIN:/home/eintr/.local/bin~/.npm-global/bin:~/.emacs.d/bin

export RABBITMQ_SERVER=amqp://test:test@192.168.4.1:5672

export MANPATH=$HOME/Share/Man/:$MANPATH

export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

# 启用starship
eval "$(starship init zsh)"
