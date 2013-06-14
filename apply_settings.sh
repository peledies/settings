#!/bin/sh
sublime_path=$(pwd)/sublime/
sublime_target=/Users/$(whoami)/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/
system_path=$(pwd)/system/
system_target=/Users/$(whoami)/
if [ -d "$tgt_path" ]
then
	echo "Moving sublime settings into appropriate locations"
	cp -r "$sublime_path" "$sublime_target"
else
	echo "Creating appropriate file structure for Sublime settings"
	mkdir -p "$sublime_target"
	cp -r "$sublime_path" "$sublime_target"
fi

echo "overwriting $system_target.bash_profile"
cp "$system_path.bash_profile" "$system_target"

echo "overwriting $system_target.vimrc"
cp "$system_path.vimrc" "$system_target"

echo "overwriting $system_target.gitconfig"
cp "$system_path.gitconfig" "$system_target"

echo "creating shell script to use the OS X diff tool with GIT"
cp "/usr/bin/git-diff-cmd.sh" "$system_target"

source ~/.bash_profile
