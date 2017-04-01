//
//  VCView.h
//  ZDYTabBar
//
//  Created by xia on 2017/3/10.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCView : UIView

@property (nonatomic, strong) UIImage *image;

/**
 *  大标题（中文）
 */
@property (nonatomic, strong) NSString *oneLableText;

/**
 *  小标题（英文）
 */
@property (nonatomic, strong) NSString *twoLableText;

@end
