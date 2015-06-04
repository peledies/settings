export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxededabagadad
# LSCOLORS generator http://geoff.greer.fm/lscolors/
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH

#Git configuration stuff
source /usr/share/git-core/git-completion.bash
source /usr/share/git-core/git-prompt.sh
export PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[35m\]$(__git_ps1)\[\033[00m\]\$ '

#Editor config
EDITOR='vi'
export EDITOR
VISUAL='vi'
export VISUAL
