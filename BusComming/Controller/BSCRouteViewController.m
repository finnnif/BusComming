//
//  BSCRouteViewController.m
//  BusComming
//
//  Created by wangshuang on 2016/12/5.
//  Copyright © 2016年 wangshuang. All rights reserved.
//

#import "BSCRouteViewController.h"
#import "BSCSearchViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface BSCRouteViewController ()<UITableViewDelegate, UITableViewDataSource>

/** AFN管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** <#des#> */
@property (nonatomic, strong) NSArray *busArr;
/** <#des#> */
@property (nonatomic, strong) UITableView *tableView;

/** <#des#> */
@property (nonatomic, assign) BOOL isNoRoute;

@end

@implementation BSCRouteViewController

static NSString *cellId = @"busCellID";


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
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isNoRoute = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    if (self.isNoRoute) {
        
        BSCSearchViewController *vc = [[BSCSearchViewController alloc] init];
        vc.title = @"选择线路";
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nv animated:YES completion:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.busArr.count) {
        return self.busArr.count;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = @"🆚";
//    [cell refresh];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
