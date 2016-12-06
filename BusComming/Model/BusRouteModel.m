//
//  BusRouteModel.m
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BusRouteModel.h"
#import "BusRouteSegmentModel.h"

@implementation BusRouteModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"SegmentList" : [BusRouteSegmentModel class]};
}

@end
