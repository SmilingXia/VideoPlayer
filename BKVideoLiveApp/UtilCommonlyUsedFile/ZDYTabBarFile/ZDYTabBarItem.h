//
//  ZDYTabBarItem.h
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"

@interface ZDYTabBarItem : UIView


/**
 *  标题
 */
@property (nonatomic, strong) NSString *titleLabtext;


/**
 *  设置选中背景图片与未选择的背景图片
 */
- (void)setImage:(UIImage *)image andSelect:(BOOL)select;


@end
