export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxededabagadad

export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH

alias err='tail -f ~/Sites/error_log'
alias vi='vim'
alias brc_pong='ssh -p 4022 deac@sdicgdev.com tail -f -n 1 /home/deac/access_logs/brc_access_log | logstalgia - -x'
alias sportcamps_pong='ssh -p 45667 root@216.246.6.171 tail -f -n 1 /etc/httpd/logs/access_log | logstalgia - -x'
alias sdb_pong='ssh -i ~/weekliokp.pem root@ec2-54-243-201-148.compute-1.amazonaws.com tail -f -n 1 /var/log/httpd/schooldatebooks.com-access_log | logstalgia - -x'

#Git configuration stuff
source /usr/share/git-core/git-completion.bash
source /usr/share/git-core/git-prompt.sh
export PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[35m\]$(__git_ps1)\[\033[00m\]\$ '

#Editor config
EDITOR='vi'
export EDITOR
VISUAL='vi'
export VISUAL
