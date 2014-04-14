which git || { echo 'git not detected. install git.' ; exit 1; }
echo 'git detected.'

# If the files that we would replace are symlinks, unlink them.
echo 'uninstalling if installed'
[ -h ~/.bash_profile ] && rm ~/.bash_profile
[ -h ~/.bin ] && rm ~/.bin
[ -h ~/.vim ] && rm ~/.vim
[ -h ~/.vimrc ] && rm ~/.vimrc

# Link the new files into place.
echo 'linking'
ln -s `pwd`/.bash_profile ~/
ln -s `pwd`/.bin ~/
ln -s `pwd`/.vim ~/
ln -s `pwd`/.vimrc ~/

# Populating submodules
echo 'loading submodules'
git submodule init
git submodule update
