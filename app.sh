#!/bin/zsh

APP_NAME="$1"
APP_BUNDLE="${APP_NAME}.app"
CONTENTS_DIR="${APP_BUNDLE}/Contents"
FRAMEWORKS_DIR="${CONTENTS_DIR}/Frameworks"
RESOURCES_DIR="${CONTENTS_DIR}/Resources"
MACOS_DIR="${CONTENTS_DIR}/MacOS"

echo "Remove existing .app..."
rm -rf "$APP_BUNDLE"

echo "Creating directories..."
mkdir -p "${FRAMEWORKS_DIR}" "${RESOURCES_DIR}" "${MACOS_DIR}"

echo "Copying executable..."
if [ -f "${APP_NAME}" ]; then
    cp "${APP_NAME}" "${MACOS_DIR}/${APP_NAME}"
    echo "Executable copied successfully."
else
    echo "Error: Executable '${APP_NAME}' not found!"
fi

echo "Copying resources..."
if [ -d "resources" ]; then
    cp -R resources/* "${RESOURCES_DIR}/"
    echo "Resources copied successfully."
else
    echo "Warning: 'resources' directory not found!"
fi

echo "Copying and fixing dependencies..."
LIBS=(${(f)"$(otool -L "${MACOS_DIR}/${APP_NAME}" | grep -v /System | grep -v /usr/lib | grep -v @executable_path | awk '{print $1}')"})

if [ ${#LIBS[@]} -eq 0 ]; then
    echo "No external libraries found to copy."
else
    for lib in $LIBS; do
        echo "Copying $lib"
        cp "${lib}" "${FRAMEWORKS_DIR}/"
        lib_name=${lib:t}
        install_name_tool -change "${lib}" "@executable_path/../Frameworks/${lib_name}" "${MACOS_DIR}/${APP_NAME}"
    done
fi

# Update Info.plist (modify as needed)
cat > "${CONTENTS_DIR}/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.yourcompany.${APP_NAME}</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.12</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

echo "App bundle creation completed. Contents:"
ls -R "${APP_BUNDLE}"