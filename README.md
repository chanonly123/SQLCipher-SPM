# SQLCipher-SPM

A Swift Package Manager-compatible distribution of the SQLCipher library via a precompiled XCFramework.
This package allows Swift projects to use SQLCipher without relying on CocoaPods.

Official repo: https://github.com/sqlcipher/sqlcipher

## 📦 Why This Exists

SQLCipher is a widely used extension to SQLite that provides transparent 256-bit AES encryption.
However, SQLCipher does not officially support Swift Package Manager (SPM) — it only offers integration via CocoaPods or manual compilation.

To simplify integration into modern Swift projects, this repository provides a precompiled XCFramework version of SQLCipher that can be consumed via SPM.

## 🚀 Usage

Step 1: Add the Package
In Xcode:

Go to File > Add Packages
Enter the repository URL:

```
https://github.com/chanonly123/SQLCipher-SPM.git
```

Choose the version and add the package to your project.

## 📁 Contents

This repository includes:

A precompiled SQLCipher.xcframework binary
A Package.swift manifest to expose the framework via SwiftPM

## ✅ Compatibility

| Platform | Supported     |
| -------- | ------------- |
| iOS      | ✅             |
| macOS    | ✅             |
| tvOS     | ✅             |
| watchOS  | ✅             |
| visionOS | ✅             |

## 🛠 Building the XCFramework (Optional)

Execute this script
```
sh build_xcframework.sh
```

## 🙏 Credits

SQLCipher by Zetetic LLC
This package is independently maintained to support Swift Package Manager users.