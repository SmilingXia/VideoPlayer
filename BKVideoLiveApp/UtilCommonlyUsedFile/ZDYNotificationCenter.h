//
//  ZDYNotificationCenter.h
//  ManView
//
//  Created by xia on 2017/1/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#define ZDY_YJMS @"ZDY_YJMS"
#define ZDY_FONT_SIZE @"ZDY_FONT_SIZE"
#import <Foundation/Foundation.h>

@interface ZDYNotificationCenter : NSObject

/**
 *  通知 夜间模式
 */
+ (void)updateStyle;

/**
 *  通知 字体大小
 */

+ (void)updateFontSzie;


@end
