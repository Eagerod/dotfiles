REL=`dirname $0`

cp "$REL/gitconfig" ~/.gitconfig
cp "$REL/gitignore" ~/.gitignore

# Intentionally update, in case git was updated since the last time this was run.
git_version="v$(git version | awk '{print $NF }')"

# For some reason, curl in cygwin on windows can have issues writing using -o,
#   so instead of having curl write the file, redirect it to its end path.
if uname | grep -iq cygwin; then
    curl https://raw.githubusercontent.com/git/git/$git_version/contrib/completion/git-completion.bash > ~/.git-completion.bash
    curl https://raw.githubusercontent.com/git/git/$git_version/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
else
    curl https://raw.githubusercontent.com/git/git/$git_version/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    curl https://raw.githubusercontent.com/git/git/$git_version/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
fi
