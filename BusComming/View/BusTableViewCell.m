//
//  BusTableViewCell.m
//  BusComming
//
//  Created by wangshuang on 2016/11/2.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BusTableViewCell.h"
#import <Masonry.h>
#import "BusModel.h"
#import "BusStationModel.h"

@interface BusTableViewCell ()

/** <#des#> */
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;


@end

@implementation BusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView).offset(-5);
        }];
        
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.label2);
            make.centerY.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return self;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [UILabel new];
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [UILabel new];
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [UILabel new];
        _label3.font = [UIFont systemFontOfSize:10];
    }
    return _label3;
}

- (void)refresh
{
    if (self.busModel && self.busStationIndex && self.stationList) {
        
        BusStationModel *stationModel = [self.stationList objectAtIndex:self.busModel.RStanum];
        if (self.busModel.StopBusStaNum == 0) {
            self.label1.text = [NSString stringWithFormat:@"已离开: %@", stationModel.StationName];
        } else if (self.busModel.StopBusStaNum == 1) {
            self.label1.text = [NSString stringWithFormat:@"已进站: %@", stationModel.StationName];
        }
        
        [self stationTipsWithNumber:self.busStationIndex];
        
//        if (self.busType == EBusType785Go) {
//            [self stationTipsWithNumber:12];
//        } else if (self.busType == EBusType311Go) {
//            [self stationTipsWithNumber:8];
//        } else if (self.busType == EBusType311Back) {
//            [self stationTipsWithNumber:14];
//        }
        
        self.label3.text = [NSString stringWithFormat:@"ExpNum: %d", self.busModel.ExpArriveBusStaNum];
    }
}

- (void)stationTipsWithNumber:(int32_t)number
{
    int32_t rStanum = self.busModel.RStanum;
    if (rStanum < number) {
        self.label2.text = [NSString stringWithFormat:@"还有%d站", number - rStanum];
        self.label1.textColor = [UIColor blackColor];
        self.label2.textColor = [UIColor blackColor];
    } else if (rStanum == number) {
        self.label2.text = @"已到站";
        self.label1.textColor = [UIColor greenColor];
        self.label2.textColor = [UIColor greenColor];
    } else if (rStanum > number) {
        self.label2.text = [NSString stringWithFormat:@"已过%d站", rStanum - number];
        self.label1.textColor = [UIColor grayColor];
        self.label2.textColor = [UIColor grayColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
