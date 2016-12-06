//
//  BusModel.h
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusModel : NSObject

// 公交车id
@property NSString *StationID;

// 站台号
@property int32_t RStanum;

// 到站状态
@property int32_t ExpArriveBusStaNum;

// 停站状态
@property int32_t StopBusStaNum;

// bus类型
@property int32_t BusType;

@end
