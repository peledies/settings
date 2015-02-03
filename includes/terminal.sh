echo "${cyan}Setting up the Terminal Environment"

echo "${gold}\nOverwriting $system_target.bash_profile${red}"
if cp "$system_source/.bash_profile" "$system_target"
  then
    echo "${green}  Success"
fi

echo "${gold}\nOverwriting $system_target.vimrc${red}"
if cp "$system_source/.vimrc" "$system_target"
  then
    echo "${green}  Success"
fi

echo "${gold}Overwriting $system_target.gitconfig${red}"
if cp "$system_source/.gitconfig" "$system_target"
  then
    echo "${green}  Success"
fi