//
//  BSCSearchRouteTableViewController.h
//  BusComming
//
//  Created by wangshuang on 2017/7/3.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusRouteModel;

typedef void(^returnRouteBlock)(BusRouteModel *model);

@interface BSCSearchRouteTableViewController : UITableViewController

@property (nonatomic, copy) returnRouteBlock returnRouteBlock;

- (void)returnModel:(returnRouteBlock)modelBlock;

@end
