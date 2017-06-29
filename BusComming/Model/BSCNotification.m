//
//  BSCNotification.m
//  BusComming
//
//  Created by wangshuang on 2017/4/13.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "BSCNotification.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation BSCNotification

+ (void)createLocalizedUserNotification {
    
    // 设置触发条件 UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0f repeats:NO];
    
    // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Dely 时间提醒 - title";
    content.subtitle = [NSString stringWithFormat:@"Dely 装逼大会竞选时间提醒 - subtitle"];
    content.body = @"Dely 装逼大会总决赛时间到，欢迎你参加总决赛！希望你一统X界 - body";
    content.badge = @666;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1",@"key2":@"value2"};
    
    // 创建通知标示
    NSString *requestIdentifier = @"Finn.X.time";
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    // 将通知请求 add 到 UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
    
}

@end
