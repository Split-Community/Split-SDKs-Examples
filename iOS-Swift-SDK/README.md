## Overview

This is a basic code example to use Split SDK 2.2.0

## Environment:

Xcode  10.2.1 Project 

Swift 4.0 language

Cocopod to add the SplitSDK library.

## Getting Started:

1. Clone this repo to your local environment.


2. Update your relevant Split API Key and user key in:

```
SplitSDK/SplitSDK/AppDelegate.swift
```

3. Update Split name when calling getSplitTreatment in:

```
SplitSDK/SplitSDK/ViewController.swift
```

The app will initialize Split Factory when the app starts, a treatment is sent when the button is clicked.


