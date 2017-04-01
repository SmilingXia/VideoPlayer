//
//  ZDYDateStorageDanli.m
//  ManView
//
//  Created by xia on 2017/1/12.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYDateStorageDanli.h"

@implementation ZDYDateStorageDanli

#pragma mark - 2️⃣定义一个静态的类对象
static ZDYDateStorageDanli *dateStorageDanli = nil;

#pragma mark - 3️⃣实现初始化方法并返回2️⃣实例对象
+(ZDYDateStorageDanli *)initialization{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dateStorageDanli = [[self alloc] init];
    });
    return dateStorageDanli;
}

- (void)startTimer{
    [self updateSession];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(updateSession) userInfo:nil repeats:YES];
    [ZDYDateStorageDanli initialization].timer = timer;
}

- (void)updateSession{
    
    //6位随机数
    int nonced = arc4random() % 1000000;
    //Unix时间戳,长度10
    NSDate *now = [NSDate date];
    NSUInteger timestamplu = [now timeIntervalSince1970];
    //签名的拼接
    NSString *signature=[NSString stringWithFormat:@"%lu%d%@",(unsigned long)timestamplu,nonced,DL_TOKEN];
    NSString *noncedString = [NSString stringWithFormat:@"%d", nonced];
    NSString *timestamp = [NSString stringWithFormat:@"%lu", (unsigned long)timestamplu];
    //加密签名
    NSString *signatures = [ZDYEdsEncryption sha1:signature];
    
    NSMutableDictionary *mudict = [NSMutableDictionary dictionary];
    [mudict setObject:[ZDYDateStorageDanli initialization].sessionid forKey:@"sessionid"];
    [mudict setObject:timestamp forKey:@"timestamp"];
    [mudict setObject:@"iosapp" forKey:@"from"];
    [mudict setObject:noncedString forKey:@"nonce"];
    [mudict setObject:signatures forKey:@"signature"];
    
    ZDYNetworkRequest *request = [[ZDYNetworkRequest alloc] init];
    [request updataSession:mudict];
}

@end
