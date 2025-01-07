#!/bin/bash

# Directory containing versioned Snapcraft files
SNAPCRAFT_FILES_DIR="releases"

# Function to compare semantic versions and find the highest
get_highest_version() {
    # Find directories matching the pattern "vX.X.X" and extract valid semantic versions
    versions=$(ls -d ${SNAPCRAFT_FILES_DIR}/v* 2>/dev/null | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+' | sort -V)

    # If no valid versions are found, exit with an error
    if [[ -z "$versions" ]]; then
        echo "Error: No valid semantic version directories found in '$SNAPCRAFT_FILES_DIR'."
        exit 1
    fi

    # Return the highest version
    echo "$versions" | tail -n 1
}

# Get the highest version
FOLDER_NAME=$(get_highest_version)
if [[ $? -ne 0 ]]; then
    exit 1
fi

# Remove the 'v' prefix to get the version number
VERSION="${FOLDER_NAME#v}"
echo "Detected highest version: $VERSION"

# Handle the `--just-prepare` argument
if [[ "$1" == "--just-prepare" ]]; then
    echo "Preparing Snapcraft files for version $VERSION..."
    mkdir -p snap
    cp -f "$SNAPCRAFT_FILES_DIR/$FOLDER_NAME/snapcraft.yaml" snap/snapcraft.yaml
    echo "Snapcraft.yaml prepared in the 'snap' directory."
    exit 0
fi

# Build the Snap package for the highest version
echo "Building Snap package for version $VERSION..."
if pushd "$SNAPCRAFT_FILES_DIR/v$VERSION" > /dev/null; then
    SNAPCRAFT_BUILD_ENVIRONMENT=multipass snapcraft  # Build the package using Multipass
    if [[ $? -eq 0 ]]; then
        echo "Build successful. Moving Snap package to the root directory..."
        mv -f *.snap ../../  # Move the built snap file to the root directory
    else
        echo "Error: Snap build failed."
        exit 1
    fi
    popd > /dev/null || exit
else
    echo "Error: Failed to access directory '$SNAPCRAFT_FILES_DIR/v$VERSION'."
    exit 1
fi

echo "Snap package build process completed."
