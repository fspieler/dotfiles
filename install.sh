#!/bin/bash

# { link helper function
INITIAL_PWD="$PWD"
function create_link() {
    local REL_TARGET="$1"
    local LINK="$2"
    if [[ -f "$LINK" ]] ; then
        mv "$LINK" "$LINK".bak
    fi
    if [[ -h "$LINK" ]] ; then
        unlink "$LINK"
    fi
    mkdir -p $(dirname "$LINK")
    ln -s "$INITIAL_PWD"/"$REL_TARGET" "$LINK"
}
# }

# { apt packages
type apt-get
if [[ $? == 0 ]] ; then
    # some of this is needed for vim completion
    # obviously apt package names change from time-to-time
    TRASH="trash-cli"
    BUILD_STUFF="build-essential cmake"
    DEV_STUFF="vim tmux git"
    C_STUFF="gcc g++ cmake clang libgtest-dev"
    PYTHON_STUFF="python python-dev python-pip python3 python3-dev python3-pip"
    NODE_STUFF="nodejs npm"
    sudo apt-get -y install $TRASH $BUILD_STUFF $DEV_STUFF $C_STUFF $PYTHON_STUFF $NODE_STUFF
fi
# }

# { build gtest static lib
pushd /usr/src/gtest
sudo cmake .
sudo make
sudo mv libg* /usr/lib/
popd
# }

# { bash config
create_link bashrc ~/.bashrc
create_link bash_aliases ~/.bash_aliases

    # { funky prompt
    pushd "$PWD"/fun-scripts
    ./install.sh
    popd
    # }
# }

# { tmux config
create_link tmux.conf ~/.tmux.conf
# }

# { git config
create_link gitconfig ~/.gitconfig

    # { gitignore_global
    echo "# snippets from github.com/github/gitignore" > ~/.gitignore_global
    git clone https://github.com/github/gitignore.git gitignore_temp
    cat gitignore_temp/C++.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Sass.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Python.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Linux.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Vim.gitignore >> ~/.gitignore_global
    cat gitignore_temp/Global/Archives.gitignore >> ~/.gitignore_global
    rm -rf gitignore_temp
    # }
# }

# { vim config
create_link vim/vimrc ~/.virmc
create_link vim/solarized.vim ~/.vim/colors/solarized.vim

    # { Vundle set-up
    mkdir -p ~/.vim/undodir
    mkdir -p ~/.vim/bundle
    if [[ -d ~/.vim/bundle/Vundle.vim ]] ; then
        rm -rf ~/.vim/bundle/Vundle.vim
    fi
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
        # { YouCompleteMe set-up
        pushd ~/.vim/bundle/YouCompleteMe
        python3 install.py --clang-complete
        popd
        # }
    # }
# }
