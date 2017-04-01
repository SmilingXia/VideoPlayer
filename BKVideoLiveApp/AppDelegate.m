//
//  AppDelegate.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "AppDelegate.h"
#import "XJFLoginVC.h"
#import "BKArchive.h"
#import "ZDYDateStorageDanli.h"
#import "ZDYUserLoginVO.h"
#import "ZDYTabBarController.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //是否自动登录
    [self isAutoLogin];
    return YES;
}

#pragma mark - 判断是否可以自动登录
- (void)isAutoLogin{
    
    ZDYUserLoginVO *userInfo = (ZDYUserLoginVO *)[BKArchive unarchiveDataWithFileName:USER_INFO_LOGIN];
    if (userInfo) {
        //启动定时器，，刷新session
        [ZDYDateStorageDanli initialization].loginUserInfo = userInfo;
        [ZDYDateStorageDanli initialization].uid = userInfo.uid;
        [ZDYDateStorageDanli initialization].sessionid = userInfo.sessionid;
        [[ZDYDateStorageDanli initialization] startTimer];
        [self userDlsuccess];
    }else{
        XJFLoginVC *vc = [[XJFLoginVC alloc] init];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
    }
}

- (void)userDlsuccess{
    ZDYTabBarController *tabBarVC = [[ZDYTabBarController alloc] init];
    UIViewController *vc = [[ViewController alloc] init];
    
    UIViewController *vc1 = [[ViewController1 alloc] init];
    
    UIViewController *vc2 = [[ViewController2 alloc] init];
    
    [tabBarVC setViewControllers:@[vc,vc1,vc2]];
    
    NSArray *tabBarItemTitle = @[@"练习", @"测验", @"个人"];
    NSArray *tabBarItemImages = @[@"exercises", @"test", @"personal"];
    [tabBarVC setTabBarInfoArray:@[tabBarItemTitle,tabBarItemImages]];
    
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
}

//退出登录
- (void)userSignOut{
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    //暂停当前的任务
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //进入后台
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //后台到活动转换的一部分 -- 1
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    ZDYUserLoginVO *userInfo = (ZDYUserLoginVO *)[BKArchive unarchiveDataWithFileName:USER_INFO_LOGIN];
    if (userInfo) {
        [[ZDYDateStorageDanli initialization] updateSession];
    }
    //后天进入前台刷新数据 -- 2
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //程序终止
}


@end
