//
//  BSCRouteViewController.m
//  BusComming
//
//  Created by wangshuang on 2016/12/5.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BSCRouteViewController.h"
#import "BSCSearchViewController.h"
#import "BSCStationListTableViewController.h"

#import "BusRouteModel.h"
#import "BusRouteSegmentModel.h"
#import "BusStationModel.h"
#import "BusArrModel.h"
#import "BusModel.h"

#import "BusTableViewCell.h"

@interface BSCRouteViewController ()<UITableViewDelegate, UITableViewDataSource>

/** AFN管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** 公交车数组 */
@property (nonatomic, strong) NSArray *busArr;
/** 公交线路段数组 */
@property (nonatomic, strong) NSArray *busRouteSegmentArr;
/** 公交站数组 */
@property (nonatomic, strong) NSArray *busStationArr;
/** 选中公交站点模型 */
@property (nonatomic, strong) BusStationModel *stationModel;
/** <#des#> */
@property (nonatomic, strong) BusRouteSegmentModel *segmentModel;

/** 站点的下标 */
@property (nonatomic, strong) NSNumber *busStationIndex;

/** <#des#> */
@property (nonatomic, strong) UIView *selectBusRouteView;
/** 选择公交线路 */
@property (nonatomic, strong) UIButton *selectOneButton;
/** 选择公交方向 */
@property (nonatomic, strong) UIButton *selectTwoButton;
/** 选择所在站点 */
@property (nonatomic, strong) UIButton *selectThreeButton;

/** 显示车辆信息tableview */
@property (nonatomic, strong) UITableView *tableView;
/** 是否为默认线路及方向 */
@property (nonatomic, assign) BOOL isDefaultSegment;

@end

@implementation BSCRouteViewController

static NSString *cellId = @"busCellID";

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectBusRouteView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[BusTableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.selectOneButton.titleLabel.text isEqual:nil] || self.selectOneButton.titleLabel.text.length == 0) {
        [self selectBusRoute];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UIView *)selectBusRouteView
{
    if (!_selectBusRouteView) {
        _selectBusRouteView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44*3)];
        [_selectBusRouteView addSubview:self.selectOneButton];
        [_selectBusRouteView addSubview:self.selectTwoButton];
        [_selectBusRouteView addSubview:self.selectThreeButton];
    }
    return _selectBusRouteView;
}

- (UIButton *)selectOneButton
{
    if (!_selectOneButton) {
        _selectOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectOneButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [_selectOneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectOneButton addTarget:self action:@selector(selectBusRoute) forControlEvents:UIControlEventTouchUpInside];
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5, SCREEN_WIDTH, 0.5)];
//        line.backgroundColor = [UIColor grayColor];
//        [_selectOneButton addSubview:line];
    }
    return _selectOneButton;
}

- (UIButton *)selectTwoButton
{
    if (!_selectTwoButton) {
        _selectTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectTwoButton.frame = CGRectMake(0, 44, SCREEN_WIDTH, 44);
        [_selectTwoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectTwoButton addTarget:self action:@selector(selectBusSegment) forControlEvents:UIControlEventTouchUpInside];
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5, SCREEN_WIDTH, 0.5)];
//        line.backgroundColor = [UIColor grayColor];
//        [_selectTwoButton addSubview:line];
    }
    return _selectTwoButton;
}

- (UIButton *)selectThreeButton
{
    if (!_selectThreeButton) {
        _selectThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectThreeButton.frame = CGRectMake(0, 44*2, SCREEN_WIDTH, 44);
        [_selectThreeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectThreeButton addTarget:self action:@selector(selectBusStation) forControlEvents:UIControlEventTouchUpInside];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor grayColor];
        [_selectThreeButton addSubview:line];
    }
    return _selectThreeButton;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.selectBusRouteView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.selectBusRouteView.bottom - 49) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - requestData
- (void)requestDataWithRouteID:(int32_t)routeID
{
    NSDictionary *dict = @{@"RouteID": @(routeID)};
    
    [self.manager GET:@"http://61.164.37.75:55555/BusService/Require_RouteStatData/" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.busRouteSegmentArr = [NSArray yy_modelArrayWithClass:[BusRouteSegmentModel class] json:responseObject[0][@"SegmentList"]];
        self.isDefaultSegment = YES;
        
        self.segmentModel = self.busRouteSegmentArr.firstObject;
        
        BusStationModel *start = self.segmentModel.StationList.firstObject;
        BusStationModel *end = self.segmentModel.StationList.lastObject;
        
        self.stationModel = end;
        self.busStationArr = self.segmentModel.StationList;
        self.busStationIndex = @(self.busStationArr.count);
        
        NSString *str = [NSString stringWithFormat:@"%@ - %@", start.StationName, end.StationName];
        
        [self.selectTwoButton setTitle:str forState:UIControlStateNormal];
        [self.selectThreeButton setTitle:end.StationName forState:UIControlStateNormal];
        
        [self requestBusDateWithRouteID:self.routeModel.RouteID segmentid:self.segmentModel.SegmentID];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestBusDateWithRouteID:(int32_t)routeID segmentid:(int32_t)segmentid
{
    NSDictionary *params = @{@"RouteID": @(routeID), @"Segmentid": @(segmentid)};
    
    [self.manager GET:@"http://61.164.37.75:55555/BusService/Query_ByRouteID" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        BusArrModel *arr = [BusArrModel yy_modelWithJSON:responseObject];
        self.busArr = arr.RStaRealTInfoList;
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

#pragma mark - selector
- (void)selectBusRoute
{
    BSCSearchViewController *vc = [[BSCSearchViewController alloc] init];
    WS(weakSelf);
    
    [vc returnModel:^(BusRouteModel *model) {
        weakSelf.routeModel = model;
        [weakSelf.selectOneButton setTitle:model.RouteName forState:UIControlStateNormal];
        [weakSelf requestDataWithRouteID:weakSelf.routeModel.RouteID];
    }];
    
    vc.title = @"选择线路";
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
}

- (void)selectBusSegment
{
    if (!self.isDefaultSegment) {
        self.segmentModel = self.busRouteSegmentArr.firstObject;
        self.isDefaultSegment = YES;
    } else {
        self.segmentModel = self.busRouteSegmentArr.lastObject;
        self.isDefaultSegment = NO;
    }
    
    BusStationModel *start = self.segmentModel.StationList.firstObject;
    BusStationModel *end = self.segmentModel.StationList.lastObject;
    
    self.stationModel = end;
    self.busStationArr = self.segmentModel.StationList;
    self.busStationIndex = @(self.busStationArr.count);
    
    NSString *str = [NSString stringWithFormat:@"%@ - %@", start.StationName, end.StationName];
    
    [self.selectTwoButton setTitle:str forState:UIControlStateNormal];
    [self.selectThreeButton setTitle:end.StationName forState:UIControlStateNormal];
    
    [self requestBusDateWithRouteID:self.routeModel.RouteID segmentid:self.segmentModel.SegmentID];
}

- (void)selectBusStation
{
    BSCStationListTableViewController *vc = [[BSCStationListTableViewController alloc] initWithStyle:UITableViewStylePlain stationArr:self.busStationArr];
    WS(weakSelf);
    [vc returnStationModel:^(BusStationModel *model, NSNumber *index) {
        [weakSelf.selectThreeButton setTitle:model.StationName forState:UIControlStateNormal];
        weakSelf.stationModel = model;
        weakSelf.busStationIndex = index;
        [weakSelf requestBusDateWithRouteID:weakSelf.routeModel.RouteID segmentid:weakSelf.segmentModel.SegmentID];
    }];
    vc.title = @"选择站点";
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:nil];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.busArr && self.busArr.count) {
        return self.busArr.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusModel *bus = [self.busArr objectAtIndex:indexPath.row];
    BusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (self.stationModel && self.busStationIndex && bus) {
        cell.stationList = self.busStationArr;
        cell.busModel = bus;
        cell.busStationIndex = self.busStationIndex;
        [cell refresh];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
