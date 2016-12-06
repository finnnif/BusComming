//
//  BusTableViewCell.h
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BusModel;
@class BusStationModel;

typedef NS_ENUM(NSUInteger, EBusType) {
    EBusType785Go,
    EBusType311Go,
    EBusType311Back
};

@interface BusTableViewCell : UITableViewCell

/** <#des#> */
@property (nonatomic, strong) BusModel *busModel;
/** <#des#> */
@property (nonatomic, strong) BusStationModel *stationModel;

/** <#des#> */
@property (nonatomic, assign) EBusType busType;

- (void)refresh;

@end
