//
//  AppDelegate.h
//  BusComming
//
//  Created by wangshuang on 2016/11/1.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYLTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CYLTabBarController *tabBarController;

@end

