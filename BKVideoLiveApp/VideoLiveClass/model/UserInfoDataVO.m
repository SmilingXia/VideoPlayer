//
//  UserInfoDataVO.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/21.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "UserInfoDataVO.h"

@implementation UserInfoDataVO

- (void)setLinkman:(NSString *)linkman{
    linkman = [UrlNSstring decodeFromPercentEscapeString:linkman];
    _linkman = linkman;
}

- (void)setAddress:(NSString *)address{
    address = [UrlNSstring decodeFromPercentEscapeString:address];
    _address = address;
}

@end
