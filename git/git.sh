REL=`dirname $0`

cp "$REL/gitconfig" ~/.gitconfig
cp "$REL/gitignore" ~/.gitignore

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
