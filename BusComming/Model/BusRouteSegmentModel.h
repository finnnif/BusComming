//
//  BusRouteSegmentModel.h
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusRouteSegmentModel : NSObject

// 线路段id
@property int32_t SegmentID;
// 线路段终点站名
@property NSString *SegmentName;
// 线路段首末班时间
@property NSString *FirtLastShiftInfo;
// 站台列表
@property NSArray *StationList;

@end
