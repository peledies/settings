#!/bin/sh
green=$(tput bold)$(tput setaf 2)
red=$(tput bold)$(tput setaf 1)
gold=$(tput bold)$(tput setaf 3)

scriptSrc="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sublime_source=$scriptSrc/sublime/
if [ -d "/Users/$(whoami)/Library/Application Support/Sublime Text 3" ]
then
	sublime_target=/Users/$(whoami)/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
else
	sublime_target=/Users/$(whoami)/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/
fi
if [ -d "/Applications/Sublime Text 2.app" ]
then
	sublime_bin=/Applications/Sublime\ Text\ 2.app
else
	sublime_bin=/Applications/Sublime\ Text.app
fi
system_source=$scriptSrc/system/
system_target=/Users/$(whoami)/
echo "${gold}"
if [ ! -d "/usr/local/bin" ]
then
	sudo mkdir -p /usr/local/bin
fi
echo "${gold}"
if [ -d "$sublime_target" ]
then
	echo "Moving sublime settings into appropriate locations"
	if cp -r "$sublime_source" "$sublime_target"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
else
	echo "Creating appropriate file structure for Sublime settings"
	mkdir -p "$sublime_target"
	if cp -r "$sublime_source" "$sublime_target"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
fi
if [ ! -d ~/sublime_text_snippets ]
  then
  if git clone https://github.com/peledies/sublime_snippets.git ~/sublime_text_snippets
    then
      rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
      ln -s ~/sublime_text_snippets/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
      echo "${green}Success"
    else
      echo "${red}"
    fi
  else
      echo "${gold}Sublime Snippets directory already exists, creating Symlink to sublime_text_snippets directory for sublime text"
      rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
      ln -s ~/sublime_text_snippets/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
  fi
echo "${gold}"
echo "overwriting $system_target.ssh/config"
if cp "$system_source/config" "$system_target.ssh/config"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "overwriting $system_target.bash_profile"
if cp "$system_source.bash_profile" "$system_target"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "overwriting $system_target.vimrc"
if cp "$system_source.vimrc" "$system_target"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "overwriting $system_target.gitconfig"
if cp "$system_source.gitconfig" "$system_target"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "${gold}What username do you want to use with GIT?${red}"
read name
git config --global user.name $name
echo "${gold}"
echo "What email do you want to use with GIT?${red}"
read email
git config --global user.email $email
echo "${gold}"
echo "Using ~/.gitignore for global"
git config --global core.excludesfile ~/.gitignore
echo ""
echo "overwriting $system_target.gitignore_global"
if cp "$system_source.gitignore_global" "$system_target"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "adding git ignore to your global git configuration"
git config --global core.excludesfile $system_target.gitignore_global
echo "${green}Success"
echo "${gold}"
echo "creating shell script to use the OS X diff tool with GIT"
if sudo cp "$system_source""git-diff-cmd.sh" "/usr/share/git-core/git-diff-cmd.sh"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "creating sublime text alias to allow opening files or folders in sublime from the terminal"
if sudo ln -sfn "$sublime_bin"/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
if [ -d "/usr/share/git-core/" ]
then
	if [ ! -f "/usr/share/git-core/git-completion.bash" ]
	then
		echo "Copying git-completion.bash to /usr/share/git-core/"
		if sudo cp "$system_source""git-completion.bash" "/usr/share/git-core/"
		then
			echo "${green}Success"
		else
			echo "${red}"
		fi
		echo "${gold}"
	else
		echo "${green}Keeping existing git-completion.bash"
	fi
	if [ ! -f "/usr/share/git-core/git-prompt.sh" ]
	then
		echo "Copying git-prompt.sh to /usr/share/git-core/"
		if sudo cp "$system_source""git-prompt.sh" "/usr/share/git-core/"
		then
			echo "${green}Success"
		else
			echo "${red}"
		fi
		echo "${gold}"
	else
		echo "${green}Keeping existing git-prompt.sh"
	fi

else
	echo "Creating appropriate file structure for GIT completion"
	if sudo mkdir -p "/usr/share/git-core/"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
	echo "${gold}"

	echo "Copying git-completion.bash to /usr/share/git-core/"
	if sudo cp "$system_source""git-completion.bash" "/usr/share/git-core/"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
	echo "${gold}"
	echo "Copying git-prompt.sh to /usr/share/git-core/"
	if sudo cp "$system_source""git-prompt.sh" "/usr/share/git-core/"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
	echo "${gold}"

fi
if which gitk >/dev/null; then
    echo "${green}Keeping existing gitk"
else
    echo "${gold}"
	echo "Copying gitk to /usr/local/bin/gitk"
	if sudo cp "$system_source""gitk" "/usr/local/bin/gitk"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
	echo "${gold}"
fi
echo "${gold}"
echo "${green}Fetching the latest version of git-stale"
if curl "https://raw.githubusercontent.com/peledies/git-stale/master/git-stale" > "$system_source""git-stale"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"
echo "Copying git-stale to /usr/local/bin/"

if sudo cp "$system_source""git-stale" "/usr/local/bin/git-stale"
then
	echo "${green}Success"
else
	echo "${red}"
fi
echo "${gold}"

read -p "Do you want to install Homebrew? It will take quite a while: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Intalling Homebrew"
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    
fi

echo "${gold}Installing  the latest version of logstalgia"
if brew install logstalgia
then
	echo "${green}Success"
else
	echo "${red}"
fi

echo "${gold}Installing  the latest version of wget"
if brew install wget
then
	echo "${green}Success"
else
	echo "${red}"
fi

read -p "Do you want to install node and npm? It could take quite a while: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "${gold}Installing the latest version of node and npm"
	if brew install node
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi 
fi

echo "${gold}Installing the latest version of grunt-cli with the global option -g"
if npm install -g grunt-cli
then
	echo "${green}Success"
else
	echo "${red}"
fi

echo "${gold}Installing the latest version of bower with the global option -g"
if npm install -g bower
then
	echo "${green}Success"
else
	echo "${red}"
fi

echo "${gold}"
echo "${green}Fetching the latest version of composer for php"
if curl -sS "https://getcomposer.org/installer" | php
then
	echo "${green}Success"
	echo "${green}moving composer to /usr/local/bin"
	if sudo mv "composer.phar" "/usr/local/bin/composer"
	then
		echo "${green}Success"
	else
		echo "${red}"
	fi
else
	echo "${red}"
fi

echo "${gold}"
echo "Cleaning up temporary files."
if rm "$system_source""git-stale"
then
	echo "${green}git-stale removed"
else
	echo "${red}"
fi


source ~/.bash_profile
echo "${red}"
echo "You must run 'source ~/.bash_profile' in order for the settings to be fully in effect in this tty. The changes should be in effect for all new tty's"
