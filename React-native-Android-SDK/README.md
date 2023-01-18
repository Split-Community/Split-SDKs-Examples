## Overview
This is a basic code example for React Native Android App Project using Split Javascript SDK 

Environment:

node >=10.15.3

npm >=6.4.1

react-native-cli: >=2.0.1

react-native: >=0.60.3

JRE 1.8.0

Android SDK 28 (28.0.3)


## Getting started:

1. Clone this repo to your local environment

2. Update your relevant Split API Key (Use "browser" type SDK API KEY), user Key, Split name in:

```
ReactSDK/ReactSDK.js
```

3. Make sure to have the following environment variables defined:

```
ANDROID_HOME, JAVA_HOME
```

4. Run Android Simulator from Android Studio app->Tools->AVD Manager 

5. Run the command below in the project root folder to build the app:

```
react-native run-android
```

6. If react service did not start, start it with the command below:

```
react-native start
```

Notes:

Even though the Split SDK is installed using NodeJS package, it runs in browser mode on the App, that is why we have to use browser API Key
To implement Split SDK into an existing React Native project, install the following packages:
npm install --save @splitsoftware/splitio
npm install --save events
npm install --save util
Implement the SDK code as used in  ReactSDK.js
