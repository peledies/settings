echo "${cyan}Setting up Sublime Text 3 Development Environment"

sublime_source=$scriptSrc/sublime
sublime_target=/Users/$(whoami)/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
sublime_bin=/Applications/Sublime\ Text.app

if [ ! -d "$sublime_target" ]
  then
    mkdir -p "$sublime_target"
fi

echo "${gold}\nImporting PurprleNurple theme${red}"
if cp -r "$sublime_source/themes/PurpleNurple.tmTheme" "$sublime_target/themes/PurpleNurple.tmTheme"
  then
    echo "${green}  Success"
fi
   
echo "${gold}\nImporting user preferences${red}"
if cp -r "$sublime_source/Preferences.sublime-settings" "$sublime_target/Preferences.sublime-settings"
  then
    echo "${green}  Success"
fi

if [ ! -d ~/sublime_text_snippets ]
  then
  echo "${gold}\nImporting Deac's Snippets${red}"
  if git clone https://github.com/peledies/sublime_snippets.git ~/sublime_text_snippets
    then
      echo "${green}  Success"
  fi
fi

echo "${gold}\nRemoving default snippets directory${red}"
if rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets
  then
    echo "${green}  Success"
fi

echo "${gold}\nCreating symlink to ~/sublime_text_snippet for your convenience${red}"
if ln -s ~/sublime_text_snippets/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/snippets 
  then
    echo "${green}  Success"
fi

echo "${gold}\nCreating alias to allow opening files and directories in Sublime Text from the terminal${red}"
if ln -sfn "$sublime_bin"/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
  then
    echo "${green}  Success"
fi