//
//  ViewController.m
//  BusComming
//
//  Created by wangshuang on 2016/11/1.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "ViewController.h"

#import "BusArrModel.h"
#import "BusModel.h"
#import "BusRouteModel.h"
#import "BusRouteSegmentModel.h"
#import "BusStationModel.h"

#import "BusTableViewCell.h"
#import "BSCNotification.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** AFN管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** 数组 */
@property (nonatomic, strong) NSArray *busLists;

@property (nonatomic, strong) NSArray *busStationLists;

/** <#des#> */
@property (nonatomic, strong) UITableView *tableView;

/** <#des#> */
@property (nonatomic, strong) NSString *fileDicPath1;
@property (nonatomic, strong) NSString *fileDicPath2;
@property (nonatomic, strong) NSString *fileDicPath3;

/** <#des#> */
@property (nonatomic, strong) NSString *docPath;
/** <#des#> */
@property (nonatomic, strong) UISegmentedControl *segmentControl;

@end

@implementation ViewController

static NSString *cellId = @"busCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BSCNotification createLocalizedUserNotification];
    
    self.docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.title = @"🚌";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segmentControl];
    [self onClick:self.segmentControl];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"更新配置" style:UIBarButtonItemStylePlain target:self action:@selector(updateStationInfo)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
    [self.tableView registerClass:[BusTableViewCell class] forCellReuseIdentifier:cellId];
    [self layoutSubviews];
    
    if (![self isFileExist:@"785.plist"] || ![self isFileExist:@"3111.plist"] || ![self isFileExist:@"3112.plist"]) {
        [self updateStationInfo];
    } else {
        self.fileDicPath1 = [self.docPath stringByAppendingPathComponent:@"785.plist"];
        self.fileDicPath2 = [self.docPath stringByAppendingPathComponent:@"3111.plist"];
        self.fileDicPath3 = [self.docPath stringByAppendingPathComponent:@"3112.plist"];
    }
}

//判断文件是否已经在沙盒中已经存在？
- (BOOL)isFileExist:(NSString *)fileName
{
    NSString *filePath = [self.docPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

- (void)updateStationInfo
{
    NSArray *arr = @[@{@"RouteID" : @927850}, @{@"RouteID" : @923110}];
    
    [SVProgressHUD show];
    for (NSDictionary *dict in arr) {
        [self.manager GET:@"http://61.164.37.75:55555/BusService/Require_RouteStatData" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            BusRouteModel *route = [BusRouteModel yy_modelWithJSON:responseObject[0]];
            BusRouteSegmentModel *Segment;
            
            if ([dict[@"RouteID"] isEqual:@927850]) {
                Segment = route.SegmentList[1];
                
                NSDictionary *json = [Segment yy_modelToJSONObject];
                self.fileDicPath1 = [self.docPath stringByAppendingPathComponent:@"785.plist"];
                [json writeToFile:self.fileDicPath1 atomically:YES];
                
            } else if ([dict[@"RouteID"] isEqual:@923110]) {
                Segment = route.SegmentList[0];
                
                NSDictionary *json1 = [Segment yy_modelToJSONObject];
                self.fileDicPath2 = [self.docPath stringByAppendingPathComponent:@"3111.plist"];
                [json1 writeToFile:self.fileDicPath2 atomically:YES];
                
                Segment = route.SegmentList[1];
                
                NSDictionary *json2 = [Segment yy_modelToJSONObject];
                self.fileDicPath3 = [self.docPath stringByAppendingPathComponent:@"3112.plist"];
                [json2 writeToFile:self.fileDicPath3 atomically:YES];
                [SVProgressHUD dismiss];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        NSArray *array = @[@"785去公司", @"311去公司", @"311回家"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(onClick:)forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (void)onClick:(UISegmentedControl *)segmentedControl
{
    self.title = [NSString stringWithFormat:@"🚌%@", [segmentedControl titleForSegmentAtIndex:segmentedControl.selectedSegmentIndex]];
    [self reloadBusDate];
}

- (void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.busLists.count) {
        return self.busLists.count;
    } else {        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.busModel = [self.busLists objectAtIndex:indexPath.row];
//    cell.stationModel = [self.busStationLists objectAtIndex:cell.busModel.RStanum];
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        cell.busType = EBusType785Go;
    } else if (self.segmentControl.selectedSegmentIndex == 1) {
        cell.busType = EBusType311Go;
    } else if (self.segmentControl.selectedSegmentIndex == 2) {
        cell.busType = EBusType311Back;
    }
    
    [cell refresh];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - date
- (void)reloadBusDate
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    if (self.segmentControl.selectedSegmentIndex == 0) {
        params2[@"RouteID"] = @927850;
        params2[@"Segmentid"] = @26597292;
        
        NSDictionary *resultData = [NSDictionary dictionaryWithContentsOfFile:self.fileDicPath1];
        self.busStationLists = [BusRouteSegmentModel yy_modelWithJSON:resultData].StationList;
        
    } else if (self.segmentControl.selectedSegmentIndex == 1) {
        
        params2[@"RouteID"] = @923110;
        params2[@"Segmentid"] = @26597414;
        
        NSDictionary *resultData = [NSDictionary dictionaryWithContentsOfFile:self.fileDicPath2];
        self.busStationLists = [BusRouteSegmentModel yy_modelWithJSON:resultData].StationList;
    } else if (self.segmentControl.selectedSegmentIndex == 2) {
        
        params2[@"RouteID"] = @923110;
        params2[@"Segmentid"] = @26597415;
        
        NSDictionary *resultData = [NSDictionary dictionaryWithContentsOfFile:self.fileDicPath3];
        self.busStationLists = [BusRouteSegmentModel yy_modelWithJSON:resultData].StationList;
    }
    
    [SVProgressHUD show];
    [self.manager GET:@"http://61.164.37.75:55555/BusService/Query_ByRouteID" parameters:params2 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        BusArrModel *arr = [BusArrModel yy_modelWithJSON:responseObject];
        self.busLists = arr.RStaRealTInfoList;
        // 刷新表格
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
