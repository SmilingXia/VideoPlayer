//
//  ViewController1.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ViewController1.h"
#import "XJFCommonmacro.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    //加入UINavigationController后防止子控件下偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.centerTitleLable.text = @"测验";
    [self displayWidthLeftButton:YES andWidthRightButton:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
