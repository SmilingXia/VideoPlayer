//
//  ZDYThemeStyleClass.m
//  LXJichengAndDuotaiAndFengzhuang
//
//  Created by xia on 2017/3/15.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYThemeStyleClass.h"

@implementation ZDYThemeStyleClass

static ZDYThemeStyleClass *themeStyleClass = nil;

+ (ZDYThemeStyleClass *)themeStyleClass{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        themeStyleClass = [[self alloc] init];
    });
    return themeStyleClass;
}

+ (UIColor *)navigationBarBackgroundColor{
    if ([ZDYThemeStyleClass themeStyleClass].navigationBarBackgroundColor == nil) {
        [ZDYThemeStyleClass themeStyleClass].navigationBarBackgroundColor = [UIColor orangeColor];
    }
    return [ZDYThemeStyleClass themeStyleClass].navigationBarBackgroundColor;
}

+ (UIColor *)navigationBarItemTableTextColor{
    if ([ZDYThemeStyleClass themeStyleClass].navigationBarItemTableTextColor == nil) {
        [ZDYThemeStyleClass themeStyleClass].navigationBarItemTableTextColor = [UIColor blackColor];
    }
    return [ZDYThemeStyleClass themeStyleClass].navigationBarItemTableTextColor;
}

+ (UIColor *)viewBackgroundColor{
    if ([ZDYThemeStyleClass themeStyleClass].viewBackgroundColor == nil) {
        [ZDYThemeStyleClass themeStyleClass].viewBackgroundColor = [UIColor whiteColor];
    }
    return [ZDYThemeStyleClass themeStyleClass].viewBackgroundColor;
}

+ (UIColor *)buttonTitleColor{
    if ([ZDYThemeStyleClass themeStyleClass].buttonTitleColor == nil) {
        [ZDYThemeStyleClass themeStyleClass].buttonTitleColor = [UIColor whiteColor];
    }
    return [ZDYThemeStyleClass themeStyleClass].buttonTitleColor;
}

+ (UIFont *)fontOfSize:(float)font{
    if ([ZDYThemeStyleClass themeStyleClass].textFont == 0) {
        [ZDYThemeStyleClass themeStyleClass].textFont = twoTitleLabFontTextFont;
    }
    float fontFloat;
    switch ([ZDYThemeStyleClass themeStyleClass].textFont) {
        case oneTitleLabFontTextFont:
            fontFloat = font - 4.0f;
            break;
        
        case twoTitleLabFontTextFont:
            fontFloat = font;
            break;
            
        case threeTitleLabFontTextFont:
            fontFloat = font + 4.0f;
            break;
            
        case oversizedTitleLabTextFont:
            fontFloat = font + 8.0f;
            break;
    }
    return [UIFont systemFontOfSize:fontFloat];
}

@end
