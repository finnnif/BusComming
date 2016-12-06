//
//  BusArrModel.m
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BusArrModel.h"
#import "BusModel.h"

@implementation BusArrModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"RStaRealTInfoList" : [BusModel class]};
}

@end
