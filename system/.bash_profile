export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxededabagadad
# LSCOLORS generator http://geoff.greer.fm/lscolors/
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH

#Git configuration stuff
source ~/settings/system/git-completion.bash
source ~/settings/system/git-prompt.sh
export PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\W\[\033[35m\]$(git_repo)$(__git_ps1)\[\033[00m\]\$ '

#Editor config
EDITOR='vi'
export EDITOR
VISUAL='vi'
export VISUAL

# put the PWD in the tab title
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

git_repo(){
  TL=$(git rev-parse --show-toplevel 2>&1)
  if [ "$?" = "0" ]; then
    echo " [$(basename `git rev-parse --show-toplevel`)]"
  fi
}