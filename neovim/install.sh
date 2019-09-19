check_command_exists curl
check_command_exists nvim

# install vim-plug and the plugins
echo "- Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null

echo "- Installing neovim plugins"
nvim --headless +PlugUpdate +q +q &> /dev/null
