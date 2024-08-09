July 2022
I had to HARD link ~/.vim/vimrc to '/cygdrive/c/Users/Damien.Sawyer/AppData/Local/nvim/init.vim'
Softlink didn't work, nor did the name vimrc


Sep 2022
I actually created this folder and put in the file which POINTs to the ~/.vim config... 
c:\Users\damien\AppData\Local\nvim\init.vim 

The contents of that file is:

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc

## Edit August 2024
- in the world of chatGPT, dropping VIM completely for NVIM
- therefore no vimrc
- only init.lua


Installed packer with 
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

in Neovim ran
:PackerSync


## Cygwin and lazyvim
See https://dev.to/kaiwalter/share-neovim-configuration-between-linux-and-windows-4gh8#:~:text=On%20Windows%20NeoVim%20gets%20its,%5CLocal%5Cnvim%2Ddata%20.
clone lazyvim into %userprofile%\AppData\Local\nvim
