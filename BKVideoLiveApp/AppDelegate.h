//
//  AppDelegate.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//登录成功
- (void)userDlsuccess;

//退出登录
- (void)userSignOut;

@end

