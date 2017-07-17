//
//  AppDelegate+BSCAppService.m
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "AppDelegate+BSCAppService.h"
#import "BSCTabBarController.h"
#import <CYLTabBarController.h>
#import "BSCNavigationController.h"
#import "ViewController.h"
#import "BSCRouteViewController.h"

@implementation AppDelegate (BSCAppService)

#pragma mark ————— 初始化服务 —————
- (void)initService {

}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    self.window.backgroundColor = kWhiteColor;
    [self setupViewControllers];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    
}

- (void)setupViewControllers {
    ViewController *firstViewController = [[ViewController alloc] init];
    BSCNavigationController *nav1 = [[BSCNavigationController alloc]
                                     initWithRootViewController:firstViewController];
    
    BSCRouteViewController *secondViewController = [[BSCRouteViewController alloc] init];
    BSCNavigationController *nav2 = [[BSCNavigationController alloc]
                                     initWithRootViewController:secondViewController];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[nav1, nav2]];
    self.tabBarController = tabBarController;
}

/**
 * 在`-setViewControllers:`之前设置TabBar的属性，
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"收藏",
                            CYLTabBarItemImage : @"tabBarItem1",
                            CYLTabBarItemSelectedImage : @"tabBarItem1",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"线路",
                            CYLTabBarItemImage : @"tabBarItem2",
                            CYLTabBarItemSelectedImage : @"tabBarItem2",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
//    BOOL isNetWork = [notification.object boolValue];
}

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
/*
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
*/

#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
//    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
//        
//        switch (networkStatus) {
//                // 未知网络
//            case PPNetworkStatusUnknown:
//                DLog(@"网络环境：未知网络");
//                // 无网络
//            case PPNetworkStatusNotReachable:
//                DLog(@"网络环境：无网络");
////                KPostNotification(KNotificationNetWorkStateChange, @NO);
//                break;
//                // 手机网络
//            case PPNetworkStatusReachableViaWWAN:
//                DLog(@"网络环境：手机自带网络");
//                // 无线网络
//            case PPNetworkStatusReachableViaWiFi:
//                DLog(@"网络环境：WiFi");
////                KPostNotification(KNotificationNetWorkStateChange, @YES);
//                break;
//        }
//        
//    }];
    
}

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (UIViewController *)getCurrentVc {
    
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController;
    }
    return result;
}

-(UIViewController *)getCurrentUIVc
{
    UIViewController  *superVC = [self getCurrentVc];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    else {
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    }
    return superVC;
}

@end
