if [ $(uname -m) == 'arm64' -a -e /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

UPDATE_YEAR=false
UPDATE_COPYRIGHT=true

# Check for options
for arg in "$@"; do
  echo $arg
    case $arg in
        --migrate_copyright_year)
            UPDATE_YEAR=true
            shift
            ;;
        --no_copyright_update)
            UPDATE_COPYRIGHT=false
            shift
            ;;
    esac
done

PROJECT_DIR=$PWD/${1#./}
PROJECT_NAME=SudoEmail
YEAR=$(date +'%Y')
if which swiftformat >/dev/null; then
    # Cancel the header update if --no_copyright_update option is provided
     if [ "$UPDATE_COPYRIGHT" = "false" ]; then
        echo "Skipping copyright header update as per --no_copyright_update option."
        swiftformat "${PROJECT_DIR}/${PROJECT_NAME}" --config "${PROJECT_DIR}/.swiftformat"
        swiftformat "${PROJECT_DIR}/${PROJECT_NAME}Tests" --config "${PROJECT_DIR}/.swiftformat"
        swiftformat "${PROJECT_DIR}/${PROJECT_NAME}IntegrationTests" --config "${PROJECT_DIR}/.swiftformat"
        exit 0
     fi
    # Only update copyright years if --migrate_copyright_year option is provided
    if [ "$UPDATE_YEAR" = "true" ]; then
        PREV_YEAR=$((YEAR - 1))
        echo "Updating copyright year from ${PREV_YEAR} to ${YEAR}..."
        find "${PROJECT_DIR}/${PROJECT_NAME}" -name "*.swift" -exec sed -i '' 's/Copyright © '${PREV_YEAR}'/Copyright © '${YEAR}'/g' {} \;
        find "${PROJECT_DIR}/${PROJECT_NAME}Tests" -name "*.swift" -exec sed -i '' 's/Copyright © '${PREV_YEAR}'/Copyright © '${YEAR}'/g' {} \;
        find "${PROJECT_DIR}/${PROJECT_NAME}IntegrationTests" -name "*.swift" -exec sed -i '' 's/Copyright © '${PREV_YEAR}'/Copyright © '${YEAR}'/g' {} \;
    fi
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}Tests" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
    swiftformat "${PROJECT_DIR}/${PROJECT_NAME}IntegrationTests" --config "${PROJECT_DIR}/.swiftformat" --header "\nCopyright © ${YEAR} Anonyome Labs, Inc. All rights reserved.\n\nSPDX-License-Identifier: Apache-2.0\n"
else
    echo "warning: SwiftFormat not installed, make sure to run 'brew install swiftformat'. download from https://github.com/nicklockwood/SwiftFormat"
fi
