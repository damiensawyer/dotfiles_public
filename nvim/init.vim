" Sharing config between Neovim and Vim
" Got this from https://vi.stackexchange.com/a/15548
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc
