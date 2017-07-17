//
//  AppDelegate+BSCAppService.h
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

@interface AppDelegate (BSCAppService)

//初始化服务
- (void)initService;
//初始化 window
- (void)initWindow;
//监听网络状态
- (void)monitorNetworkStatus;
//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
- (UIViewController *)getCurrentVc;

- (UIViewController *)getCurrentUIVc;

@end
