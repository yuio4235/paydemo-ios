//
//  AppDelegate.h
//  PayDemo
//
//  Created by 张毅 on 19/07/2017.
//  Copyright © 2017 张毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "PaySuccViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

