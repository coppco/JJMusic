//
//  AppDelegate.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "LockViewController.h"
#import "LockModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self enterApp];
    return YES;
}
- (void)enterApp {
    NSDDLog(@"%@", userDefaultGetValue(isFirstLoad));
    if (!userDefaultGetValue(isFirstLoad)) {
        //第一次进入,进入导航页
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    } else {
        //非首次进入
        HomeViewController *home = [[HomeViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:home];
    }
    [self.window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([LockModel getPassword].length != 0) {
        [self showLockViewController:LockViewTypeCheck];
    }
}
- (void)showLockViewController:(LockViewType)type {
    if (self.window.rootViewController.presentingViewController == nil) {
        LockViewController *lvc = [[LockViewController alloc] initWithType:type];
        lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.window.rootViewController presentViewController:lvc animated:YES completion:nil];
    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
