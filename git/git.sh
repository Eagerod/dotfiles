REL=`dirname $0`

cp "$REL/gitconfig" ~/.gitconfig
cp "$REL/gitignore" ~/.gitignore

# For some reason, curl in cygwin on windows can have issues writing using -o,
#   so instead of having curl write the file, redirect it to its end path.
if uname | grep -iq cygwin; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
