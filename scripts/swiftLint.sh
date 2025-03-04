if [ "$(uname -m)" == 'arm64' -a  -e /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if which swiftlint >/dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, make sure to run 'brew install swiftlint'. download from https://github.com/realm/SwiftLint"
fi