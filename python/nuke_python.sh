if ! type pip > /dev/null; then
    if ! type brew > /dev/null; then
        echo "Run bootstrap.sh before attempting to repair Python"
    fi
    brew install python
fi

if ! type pip > /dev/null; then
    echo "Open a new terminal window and rerun"
    exit -1
fi

sudo pip freeze | xargs sudo pip uninstall -y
sudo -k
