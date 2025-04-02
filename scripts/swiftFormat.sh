if [ $(uname -m) == 'arm64' -a -e /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

PROJECT_DIR=$PWD/${1#./}
PROJECT_NAME=SudoEmail
YEAR=$(date +'%Y')
if which swiftformat >/dev/null; then
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}Tests" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}IntegrationTests" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
else
    echo "warning: SwiftFormat not installed, make sure to run 'brew install swiftformat'. download from https://github.com/nicklockwood/SwiftFormat"
fi
