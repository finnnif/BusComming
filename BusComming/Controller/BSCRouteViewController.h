//
//  BSCRouteViewController.h
//  BusComming
//
//  Created by wangshuang on 2016/12/5.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusRouteModel;

@interface BSCRouteViewController : UIViewController

/** bus路线模型 */
@property (nonatomic, strong) BusRouteModel *routeModel;

@end
