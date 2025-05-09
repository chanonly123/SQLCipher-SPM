# put this file inside the root directory of the project

# update the framework name
frameworkName="SQLCipher"

pod install
cd Pods

echo "⬛️ cleaning"
xcodebuild clean
rm -rf output
rm -rf build

# framework version
echo "⬛️ build for iphonesimulator"
xcodebuild \
-verbose \
-scheme $frameworkName \
-configuration Release \
-derivedDataPath output \
-sdk iphonesimulator build \
&&

echo "⬛️ build for iphoneos"
xcodebuild \
-verbose \
-scheme $frameworkName \
-configuration Release \
-derivedDataPath output \
-sdk iphoneos build \
&&

iphoneosDSYM=`readlink -f "../build/Release-iphoneos/$frameworkName/$frameworkName.framework.dSYM"`
iphonesimulatorDSYM=`readlink -f "../build/Release-iphonesimulator/$frameworkName/$frameworkName.framework.dSYM"`

echo ${iphoneosDSYM}
echo ${iphonesimulatorDSYM}

echo "⬛️ build xcframework"
xcodebuild -create-xcframework \
-framework "../build/Release-iphoneos/$frameworkName/$frameworkName.framework" \
-debug-symbols ${iphoneosDSYM} \
-framework "../build/Release-iphonesimulator/$frameworkName/$frameworkName.framework" \
-debug-symbols ${iphonesimulatorDSYM} \
-output "build/$frameworkName.xcframework" \
&&

echo "✅✅✅✅✅✅ Success ✅✅✅✅✅✅"

# echo "⬛️ build documentation"
# xcodebuild docbuild \
# -scheme $frameworkName \
# -derivedDataPath output \
# -destination 'platform=iOS Simulator,name=iPhone 13' \
# &&

# docPath=`find output -type d -name "*.doccarchive"`

# echo "⬛️ building static documentation website"
# $(xcrun --find docc) process-archive \
# transform-for-static-hosting $docPath \
# --output-path "build/doc" \
# --hosting-base-path "/" \
# &&

# # output file location
# echo "⬛️ open output folder"
# open "build/"

# # generated documents directory, localy viewable, requires `python3`
# cd "build/doc"
# open "http://localhost:3000/documentation/$frameworkName/"
# python3 -m http.server 3000
