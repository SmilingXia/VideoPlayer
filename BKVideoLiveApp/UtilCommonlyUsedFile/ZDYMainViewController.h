//
//  ZDYMainViewController.h
//  LXJichengAndDuotaiAndFengzhuang
//
//  Created by xia on 2017/3/14.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#define Bar_View_Heigth 60

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "XJFCommonmacro.h"
#import "ZDYThemeStyleClass.h"
#import "ZDYNotificationCenter.h"
#import "BKArchive.h"
#import "VC2cellModel.h"
#import "ZDYNetworkRequest.h"
#import "ZDYDateStorageDanli.h"
#import "VC2TableViewCell.h"
#import "ZDYUIAlertView.h"
#import "NSLayoutConstraint+PureLayout.h"
#import "AppDelegate.h"

@interface ZDYMainViewController : UIViewController

@property (nonatomic, strong) UIView *naviGationBarView;
@property (nonatomic, strong) UILabel *centerTitleLable;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

/**
 *  右边视图的点击事件
 */
- (void)rightButtonOnclick:(UIButton *)sender;

/**
 *  是否显示左右视图 (yes - 隐藏) (no - 显示)
 */
- (void)displayWidthLeftButton:(BOOL)isDisplayLeftButton andWidthRightButton:(BOOL)isDisplayRightButton;


@end
