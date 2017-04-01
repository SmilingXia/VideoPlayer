//
//  UrlNSstring.h
//  ManView
//
//  Created by xia on 2017/1/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UrlNSstring : NSObject

/**
 * 功能；url中文解码
 * 需求：如果字符串中有+符号，把+转化为空格
 */
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input;

/**
 * 功能；动态计算字符串的高度
 * 需求：一个字符串，字符串字体大小，字符串对象的宽度
 */
+ (CGFloat)labHeigthString:(NSString *)content andFont:(UIFont *)viewFont andWidth:(float)objectWidth;

/**
 * 功能；动态计算字符串的宽度
 * 需求：一个字符串，字符串字体大小，字符串对象的高度
 */
+ (CGFloat)labWidthString:(NSString *)content andFont:(UIFont *)viewFont and:(float)objectHeigth;

@end
