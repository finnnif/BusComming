//
//  BSCNavigationController.m
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#import "BSCNavigationController.h"

@interface BSCNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, weak) id popDelegate;
@end

@implementation BSCNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:kGrayColor];
    [navBar setTintColor:kWhiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor, NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    
    //导航栏左右文字主题
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor,
                                                NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                } forState:UIControlStateNormal];
    
        //tabBar主题 title文字属性
//        UITabBarItem *tabBarItem = [UITabBarItem appearance];
//        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kGrayColor} forState:UIControlStateNormal];
//        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ButtonNormalColor} forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    //navigationBar样式设置
    //    self.navigationBar.barTintColor = KBlueColor;
    //    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : KWhiteColor, NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}];
    //    [self.navigationBar setTintColor:KWhiteColor];    // Do any additional setup after loading the view.
}

//解决手势失效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[BSCViewController class]]) {
        BSCViewController * vc = (BSCViewController *)viewController;
        if (vc.isHidenNaviBar) {
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName {
    Class classObj = NSClassFromString(ClassName);
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    
    return nil;
}


-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
