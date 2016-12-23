#!/bin/bash

# { apt packages
type apt-get
if [[ $? == 0 ]] ; then
    # some of this is needed for vim completion
    # obviously apt package names change from time-to-time
    BUILD_STUFF="build-essential cmake"
    DEV_STUFF="vim tmux git"
    C_STUFF="gcc g++ cmake clang libgtest0 libgtest-dev"
    PYTHON_STUFF="python python-dev python-pip python3 python3-dev python3-pip"
    NODE_STUFF="nodejs npm"
    sudo apt-get -y install $BUILD_STUFF $DEV_STUFF $C_STUFF $PYTHON_STUFF $NODE_STUFF
fi
#}

# { bash config
if [[ -f ~/.bashrc ]] ; then
    mv ~/.bashrc ~/.bashrc.bak
fi
ln -s "$PWD"/bashrc ~/.bashrc

if [[ -f ~/.bash_aliases ]] ; then
    mv ~/.bash_aliases ~/.bash_aliases.bak
fi
ln -s "$PWD"/bash_aliases ~/.bash_aliases

    # { funky prompt
    pushd fun-scripts
    ./install.sh
    popd
    # }
# }

# { git config
if [[ -f ~/.gitconfig ]] ; then
    mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -s "$PWD"/gitconfig ~/.gitconfig

    # { gitignore_global
    echo "# snippets from github.com/github/gitignore" > ~/.gitignore_global
    git clone https://github.com/github/gitignore.git gitignore_temp
    cat gitignore_temp/C++.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Sass.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Python.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Linux.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Vim.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Archives.gitignore >> ~/.gitignore_global
    # }
# }

# { vim config
if [[ -f ~/.vimrc ]] ; then
    mv ~/.vimrc ~/.vimrc.bak
fi
ln -s "$PWD"/vimrc ~/.vimrc

if [[ -f ~/.vim/colors/solarized.vim ]] ; then
    mv ~/.vim/colors/solarized.vim ~/.vim/colors/solarized.vim/bak
fi
ln -s "$PWD"/vim/solarized.vim ~/.vim/colors/solarized

    # { Vundle set-up
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
        # { YouCompleteMe set-up
        pushd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-complete --tern-completer
        popd
        # }
    # }
# }
