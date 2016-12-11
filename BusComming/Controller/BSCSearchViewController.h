//
//  BSCSearchViewController.h
//  BusComming
//
//  Created by wangshuang on 2016/12/5.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusRouteModel;

typedef void(^returnRouteBlock)(BusRouteModel *model);

@interface BSCSearchViewController : UIViewController

@property (nonatomic, copy) returnRouteBlock returnRouteBlock;

- (void)returnModel:(returnRouteBlock)modelBlock;

@end
