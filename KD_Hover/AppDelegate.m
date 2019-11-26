//
//  AppDelegate.m
//  KD_Hover
//
//  Created by paul on 2019/11/25.
//  Copyright © 2019 paul. All rights reserved.
//

#import "AppDelegate.h"
#import "HoverRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    HoverRootViewController *rootVC = [[HoverRootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    nav.navigationBar.alpha = 0.2;
    self.window.rootViewController = nav;
    return YES;
}

@end
