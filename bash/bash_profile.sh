#!/usr/bin/env bash
#
# Since I don't want to trample existing profiles that may be set up on a 
# machine, set up the lines I want in there, and only add them if they aren't
# already present.

desired_lines=(
    "alias sublime='subl'"
    "alias isodate='date -u +%Y-%m-%dT%H:%M:%SZ'"
    "alias me='cd ~/Documents/PersonalProjects'"
    "source ~/.git-completion.bash"
)

if [[ "$(uname)" == "Linux" ]];
then
    desired_lines+=(
        "alias pbcopy='xclip -selection clipboard'"
        "alias pbpaste='xclip -selection clipboard -o'"
    )
elif [[ "$(uname)" == "Darwin" ]];
then
    desired_lines+=(
        "alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'"
        "alias hidehidden='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'"
    )
fi

touch ~/.bash_profile

for ((i = 0; i < ${#desired_lines[@]}; ++i))
do
    line=${desired_lines[$i]}
    if ! $(grep -q "$line" ~/.bash_profile)
    then
        echo "$line" >> ~/.bash_profile
    fi
done
