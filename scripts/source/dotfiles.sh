#! /bin/zsh

function dotfiles() {
    if [[ $# -eq 0 ]];then
        cat << EOF
Usage: dotfiles command option

Commands:
    source - Source current zshrc in dotfiles directory
    update - Get the latest dotfiles version from github
    alias [option] - add/remove/list current dotfiles aliases
    zshrc - print current zshrc file 
EOF
    fi

    if [[ $1 == "source" ]];then
        source ~/.zshrc
    elif [[ $1 == "update" ]];then
        git -C $HOME/dotfiles pull origin master
    elif [[ $1 == "zshrc" ]];then
        cat ~/.zshrc
    elif [[ $1 == "alias" ]];then
        if [[ $# -lt 2 ]]; then
            cat << EOF
Usage: dotfiles alias [option]

Options:
    list - list all dotfiles aliases
    add - add new alias to dotfiles alias list
    remove - remove alias from dotfiles alias list
EOF
        fi
        if [[ $# -ge 2 ]];then
            if [[ $2 == "add" ]];then
                read "aliasname?Enter new alias name: "
                read "command?Enter command: "
                read -q "confirm?Do you want to add $aliasname='$command' to the dotfiles alias list?"
                if [[ ! $confirm =~ ^([yY][eE][sS]|[yY])$ ]]; then
                    echo "Aborting..."
                    return
                fi
                echo "alias $aliasname='$command'" >> ~/.scripts/source/aliases.zsh
                git -C $HOME/dotfiles pull origin master
                git -C $HOME/dotfiles add -u scripts/source/aliases.zsh
                git -C $HOME/dotfiles commit -m "Dotfiles script: Added $aliasname='$command' to the dotfiles aliases."
                git -C $HOME/dotfiles push origin master
                echo -e "\033[0;32mAdded $aliasname to dotfiles aliases!\033[0m"
            elif [[ $2 == "list" ]];then
                cat ~/.scripts/source/aliases.zsh
            elif [[ $2 == "remove" ]];then
                read "aliasname?Enter the name of the alias to remove: "
                if [ "$(uname)" '==' "Darwin" ]; then
                    MATCHED=$(gsed -n "/^alias $aliasname/p" $HOME/dotfiles/scripts/source/aliases.zsh)
                else
                    MATCHED=$(sed -n "/^alias $aliasname/p" $HOME/dotfiles/scripts/source/aliases.zsh)
                fi
                read -q "confirm?Do you want to remove $MATCHED from the dotfiles alias list?"
                if [[ ! $confirm =~ ^([yY][eE][sS]|[yY])$ ]]; then
                    echo "Aborting..."
                    return
                fi
                if [ "$(uname)" '==' "Darwin" ]; then
                    gsed -i "/^alias $aliasname/d" $HOME/dotfiles/scripts/source/aliases.zsh
                else
                    sed -i "/^alias $aliasname/d" $HOME/dotfiles/scripts/source/aliases.zsh
                fi
                echo ""
                git -C $HOME/dotfiles pull origin master
                git -C $HOME/dotfiles add -u scripts/source/aliases.zsh
                git -C $HOME/dotfiles commit -m "Dotfiles script: Removed $aliasname='$command' from the dotfiles aliases."
                git -C $HOME/dotfiles push origin master
                echo -e "\033[0;32m$MATCHED was removed from the dotfiles alias list.\033[0m"
            fi
        fi
    fi
}
