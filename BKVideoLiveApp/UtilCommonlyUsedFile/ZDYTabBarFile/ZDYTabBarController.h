//
//  ZDYTabBarController.h
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJFCommonmacro.h"
#import "ZDYTabBar.h"


@interface ZDYTabBarController : UIViewController

/**
 *  视图控制器数组
 */
@property (nonatomic, strong) NSArray *viewControllers;

/**
 *  tabBar的信息数组 - 包括bar的title 与选中。未选择的图片
 */
@property (nonatomic, strong) NSArray *tabBarInfoArray;


@end
