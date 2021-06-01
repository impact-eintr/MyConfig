echo $USER@$HOST  $(uname -srm) #$(lsb_release -rcs)
neofetch|lolcat

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

alias ls='exa'
alias sl='ls'

alias ems='emacsclient -c -nw'

alias volup='amixer -D pulse set Master 5%+'
alias voldown='amixer -D pulse set Master 5%-'

#alias lssh='proxychains4 ssh -o ServerAliveInterval=60'
alias lssh='ssh -o ServerAliveInterval=60'
alias rssh='lssh -fNTCR localhost:2333:localhost:22 eintr@192.168.23.169'
alias termux='lssh -p 8022 u0_a231@192.168.31.169'

alias h3c1='lssh -p 20122 h3c@220.194.140.188'
alias h3c2='lssh -p 20222 h3c@220.194.140.188'
alias vh3c1='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 -p 20122 root@220.194.140.188:/root ~/Share/H3C1 -p 22 -C'
alias vh3c2='sshfs -o allow_other -o reconnect -o ServerAliveInterval=15 -p 20222 root@220.194.140.188:/root ~/Share/H3C2 -p 22 -C'

alias titan='lssh titanscp@192.168.1.108'
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
alias tf2='source activate tf2-gpu'
#out : source deactivate
alias rmt='Trash'
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

export PATH=$PATH::/home/eintr/Share/mongodb/bin:/home/eintr/Share/XMind/XMind_amd64:$GOPATH/bin:/opt/anaconda/bin:/opt/foxitsoftware/foxitreader:/opt/qv2ray:/home/eintr/.local/bin:/var/lib/snapd/snap/bin:/home/eintr/Share/openrefine-3.4.1:~/.npm-global/bin:~/.emacs.d/bin

export RABBITMQ_SERVER=amqp://test:test@192.168.4.1:5672

export MANPATH=$HOME/Share/Man/:$MANPATH


# 启用starship
eval "$(starship init zsh)"
