//
//  BKArchive.h
//  BangKao
//
//  Created by xiao jie on 14-4-22.
//  Copyright (c) 2014年 肖杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFO_LOGIN                         @"userInfo_login.plist"
#define User_TouXiang_Image                     @"User_TouXiang_Image.plist"

@interface BKArchive : NSObject

/**
 *  功能:存档
 */
+ (void)archiveData:(id<NSCoding>)aData withFileName:(NSString *)aFileName;

/**
 *  功能:取档(第一次使用或版本更新时会清空数据)
 */
+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName;

/**
 *  功能:取档(获取系统数据，直接取档)
 */
+ (id<NSCoding>)unarchiveSystemDataWithFileName:(NSString *)aFileName;

@end
