#!/bin/sh
scriptSrc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "/usr/local/bin" ]
then
  sudo mkdir -p /usr/local/bin
fi

source includes/font.sh
source includes/paths.sh


read -p "Do you want to set up your Terminal environment: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    source includes/terminal.sh
fi

echo "\n"
read -p "Do you want to set up a Sublime Text 3 development environment: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    source includes/sublime.sh
fi

echo "\n"
read -p "🍺 Do you want to install Homebrew? It will take quite a while: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    source includes/homebrew.sh
fi

echo "\n"
read -p "Do you want to install Web Devloper Tools: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    source includes/webdev.sh
fi

echo "\n"
read -p "Do you want to set up your GIT Environment: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    source includes/git.sh
fi

source ~/.bash_profile
echo "\n${cyan}The settings are in effect for all new tty's\n"
echo "You must run ${red}'source ~/.bash_profile'${cyan} in order for the settings to be fully in effect in this tty."