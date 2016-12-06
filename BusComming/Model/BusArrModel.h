//
//  BusArrModel.h
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusModel;

@interface BusArrModel : NSObject

// 站台号
@property int32_t RouteID;
@property int32_t RunBusNum;
@property NSArray *RStaRealTInfoList;

@end
