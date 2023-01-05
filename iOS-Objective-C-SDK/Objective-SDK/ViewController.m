//
//  ViewController.m
//  Objective-SDK
//
//  Created by Bilal Al-Shahwany on 6/10/20.
//  Copyright © 2020 Split. All rights reserved.
//

#import "ViewController.h"
@import Split;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

}


@end
