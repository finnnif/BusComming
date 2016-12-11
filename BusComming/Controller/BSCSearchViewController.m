//
//  BSCSearchViewController.m
//  BusComming
//
//  Created by wangshuang on 2016/12/5.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BSCSearchViewController.h"
#import "BusRouteModel.h"
#import "BSCRouteViewController.h"

@interface BSCSearchViewController ()<UISearchResultsUpdating, UITableViewDelegate,UITableViewDataSource>

/** AFN管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** <#des#> */
@property (nonatomic, strong) UISearchController *searchController;
/** <#des#> */
@property (nonatomic, strong) UITableView *searchTableView;
/** <#des#> */
@property (nonatomic, strong) NSArray *busRouteArr;

@end

@implementation BSCSearchViewController

static NSString *cellId = @"busCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    
    [self loadSearchViewController];
    [self.view addSubview:self.searchTableView];
    
    [self.searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    NSDictionary *dict = @{@"TimeStamp": @123};
    [self.manager GET:@"http://61.164.37.75:55555/BusService/Require_AllRouteData/" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.busRouteArr = [NSArray yy_modelArrayWithClass:[BusRouteModel class] json:responseObject[@"RouteList"]];
        [self.searchTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadSearchViewController
{
    // Create the search results controller and store a reference to it.
    UIViewController *vc = [[UIViewController alloc] init];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:vc];
    
    // Use the current view controller to update the search results.
    self.searchController.searchResultsUpdater = self;
    
    // Install the search bar as the table header.
    self.searchTableView.tableHeaderView = self.searchController.searchBar;
    
    // It is usually good to set the presentation context.
    self.definesPresentationContext = YES;
    
}

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UITableView *)searchTableView
{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
    }
    return _searchTableView;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.busRouteArr && self.busRouteArr.count) {
        return self.busRouteArr.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BusRouteModel *model = [self.busRouteArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.RouteName;
    return cell;
}

- (void)returnModel:(returnRouteBlock)modelBlock
{
    self.returnRouteBlock = modelBlock;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusRouteModel *model = [self.busRouteArr objectAtIndex:indexPath.row];
    
    self.returnRouteBlock(model);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - searchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
