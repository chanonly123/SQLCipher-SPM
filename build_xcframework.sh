#!/bin/bash

pod install &&

frameworkName="SQLCipher"
buildConfig="Release"
buildDir="output"
xcframeworkOutputDir="build"

rm -rf "$buildDir" "$xcframeworkOutputDir"

frameworkArgs=""

cd Pods

# ✅ Hardcoded list of all Apple platform SDKs
sdk_list=(
    "iphoneos"
    "iphonesimulator"
    "appletvos"
    "appletvsimulator"
    "watchos"
    "watchsimulator"
    "xros"
    "xrsimulator"
)

# Build the framework for each SDK
for sdk in "${sdk_list[@]}"; do
    echo "⬛️ Building for $sdk"
    
    xcodebuild \
        -scheme "$frameworkName" \
        -configuration "$buildConfig" \
        -sdk "$sdk" \
        -derivedDataPath "$buildDir/$sdk" \
        build > /dev/null

    # Skip if build failed
    if [ $? -ne 0 ]; then
        echo "❌ Build failed for $sdk. Skipping."
        continue
    fi

    # `readlink -f "../build/Release-iphoneos/$frameworkName/$frameworkName.framework.dSYM"`

    # Locate framework and dSYM
    sdkOutputPath="../$xcframeworkOutputDir/$buildConfig-$sdk/$frameworkName"
    frameworkPath=`readlink -f "$sdkOutputPath/$frameworkName.framework"`
    dsymPath=`readlink -f "$sdkOutputPath/$frameworkName.framework.dSYM"`

    if [ -d "$frameworkPath" ]; then
        echo "✅ Found framework at $frameworkPath"
        frameworkArgs="$frameworkArgs -framework '$frameworkPath'"
        
        if [ -d "$dsymPath" ]; then
            echo "✅ Found dSYM at $dsymPath"
            frameworkArgs="$frameworkArgs -debug-symbols '$dsymPath'"
        fi
    else
        echo "⚠️ Framework not found for $sdk. Skipping: $frameworkPath"
    fi
done

# Create XCFramework
outPath="../$frameworkName.xcframework"
rm -rf "$outPath"
eval "xcodebuild -create-xcframework $frameworkArgs -output '$outPath'"

# Check if the command succeeded
if [ $? -ne 0 ]; then
    echo "❌❌❌❌❌❌ xcodebuild failed ❌❌❌❌❌❌"
else
    echo "✅✅✅✅✅✅ Success ✅✅✅✅✅✅"
fi
