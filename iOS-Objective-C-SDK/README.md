## Overview
This is a basic example to implment Split iOS SDK Swift library in Objective-C project

## Environment

Xcode 11.3.1 or later
Cocopod to add the Split SDK library

## Getting started

### How to Add SDK to Objective-C project:

- Clone this repo to your local environment 

- If your project does not have Pods, run the command below in the project root to initialize Pods:

``` swift
pod init
```

- Open Podfile in a text editor and add Split library as below:

``` objective-c
target 'Objective-SDK' do
 use_frameworks!
 pod 'Split', '~> 2.5.2'
end
```


Run the command below from command line:

``` objective-c 
pod update
```



- Once the pod is installed, open XCode, navigate to your project folder and open the <Project Name>.xcworkspace file, note that only the Workspace will allow using the Pod libraries.

- You can now use Split SDK in your code, as an example, we implemented it in ViewController.m file, at the top of the file add the import line:

``` objective-c
@import Split;
```

- The code below initializes the factory and client objects, setup a listener to SDK_READY event to calculate treatment and print it in the console once the event fires, the code is placed inside `viewDidLoad` method. 

``` objective-c

  NSString *splitName = @"sample_feature";
    NSString *matchingKey = @"bob";
    NSString *bucketingKey =  nil;
    SplitClientConfig *config = [[SplitClientConfig alloc] init];
    config.impressionRefreshRate = 15;
    config.isDebugModeEnabled = false;
    config.isVerboseModeEnabled = false;
    config.sdkReadyTimeOut = 15000;
    Key *key = [[Key alloc] initWithMatchingKey:matchingKey bucketingKey:bucketingKey];

    id<SplitFactoryBuilder> builder = [[DefaultSplitFactoryBuilder alloc] init];
    [builder setApiKey: @"SDK API KEY"];
    [builder setKey: key];
    [builder setConfig: config];
    id<SplitFactory> factory = [builder build];
    id<SplitClient> client = factory.client;

    void (^getTreatment)(void) = ^(){
        NSString *treatment = [client getTreatment:splitName attributes: nil];
        NSLog(@"*************************************");
        NSLog(@"%@", treatment);
        NSLog(@"*************************************");
    };
    [client onEvent: SplitEventSdkReady execute: getTreatment];
```


- Update your relevant Split API Key, user key and Split name.

