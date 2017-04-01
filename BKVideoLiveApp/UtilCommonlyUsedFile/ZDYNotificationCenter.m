//
//  ZDYNotificationCenter.m
//  ManView
//
//  Created by xia on 2017/1/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYNotificationCenter.h"

@implementation ZDYNotificationCenter

+ (void)updateStyle{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ZDY_YJMS object:nil userInfo:nil];
}

+ (void)updateFontSzie{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ZDY_FONT_SIZE object:nil userInfo:nil];
}

@end
