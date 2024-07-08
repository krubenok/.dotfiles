if [[ "$OSTYPE" == "darwin"* || "$OSTYPE" == "linux-gnu"* ]]; then
    brew() {
        if [ "$1" = "install" ]; then
            /opt/homebrew/bin/brew install "${@:2}"
            shift
            /opt/homebrew/bin/brew add "$1"
        elif [ "$1" = "uninstall" ]; then
            /opt/homebrew/bin/brew uninstall "${@:2}"
            shift
            /opt/homebrew/bin/brew drop "$1"
        else
            /opt/homebrew/bin/brew "$@"
        fi
    }
fi
