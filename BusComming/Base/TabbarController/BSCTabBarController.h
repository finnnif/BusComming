//
//  BSCTabBarController.h
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCTabBar;

@interface BSCTabBarController : UITabBarController

/**
 *  TabBar
 */
@property (nonatomic, strong) BSCTabBar *customTabBar;

/**
 * TabBar 图片占比，默认 0.7f， 如果是1 就没有文字
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

/**
 *  System will display the original controls so you should call this line when you change any tabBar item, like: `- popToRootViewController`, `someViewController.tabBarItem.title = xx`, etc.
 *  Remove origin controls
 */
- (void)removeOriginControls;

@end
