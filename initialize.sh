#!/bin/sh
#         _ _    _          ___  ___  ___   ___   ___ _____ ___ ___ _    ___ ___
#    __ _| | |__| |___ ___ ( _ )( _ )( _ ) |   \ / _ \_   _| __|_ _| |  | __/ __|
#   / _` | | '_ \ / -_) _ \/ _ \/ _ \/ _ \ | |) | (_) || | | _| | || |__| _|\__ \
#   \__,_|_|_.__/_\___\___/\___/\___/\___/ |___/ \___/ |_| |_| |___|____|___|___/
#

cat << END

*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+
*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+
 ____   ___ _____ _____ ___ _     _____ ____    ____  _____ _____ _   _ ____    ____ _____  _    ____ _____ _
|  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___|  / ___|| ____|_   _| | | |  _ \  / ___|_   _|/ \  |  _ \_   _| |
| | | | | | || | | |_   | || |   |  _| \___ \  \___ \|  _|   | | | | | | |_) | \___ \ | | / _ \ | |_) || | | |
| |_| | |_| || | |  _|  | || |___| |___ ___) |  ___) | |___  | | | |_| |  __/   ___) || |/ ___ \|  _ < | | |_|
|____/ \___/ |_| |_|   |___|_____|_____|____/  |____/|_____| |_|  \___/|_|     |____/ |_/_/   \_\_| \_\|_| (_)
*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+
*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+*+:*+

END

set -exu

bin_dir=$HOME"/bin/"
src_dir=$HOME"/src/"
repo_dir=$HOME"/repo/"
dotfiles_repository="https://github.com/albleo888/dotfiles"
config_dir=$HOME"/.config"

mkdir -p $bin_dir 2>/dev/null
mkdir -p $src_dir 2>/dev/null
mkdir -p $repo_dir 2>/dev/null
mkdir -p $config_dir 2>/dev/null

if [ ! -f $HOME"/bin/peco" ]; then
    curl -sL -o $src_dir"peco_linux_amd64.tar.gz" https://github.com/peco/peco/releases/download/v0.5.0/peco_linux_amd64.tar.gz
    tar zxvf $src_dir"peco_linux_amd64.tar.gz" -C $src_dir
    mv $src_dir"peco_linux_amd64/peco" $bin_dir
fi

if type git > /dev/null 2>&1; then
    if [ ! -d $repo_dir"dotfiles" ]; then
        git clone $dotfiles_repository $repo_dir"dotfiles"
    fi

    echo "start setup..."
    for f in $repo_dir"dotfiles/".??*; do
        [ -d "$f" ] && continue
        [ "$f" =~ ".git" ] && continue
        [ "$f" =~ ".gitconfig.local.template" ] && continue
        [ "$f" =~ ".require_oh-my-zsh" ] && continue
        [ "$f" =~ ".gitmodules" ] && continue
        [ "$f" =~ ".emacs.d" ] && continue
        [ "$f" =~ ".emacs.d.elget" ] && continue
        [ "$f" =~ ".emacs.elgetmin" ] && continue
        [ "$f" =~ ".vim" ] && continue

        ln -snfv "$f" $HOME"/"
    done
fi

ln -snfv $repo_dir"dotfiles/dein.toml" $HOME"/.config/dein.toml"
ln -snfv $repo_dir"dotfiles/dein_lazy.toml" $HOME"/.config/dein_lazy.toml"
ln -snfv $repo_dir"dotfiles/.emacs.d.elget" $HOME"/.emacs.d"

if [ ! -d $HOME"/.anyenv" ]; then
    git clone https://github.com/riywo/anyenv $HOME/.anyenv
fi

if [ ! -d $HOME"/.zplug" ]; then
    mkdir -p $HOME"/.zplug" 2>/dev/null
    curl -sL zplug.sh/installer | zsh
    if [ -f $HOME"/.zplug/init.zsh" ]; then
        chmod u+x $HOME"/.zplug/init.zsh"
        zsh $HOME"/.zplug/init.zsh"
        if type zplug > /dev/null 2>&1; then
                zplug install
        fi
    fi
fi

cat << END

******************************************************************************************************************************
******************************************************************************************************************************
 ____   ___ _____ _____ ___ _     _____ ____    ____  _____ _____ _   _ ____    _____ ___ _   _ ___ ____  _   _ _____ ____  _
|  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___|  / ___|| ____|_   _| | | |  _ \  |  ___|_ _| \ | |_ _/ ___|| | | | ____|  _ \| |
| | | | | | || | | |_   | || |   |  _| \___ \  \___ \|  _|   | | | | | | |_) | | |_   | ||  \| || |\___ \| |_| |  _| | | | | |
| |_| | |_| || | |  _|  | || |___| |___ ___) |  ___) | |___  | | | |_| |  __/  |  _|  | || |\  || | ___) |  _  | |___| |_| |_|
|____/ \___/ |_| |_|   |___|_____|_____|____/  |____/|_____| |_|  \___/|_|     |_|   |___|_| \_|___|____/|_| |_|_____|____/(_)
******************************************************************************************************************************
******************************************************************************************************************************

END

exec $SHELL -l
