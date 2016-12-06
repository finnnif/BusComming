//
//  UIView+YOYOAddition.h
//  YOYO
//
//  Created by wdd on 15/11/5.
//  Copyright © 2015年 wdd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_BOUNDS     [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT     SCREEN_BOUNDS.size.height
#define SCREEN_WIDTH      SCREEN_BOUNDS.size.width
#define CONTENT_HEIGHT    (SCREEN_HEIGHT - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT 20
#define NAV_BAR_HEIGHT    44

@interface UIView (YOYOAddition)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (readonly, nonatomic) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (readonly, nonatomic) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (readonly, nonatomic) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (readonly, nonatomic) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (readonly, nonatomic) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;

@end
