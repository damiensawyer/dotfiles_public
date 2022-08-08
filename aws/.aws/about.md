GNU STOW didn't seem to work with my AWS credentials. I think that perhaps the python script didn't like the symlinks. 

backup.sh : Copy the credentials from ~/.aws to .dotfiles
restore.sh : restore the other way 

The credentials file is in .gitignore so will not push
run the encrypt script when you make changes to the credentials, this will encrypt the file ready to push.  
run the decrypt script on pull to decrypt, then run restore.sh to copy into your home folder
