//
//  BSCNavigationController.h
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCNavigationController : UINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
