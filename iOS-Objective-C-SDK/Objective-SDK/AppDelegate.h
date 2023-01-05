//
//  AppDelegate.h
//  Objective-SDK
//
//  Created by Bilal Al-Shahwany on 6/10/20.
//  Copyright © 2020 Split. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

