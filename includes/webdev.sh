echo "${cyan}Installing Common Web Developer Tools"



echo "\n${gold}"
read -p "Do you want to install node and npm? It could take quite a while: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    if hash brew 2>/dev/null;
      then
        echo "${gold}\nInstalling the latest version of node and npm${red}"
        if brew install node
          then
            echo "${green}  Success"
        fi 
      else
        echo "${red}  Homebrew is required to install node"
    fi
fi

echo "\n${gold}"
read -p "Do you want to install grunt: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    if hash npm 2>/dev/null;
      then
        echo "${gold}\nInstalling the latest version of grunt-cli with the global option -g${red}"
        if npm install -g grunt-cli
          then
            echo "${green}  Success"
        fi
    else
        echo "${red}  npm is required to install grunt-cli"
    fi
fi



echo "\n${gold}"
read -p "Do you want to install bower: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    if hash npm 2>/dev/null;
      then
        echo "${gold}\nInstalling the latest version of bower with the global option -g${red}"
        if npm install -g bower
          then
            echo "${green}Success"
        fi
    else
        echo "${red}  npm is required to install bower"
    fi
fi


echo "\n${gold}"
read -p "Do you want to install composer for PHP: [Y/y]" -n 2 -r
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "${green}Fetching the latest version of composer for php${red}"
    if curl -sS "https://getcomposer.org/installer" | php
      then
        echo "${green}  Success"
        echo "${green}\nMoving composer to /usr/local/bin${red}"
        if sudo mv "composer.phar" "/usr/local/bin/composer"
          then
            echo "${green}Success"
        fi
    fi
fi
