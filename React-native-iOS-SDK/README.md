## Overview
This is a basic code example for React Native iOS App Project using Split Javascript SDK (Latest version)

## Environment:

node >=10.15.3,  

npm >=6.4.1

react-native-cli: >=2.0.1, 

react-native: >=0.60.3

Xcode >10.3

 
## Getting started:

1. Update your relevant Split API Key (Use "browser" type SDK API KEY), user Key, Split name in:

```
ReactSDK/ReactSDK.js
```

2. Using XCode, open the ReactSDK/ios/ReactSDK.xcworkspace 

3. Build and run the app

Notes:

Even though the Split SDK is installed using NodeJS package, it runs in browser mode on the App, that is why we have to use browser API Key
To implement Split SDK into an existing React Native project, install the following packages:

```
npm install --save @splitsoftware/splitio
npm install --save events
npm install --save util
```


Implement the SDK code as used in  ReactSDK.js
