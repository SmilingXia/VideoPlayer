//
//  ZDYTabBarController.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYTabBarController.h"
#import "PureLayout.h"

@interface ZDYTabBarController ()<ZDYTabBarDelegate>

@property (nonatomic, strong) ZDYTabBar *tabBar;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation ZDYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in viewControllers) {
            [self addChildViewController:viewController];
        }
    }
}

- (void)setTabBarInfoArray:(NSArray *)tabBarInfoArray{
    _tabBarInfoArray = tabBarInfoArray;
    _contentView = [[UIView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _tabBar = [[ZDYTabBar alloc] init];
    [self.view addSubview:_tabBar];
    [_tabBar autoSetDimension:ALDimensionHeight toSize:TabBar_H];
    [_tabBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    _tabBar.tabBarDelegate = self;
    _tabBar.itemsInfoArray = tabBarInfoArray;
}

- (void)fromIndex:(int)fromIndex toIndex:(int)toIndex{
    UIViewController *toVC = self.childViewControllers[toIndex];
    toVC.view.backgroundColor = [UIColor whiteColor];
    UIViewController *fromVC = self.childViewControllers[fromIndex];
    [fromVC.view removeFromSuperview];
    [_contentView addSubview:toVC.view];
    [toVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, TabBar_H, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//关闭状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
