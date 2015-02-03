echo "${cyan}🍺 Intalling Homebrew 🍺"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"    

echo "\n${gold}"
read -p "🍺 Do you want to install logstalgia? [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "${gold}Installing  the latest version of logstalgia${red}"
    if brew install logstalgia
      then
        echo "${green}  Success"
    fi
fi

echo "\n${gold}"
read -p "Do you want to install wget? [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "${gold}Installing  the latest version of wget${red}"
    if brew install wget
      then
        echo "${green}Success"
    fi
fi
