# Dotilfes managed with [GNU Stow](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

The procedure is simple. 

- Inside ${HOME}/.dotfiles create a folder for each config you wish to manage.
- Move files into the folders maintaining the directory structure of the home folder. 
- So, if a file normally resides at the top level of your home directory, it would go into the top level of the program’s subdirectory. If a file normally goes in the default ${XDG_CONFIG_HOME}/${PKGNAME} location (${HOME}/.config/${PKGNAME}), then it would instead go in ${HOME}/dotfiles/${PKGNAME}/.config/${PKGNAME} and so on
- From the .dotfiles folder, run stow $PKGNAME which will generate symlinks.




