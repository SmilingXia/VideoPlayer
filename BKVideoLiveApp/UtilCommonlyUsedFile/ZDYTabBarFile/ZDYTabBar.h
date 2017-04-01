//
//  ZDYTabBar.h
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "Masonry.h"

@protocol ZDYTabBarDelegate <NSObject>

- (void)fromIndex:(int)fromIndex toIndex:(int)toIndex;

@end


@interface ZDYTabBar : UIView

@property (nonatomic, weak) id<ZDYTabBarDelegate> tabBarDelegate;

/**
 * 导航栏上显示的项目信息。
 */
@property (nonatomic, strong) NSArray *itemsInfoArray;

@end
