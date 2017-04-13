//
//  BSCStationListTableViewController.h
//  BusComming
//
//  Created by wangshuang on 2016/12/9.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusStationModel;

typedef void(^returnStationBlock)(BusStationModel *model, NSNumber *index);

@interface BSCStationListTableViewController : UITableViewController

@property (nonatomic, copy) returnStationBlock returnStationBlock;

- (void)returnStationModel:(returnStationBlock)modelBlock;

- (instancetype)initWithStyle:(UITableViewStyle)style stationArr:(NSArray *)stationArr;

@end
