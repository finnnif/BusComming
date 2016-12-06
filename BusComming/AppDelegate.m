//
//  AppDelegate.m
//  BusComming
//
//  Created by wangshuang on 2016/11/1.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "AppDelegate.h"
#import "UIView+YOYOAddition.h"
#import "BSCSearchViewController.h"
#import "BSCRouteViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    
    ViewController *vc1 = [ViewController new];
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    item1.title = @"收藏";
    nv1.tabBarItem = item1;
    
    BSCRouteViewController *vc2 = [[BSCRouteViewController alloc] init];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    item2.title = @"路线";
    nv2.tabBarItem = item2;
    
    UIViewController *vc3 = [UIViewController new];
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    item3.title = @"设置";
    nv3.tabBarItem = item3;
    
    tabBarVc.viewControllers = @[nv1, nv2, nv3];
    
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
