//
//  BusRouteModel.h
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusRouteModel : NSObject

// 线路id
@property int32_t RouteID;
// 线路名
@property NSString *RouteName;
// 线路类型 : 1: 双向 2:单向
@property int32_t RouteType;

@property NSArray *SegmentList;

@end
