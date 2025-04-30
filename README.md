# Babble

# LAST TESTED ON VERSIONS

Flutter:
3.24.5

Dart:
3.5.4

Java:
java 17.0.12 2024-07-16 LTS
Java(TM) SE Runtime Environment (build 17.0.12+8-LTS-286)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.12+8-LTS-286, mixed mode, sharing)

Android Studio:
Android Studio Meerkat | 2024.3.1 Patch 1
Build #AI-243.24978.46.2431.13208083, built on March 13, 2025
Runtime version: 17.0.12+8-LTS-286 amd64
Non-Bundled Plugins:
Dart (243.23654.44)
io.flutter (83.0.4)


# JDK ERROR FIX

### 1. check java version 
flutter doctor --verbose

it should have java 17.0.12 2024-07-16 LTS for Android toolchain

[√] Android toolchain - develop for Android devices (Android SDK version 35.0.1)
• Android SDK at C:\Users\sanch\AppData\Local\Android\sdk
• Platform android-35, build-tools 35.0.1
• Java binary at: C:\Program Files\Android\Android Studio\jbr\bin\java
• Java version Java(TM) SE Runtime Environment (build 17.0.12+8-LTS-286)
• All Android licenses accepted.


#### if java version is greater 

flutter config --jdk-dir "C:\Program Files\Java\jdk-17"
 
