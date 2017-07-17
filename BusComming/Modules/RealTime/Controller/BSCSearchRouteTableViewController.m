//
//  BSCSearchRouteTableViewController.m
//  BusComming
//
//  Created by wangshuang on 2017/7/3.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "BSCSearchRouteTableViewController.h"
#import "BusRouteModel.h"

@interface BSCSearchRouteTableViewController ()<UISearchResultsUpdating>

@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property (nonatomic, strong) UISearchController *searchController;
/** 原始数据 */
@property (nonatomic, copy) NSArray<BusRouteModel *> *busRouteArray;
/** 过滤数据 */
@property (nonatomic, copy) NSArray<BusRouteModel *> *filteredBusRouteArray;

@end

static NSString *cellId = @"busRouteCellId";

@implementation BSCSearchRouteTableViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    }
    return _searchController;
}

- (void)setUpNavgationBar {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];
    self.busRouteArray = @[];
    self.filteredBusRouteArray = @[];
    [self setupData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    WS(weakSelf);
    [self.manager GET:@"http://61.164.37.75:55555/BusService/Require_AllRouteData/" parameters:@{@"TimeStamp": @123} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        ST(weakSelf,strongSelf);
        strongSelf.busRouteArray = [NSArray yy_modelArrayWithClass:[BusRouteModel class] json:responseObject[@"RouteList"]];
        [strongSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UISearchResultsUpdating Delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterContentForSearchText:searchController.searchBar.text];
}

- (void)filterContentForSearchText:(NSString *)searchText {
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self.RouteName contains[cd] %@", searchText];
    self.filteredBusRouteArray = [self.busRouteArray filteredArrayUsingPredicate:searchPredicate];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString: @""]) {
        return self.filteredBusRouteArray.count;
    }
    return self.busRouteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    BusRouteModel *model;
    if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString:@""]) {
        model = self.filteredBusRouteArray[indexPath.row];
    } else
    {
        model = self.busRouteArray[indexPath.row];
    }
    cell.textLabel.text = model.RouteName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BusRouteModel *model;
    if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString:@""]) {
        model = self.filteredBusRouteArray[indexPath.row];
    } else
    {
        model = self.busRouteArray[indexPath.row];
    }
    self.returnRouteBlock(model);
}

- (void)returnModel:(returnRouteBlock)modelBlock
{
    self.returnRouteBlock = modelBlock;
}

@end
