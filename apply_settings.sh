#!/bin/sh
sublime_source=$(pwd)/sublime/
sublime_target=/Users/$(whoami)/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/
system_source=$(pwd)/system/
system_target=/Users/$(whoami)/
if [ -d "$sublime_target" ]
then
	echo "Moving sublime settings into appropriate locations"
	cp -r "$sublime_source" "$sublime_target"
else
	echo "Creating appropriate file structure for Sublime settings"
	mkdir -p "$sublime_target"
	cp -r "$sublime_source" "$sublime_target"
fi

echo "overwriting $system_target.bash_profile"
cp "$system_source.bash_profile" "$system_target"

echo "overwriting $system_target.vimrc"
cp "$system_source.vimrc" "$system_target"

echo "overwriting $system_target.gitconfig"
cp "$system_source.gitconfig" "$system_target"

echo "overwriting $system_target.gitignore_global"
cp "$system_source.gitignore_global" "$system_target"

echo "adding git ignore to your global git configuration"
git config --global core.excludesfile $system_target.gitignore_global

echo "creating shell script to use the OS X diff tool with GIT"
sudo cp "$system_source""git-diff-cmd.sh" "/usr/share/git-core/git-diff-cmd.sh"

echo "creating sublime text 2 alias to allow opening files or folders in sublime from the terminal"
sudo ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
if [ -d "/usr/share/git-core/" ]
then
	if [ ! -f "/usr/share/git-core/git-completion.bash" ]
	then
		echo "Copying git-completion.bash to /usr/share/git-core/"
		sudo cp "$system_source""git-completion.bash" "/usr/share/git-core/"
	else
		echo "Keeping existing git-completion.bash"
	fi
	if [ ! -f "/usr/share/git-core/git-prompt.sh" ]
	then
		echo "Copying git-prompt.sh to /usr/share/git-core/"
		sudo cp "$system_source""git-prompt.sh" "/usr/share/git-core/"
	else
		echo "Keeping existing git-prompt.sh"
	fi

else
	echo "Creating appropriate file structure for GIT completion"
	sudo mkdir -p "/usr/share/git-core/"

	echo "Copying git-completion.bash to /usr/share/git-core/"
	sudo cp "$system_source""git-completion.bash" "/usr/share/git-core/"

	echo "Copying git-prompt.sh to /usr/share/git-core/"
	sudo cp "$system_source""git-prompt.sh" "/usr/share/git-core/"

fi
echo "You must run 'source ~/.bash_profile' in order for the settings to be fully in effect"
