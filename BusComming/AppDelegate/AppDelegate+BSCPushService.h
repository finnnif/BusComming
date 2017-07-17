//
//  AppDelegate+BSCPushService.h
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BSCPushService)

// 申请通知权限
- (void)replyPushNotificationAuthorization:(UIApplication *)application;

@end
