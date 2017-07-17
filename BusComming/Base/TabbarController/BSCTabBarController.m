//
//  BSCTabBarController.m
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "BSCTabBarController.h"
#import "BSCTabBar.h"
#import "BSCTabBarItem.h"
#import "BSCNavigationController.h"
#import "ViewController.h"
#import "BSCRouteViewController.h"
#import "BSCSearchRouteTableViewController.h"

@interface BSCTabBarController ()<TabBarDelegate>

@property (nonatomic, copy) NSMutableArray *customViewControllers;

@end

@implementation BSCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化tabbar
    [self setUpTabBar];
    // 添加子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self removeOriginControls];
}

#pragma mark ————— 初始化TabBar —————
- (void)setUpTabBar {
    [self.customTabBar addSubview:({
        
        BSCTabBar *tabBar = [[BSCTabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        
        self.customTabBar = tabBar;
    })];
}
#pragma mark - ——————— 初始化VC ————————
- (void)setUpAllChildViewController {
    
    _customViewControllers = @[].mutableCopy;
//    ViewController *vc = [[ViewController alloc]init];
//    [self setupChildViewController:vc title:@"收藏" imageName:nil seleceImageName:nil];
//    
//    BSCRouteViewController *routeVc = [[BSCRouteViewController alloc] init];
//    [self setupChildViewController:routeVc title:@"线路" imageName:nil seleceImageName:nil];
    
//    UIViewController *settingVc = [[UIViewController alloc] init];
//    [self setupChildViewController:settingVc title:@"设置" imageName:@"icon_tabbar_merchant_normal" seleceImageName:nil];
//    
//    UIViewController *setting1Vc = [[UIViewController alloc] init];
//    [self setupChildViewController:setting1Vc title:@"设置1" imageName:@"icon_tabbar_merchant_normal" seleceImageName:nil];
    
    UIViewController *vc = [[UIViewController alloc]init];
    [self setupChildViewController:vc title:@"消息" imageName:@"icon_tabbar_merchant_normal" seleceImageName:@"icon_tabbar_merchant_selected"];
    
    UIViewController *vc1 = [[UIViewController alloc]init];
    [self setupChildViewController:vc1 title:@"我的" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_selected"];
    
    self.viewControllers = _customViewControllers;
}

- (void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    //    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    //    controller.tabBarItem.badgeValue = _VCS.count%2==0 ? @"100": @"1";
    //包装导航控制器
    BSCNavigationController *nav = [[BSCNavigationController alloc] initWithRootViewController:controller];
    controller.title = title;
    [_customViewControllers addObject:nav];
}

#pragma mark ————— 统一设置tabBarItem属性并添加到TabBar —————
- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.customTabBar.badgeTitleFont         = SYSTEM_DEFAULT_FONT(11.0f);
    self.customTabBar.itemTitleFont          = SYSTEM_DEFAULT_FONT(10.0f);
    self.customTabBar.itemImageRatio         = self.itemImageRatio == 0 ? 0.7 : self.itemImageRatio;
    self.customTabBar.itemTitleColor         = kBlackColor;
    self.customTabBar.selectedItemTitleColor = kBlueColor;
    
    self.customTabBar.tabBarItemCount = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *vc = (UIViewController *)obj;
        
        UIImage *selectedImage = vc.tabBarItem.selectedImage;
        vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:vc];
        [self.customTabBar addTabBarItem:vc.tabBarItem];
    }];
}

#pragma mark ————— 选中某个tab —————
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    
    self.customTabBar.selectedItem.selected = NO;
    self.customTabBar.selectedItem = self.customTabBar.tabBarItems[selectedIndex];
    self.customTabBar.selectedItem.selected = YES;
}

#pragma mark ————— 取出系统自带的tabbar并把里面的按钮删除掉 —————
- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }];
}


#pragma mark - TabBarDelegate Method

- (void)tabBar:(BSCTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
