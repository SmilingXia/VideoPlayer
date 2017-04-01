//
//  BKArchive.m
//  BangKao
//
//  Created by xiao jie on 14-4-22.
//  Copyright (c) 2014年 肖杰. All rights reserved.
//

#import "BKArchive.h"


@implementation BKArchive

/**
 *  功能:存档（缓存用户数据）
 */
+ (void)archiveData:(id<NSCoding>)aData withFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aData];
    [archiveData writeToFile:filePath atomically:NO];
}

/**
 *  功能:取档(获取用户数据，第一次使用或版本更新时会清空数据)
 */
+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
//    if ([BKSingleton sharedInstance].isFirstLaunch) {//第一次使用时，写入空数据，返回nil
//        [self archiveData:nil withFileName:aFileName];
//        return nil;
//    } else {
        id unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return unarchiveData;
//    }
}

/**
 *  功能:取档(获取系统数据，直接取档)
 */
+ (id<NSCoding>)unarchiveSystemDataWithFileName:(NSString *)aFileName
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:aFileName];
    id unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return unarchiveData;
}
@end
