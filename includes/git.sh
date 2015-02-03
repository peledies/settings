echo "${cyan}Setting Up GIT"

if hash git 2>/dev/null;
  then
    echo "${gold}What username do you want to use with GIT?${cyan}"
    read name
    git config --global user.name $name

    echo "${gold}What email do you want to use with GIT?${cyan}"
    read email
    git config --global user.email $email

    echo "${gold}\nUsing ~/.gitignore for global"
    git config --global core.excludesfile ~/.gitignore
    echo "${green}  Success"

    echo "${gold}\nOverwriting $system_target.gitignore_global${red}"
    if cp "$system_source/.gitignore_global" "$system_target"
      then
        echo "${green}  Success"
    fi


    if [ ! -d "/usr/share/git-core/" ]
      then
        echo "${gold}\nCreating appropriate file structure for GIT Core plugins${red}"
        if sudo mkdir -p "/usr/share/git-core/"
          then
            echo "${green}  Success"
        fi
    fi


    echo "${gold}\nAdding gitignore to your global git configuration"
    git config --global core.excludesfile $system_target.gitignore_global
    echo "${green}  Success"


    echo "${gold}\nCreating shell script to use the OS X diff tool with GIT${red}"
    if sudo cp "$system_source/git-diff-cmd.sh" "/usr/share/git-core/git-diff-cmd.sh"
      then
        echo "${green}  Success"
    fi

    echo "${gold}\nImporting GIT Completion script${red}"
    if [ ! -f "/usr/share/git-core/git-completion.bash" ]
      then
        if sudo cp "$system_source/git-completion.bash" "/usr/share/git-core/"
          then
            echo "${green}  Success"
        fi
      else
        echo "${green}  Script already exists, moving on."
    fi

    echo "${gold}\nImporting git-prompt to put your branch in your bash prompt${red}"
    if [ ! -f "/usr/share/git-core/git-prompt.sh" ]
      then
        if sudo cp "$system_source/git-prompt.sh" "/usr/share/git-core/"
          then
            echo "${green}  Success"
        fi
      else
        echo "${green}  Script already exists, moving on."
    fi


    echo "${gold}\nImporting gitk${red}"
    if hash gitk 2>/dev/null;
      then
        echo "${green}  Script already exists, moving on."
      else    
        if sudo cp "$system_source/gitk" "/usr/local/bin/gitk"
          then
            echo "${green}  Success"
        fi
    fi


    echo "${gold}\nImporting the latest version of git-stale${red}"
    if hash git-stale 2>/dev/null;
      then
        echo "${green}  Script already exists, moving on."
      else    
        if curl "https://raw.githubusercontent.com/peledies/git-stale/master/git-stale" > "$system_source""git-stale"
          then
            echo "${green}  Success"
        fi
    fi

    if [ -f git-stale ]
      then
        echo "${gold}\nFixing permissions on git-stale"
        if chmod 755 git-stale
          then
            echo "${green}  Success"
        fi

        echo "${gold}\nMoving git-stale${red}"
        if sudo cp "$system_source/git-stale" "/usr/local/bin/git-stale"
          then
            echo "${green}  Success"
        fi


        echo "${gold}\nCleaning up temporary files.${red}"
        if rm "$system_source/git-stale"
          then
            echo "${green}  Success"
        fi
    fi


  # End of git check
  else
    echo "${red}You need to install GIT before you can run this portion of the configuration!"
fi
