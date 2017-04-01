//
//  PersonalInfoVC.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/21.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYMainViewController.h"
#import "UserInfoDataVO.h"

@interface PersonalInfoVC : ZDYMainViewController

/**
 *  个人中心数据
 */
@property (nonatomic, strong) UserInfoDataVO *userInfoDataVO;

@end
