#!/bin/bash

# Uncomment for debugging
# set -o pipefail -ex


function __install_fonts {
    tmp_dir=$(mktemp -d -t fonts-XXXXXXXXXX)
    fonts_repo="https://github.com/ryanoasis/nerd-fonts"
    fonts_repo_dir="${tmp_dir}/nerd_fonts"
    echo "Installing fonts from ${fonts_repo} to ${fonts_repo_dir}"
    cd "${tmp_dir}" || exit 1
    git clone --depth 1 "${fonts_repo}" "${fonts_repo_dir}"
    cd "${fonts_repo_dir}" || exit 1
    if [[ ! -e ./install.sh ]]; then
        ./install.sh
    else
        echo "Can't locate installation script in ${fonts_repo_dir}"
        exit 1
    fi
    cd ..
    rm -rf "${tmp_dir}"
    echo "Fonts successfully installed!"
}


function __install_vs_code {
    dots_root=$1
    vs_code_bin=$(command -v code)
    if [[ -z "${vs_code_bin}" ]]; then
        # Installing VSCode. Requires `sudo`
        # Code is taken from https://code.visualstudio.com/docs/setup/linux
        echo "Installing VS Code"
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "${dots_root}/packages.microsoft.gpg"
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install code

        vs_code_extensions_list_file="${dots_root}/vscode/extensions.txt"
        echo "Installing VS code extenstions:"
        cat "${vs_code_extensions_list_file}"
        xargs -n 1 code --install-extension --force < "${vs_code_extensions_list_file}"

        vs_code_settings="$HOME/.config/Code/User/settings.json"
        if [[ ! -L "${vs_code_settings}" ]]; then
            echo "Setting up ${vs_code_settings}"
            ln -s "${dots_root}/vscode/settings.json" "${vs_code_settings}"
        else
            echo "Link ${vs_code_settings} already exists!"
        fi

        rm "${dots_root}/packages.microsoft.gpg"
        echo "VS Code successfully installed"
    else
        echo "VS Code is already installed"
    fi
}


function __setup_bash_files {
    dots_root=$1
    bashrc_file="$HOME/.bashrc"
    if [[ ! -L "${bashrc_file}" ]]; then
        echo "Setting up ${bashrc_file}"
        ln -s "${dots_root}/.bashrc" "${bashrc_file}"
    else
        echo "Link ${bashrc_file} already exists!"
    fi

    bash_profile_file="$HOME/.bash_profile"
    if [[ ! -L "${bash_profile_file}" ]]; then
        echo "Setting up ${bash_profile_file}"
        ln -s "${dots_root}/.bash_profile" "${bash_profile_file}"
    else
        echo "Link ${bash_profile_file} already exists!"
    fi
}


function __install_vim_plugins {
    echo "Installing Vim plugins"
    vim -c 'PluginInstall' -c 'qall'
    echo "Vim plugins successfully installed"
}


function __install_you_complete_me_plugin {
    dots_root=$1
    echo "Installing YouCompleteme vim plugin"
    cd "${dots_root}/.vim/bundle/YouCompleteMe" || exit 1
    if [[ ! -e ./install.py ]]; then
        ./install.py
    else
        echo "Can't locate installation script"
        exit 1
    fi

    cd - || exit 1
    echo "YouCompleteme successfully installed"
}


function __setup_vim {
    dots_root=$1
    vim_bin=$(command -v vim)
    if [[ -z "${vim_bin}" ]]; then
        echo "Installing Vim"
        sudo apt-get install -y vim build-essential cmake python-dev
        vimrc_file="$HOME/.vimrc"
        if [[ ! -L "${vimrc_file}" ]]; then
            echo "Setting up ${vimrc_file}"
            ln -s "${dots_root}/.vimrc" "${vimrc_file}"
        else
            echo "Link ${vimrc_file} already exists!"
        fi
        vim_dir="$HOME/.vim"
        if [[ ! -L "${vim_dir}" ]]; then
            echo "Setting up ${vim_dir}"
            ln -s "${dots_root}/.vim" "${vim_dir}"
        else
            echo "Directory ${vim_dir} already exists"
        fi
        __install_vim_plugins
        __install_you_complete_me_plugin "${dots_root}"
        echo "Vim successfully installed"
    else
        echo "Vim already installed!"
    fi
}


function __setup_git_config {
    dots_root=$1
    gitconfig_file="$HOME/.gitconfig"
    if [[ ! -L "${gitconfig_file}" ]]; then
        echo "Setting up ${gitconfig_file}"
        ln -s "${dots_root}/.gitconfig" "${gitconfig_file}"
    else
        echo "Link ${gitconfig_file} already exists!"
    fi
}


function __setup_tmux_config {
    dots_root=$1
    tmuxconfig_file="$HOME/.tmux.conf"
    if [[ ! -L "${tmuxconfig_file}" ]]; then
        echo "Setting up ${tmuxconfig_file}"
        ln -s "${dots_root}/.tmux.conf" "${tmuxconfig_file}"
    else
        echo "Link ${tmuxconfig_file} already exists!"
    fi
}


function __setup_jupyter_config {
    dots_root=$1
    jupyter_config_file="$HOME/.jupyter"
    if [[ ! -L "${jupyter_config_file}" ]]; then
        echo "Setting up ${jupyter_config_file}"
        ln -s "${dots_root}/.jupyter" "${jupyter_config_file}"
    else
        echo "Link ${jupyter_config_file} already exists"
    fi
}


function __setup_docker_files {
    dots_root=$1
    docker_bash_history="$HOME/.docker_bash_history"
    if [[ ! -L "${docker_bash_history}" ]]; then
        echo "Setting up ${docker_bash_history}"
        touch "${dots_root}/.docker/.bash_history"
        ln -s "${dots_root}/.docker/.bash_history" "${docker_bash_history}"
    else
        echo "Link ${docker_bash_history} already exists!"
    fi

    docker_d="$HOME/d"
    if [[ ! -L "${docker_d}" ]]; then
        echo "Setting up ${docker_d}"
        ln -s "${dots_root}/.docker/d" "${docker_d}"
    else
        echo "Link ${docker_d} already exists!"
    fi
}


function __main {
    dots_root="$(cd "$(dirname "$0")" || exit 1; pwd)"
    __install_fonts
    __install_vs_code "${dots_root}"
    __setup_bash_files "${dots_root}"
    __setup_vim "${dots_root}"
    __setup_git_config "${dots_root}"
    __setup_tmux_config "${dots_root}"
    __setup_jupyter_config "${dots_root}"
    __setup_docker_files "${dots_root}"
}

__main
