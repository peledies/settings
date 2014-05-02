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
echo "Copying git_list_remotes_by_date to /usr/local/bin/"
if sudo cp "$system_source""git_list_remotes_by_date" "/usr/local/bin/git_list_remotes_by_date"
then
	echo "${green}Success"
else
	echo "${red}"
fi
source ~/.bash_profile
echo "${red}"
echo "You must run 'source ~/.bash_profile' in order for the settings to be fully in effect in this tty. The changes should be in effect for all new tty's"
