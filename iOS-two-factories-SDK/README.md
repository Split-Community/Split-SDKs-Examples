## Overview
This is a basic code to use Split SDK 2.3.0

## Environment:

Xcode  10.2.1 Project 

Swift 4.0 language or later

Cocopod to add the SplitSDK library.


## Getting started:

1. Clone this repo to your local environment

2. The iOS Split SDK uses the api key as the folder name in Application storage cache, to make sure the cache is completely separated for each Factory object, use different API Key per each. Split API Keys page allow creating multiple API Keys for the same environment.

3. Update your relevant Split API Keys and user keys in:

```
SplitSDK/SplitSDK/AppDelegate.swift
```

4. Update Splits names when calling 
getSplitTreatment in:

```
SplitSDK/SplitSDK/ViewController.swift
```

5. There are two Split SDK Wrapper libraries, used for each factory instance:

```
SplitSDK/SplitSDK/SplitWrapper.swift

SplitSDK/SplitSDK/SplitWrapper2.swift
``


6.The app will initialize Split Factory when the app starts, a treatment is sent when the button is clicked.


 https://drive.google.com/a/split.io/file/d/1RVB1_35Qk9gxi7CPnboV-fcD5Tkrjs9e/view?usp=sharing