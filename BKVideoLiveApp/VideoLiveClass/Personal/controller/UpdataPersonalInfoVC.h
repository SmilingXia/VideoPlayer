//
//  UpdataPersonalInfoVC.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/22.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYMainViewController.h"

@interface UpdataPersonalInfoVC : ZDYMainViewController

/**
 *  修改的标题
 */
@property (nonatomic, strong) NSString *updataTitle;

/**
 *  需要修改的字符串
 */
@property (nonatomic, strong) NSString *updataSource;

/**
 *  个人中心数据
 */
@property (nonatomic, strong) UserInfoDataVO *userInfoDataVO;

@end
