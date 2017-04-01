//
//  ZDYThemeStyleClass.h
//  LXJichengAndDuotaiAndFengzhuang
//
//  Created by xia on 2017/3/15.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZDYThemeStyleClass : NSObject

+ (ZDYThemeStyleClass *)themeStyleClass;


/**
 * 字体大小
 */
typedef enum {
    oneTitleLabFontTextFont = 1,                // 小
    twoTitleLabFontTextFont,                    // 默认（中）
    threeTitleLabFontTextFont,                  // 大
    oversizedTitleLabTextFont,                  // 超大字体
}TextFont;


/**
 *  导航栏背景颜色
 */
@property (nonatomic, strong) UIColor *navigationBarBackgroundColor;
/**
 *  导航栏字体颜色
 */
@property (nonatomic, strong) UIColor *navigationBarItemTableTextColor;
/**
 *  视图背景颜色
 */
@property (nonatomic, strong) UIColor *viewBackgroundColor;
/**
 *  按钮常用的字体颜色
 */
@property (nonatomic, strong) UIColor *buttonTitleColor;

+ (UIColor *)navigationBarBackgroundColor;
+ (UIColor *)navigationBarItemTableTextColor;
+ (UIColor *)viewBackgroundColor;
+ (UIColor *)buttonTitleColor;

/**
 *  字体大小
 */
@property (nonatomic, assign) TextFont textFont;

/**
 *  记录字体的字符串
 */
@property (nonatomic, strong) NSString *fontSizeText;

/**
 *  字体大小
 *
 */
+ (UIFont *)fontOfSize:(float)font;

/**
 *  是否为夜间模式 - (NO 不是) - (YES 是)
 */
@property (nonatomic, assign) BOOL isNightMode;


@end
