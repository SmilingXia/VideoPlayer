//
//  UserInfoDataVO.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/21.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "JSONModel.h"
#import "UrlNSstring.h"

@interface UserInfoDataVO : JSONModel

/**
 *
 */
@property (nonatomic, strong) NSString *errcode;

/**
 *
 */
@property (nonatomic, strong) NSString *errmsg;

/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *linkman;

/**
 *  电话
 */
@property (nonatomic, strong) NSString *tel;

/**
 *  邮件
 */
@property (nonatomic, strong) NSString *email;

/**
 *  QQ
 */
@property (nonatomic, strong) NSString *qq;

/**
 *  身份证号
 */
@property (nonatomic, strong) NSString *idcard;

/**
 *  地址
 */
@property (nonatomic, strong) NSString *address;

/**
 *  微信
 */
@property (nonatomic, strong) NSString *weixin;

@end
