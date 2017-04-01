//
//  UrlNSstring.m
//  ManView
//
//  Created by xia on 2017/1/17.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "UrlNSstring.h"

@implementation UrlNSstring

/**
 * 功能；url中文解码
 * 需求：如果字符串中有+符号，把+转化为空格
 */
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input {
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByRemovingPercentEncoding];
}

/**
 * 功能；动态计算字符串的高度
 * 需求：一个字符串，字符串字体大小，字符串对象的宽度
 */
+ (CGFloat)labHeigthString:(NSString *)content andFont:(UIFont *)viewFont andWidth:(float)objectWidth{
    NSDictionary *attrs = @{NSFontAttributeName : viewFont};
    CGSize maxSize = CGSizeMake(objectWidth, MAXFLOAT);
    // 计算文字占据的高度
    CGSize size = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;
}

/**
 * 功能；动态计算字符串的宽度
 * 需求：一个字符串，字符串字体大小，字符串对象的高度
 */
+ (CGFloat)labWidthString:(NSString *)content andFont:(UIFont *)viewFont and:(float)objectHeigth{
    NSDictionary *attrs = @{NSFontAttributeName : viewFont};
    CGSize maxSize = CGSizeMake(MAXFLOAT, objectHeigth);
    // 计算文字占据的高度
    CGSize size = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.width;
}






@end
