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


