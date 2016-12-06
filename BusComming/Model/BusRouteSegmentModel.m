//
//  BusRouteSegmentModel.m
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BusRouteSegmentModel.h"
#import "BusStationModel.h"

@implementation BusRouteSegmentModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"StationList" : [BusStationModel class]};
}

@end
