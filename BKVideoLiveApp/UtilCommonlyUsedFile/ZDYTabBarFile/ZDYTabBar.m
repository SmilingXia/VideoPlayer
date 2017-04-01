//
//  ZDYTabBar.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYTabBar.h"
#import "ZDYTabBarItem.h"
#import "XJFCommonmacro.h"

@interface ZDYTabBar()<UIGestureRecognizerDelegate>{
    NSArray *tabBarItemTitle;
    NSArray *tabBarItemImages;
}

@property (nonatomic, strong) ZDYTabBarItem *tabBarItem;

@end

@implementation ZDYTabBar

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setItemsInfoArray:(NSArray *)itemsInfoArray{
    
    //顶部横线一根
    UIView *henxian = [[UIView alloc] init];
    [self addSubview:henxian];
    henxian.backgroundColor = [UIColor darkGrayColor];
    [henxian autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [henxian autoSetDimension:ALDimensionHeight toSize:0.5];
    
    _itemsInfoArray = itemsInfoArray;
    tabBarItemTitle = [_itemsInfoArray objectAtIndex:0];
    tabBarItemImages = [_itemsInfoArray objectAtIndex:1];
    
    //自适应
    NSMutableArray *array = [NSMutableArray new];
    
    for (int index = 0; index < tabBarItemTitle.count; index++) {
        ZDYTabBarItem *barItem = [[ZDYTabBarItem alloc] init];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_height@2x",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal@2x",[tabBarItemImages objectAtIndex:index]]];
        barItem.tag = index + 1000;
        [self addSubview:barItem];
        
        [barItem autoSetDimension:ALDimensionHeight toSize:TabBar_H - 0.5];
        [barItem autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        //保存添加的控件 - 自适应
        [array addObject:barItem];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnclick:)];
        tap.delegate = self;
        [barItem addGestureRecognizer:tap];
        
        if (index == 0) {
            [barItem setImage:selectedimage andSelect:YES];
            _tabBarItem = barItem;
        }else{
            [barItem setImage:unselectedimage andSelect:NO];
        }
        [barItem setTitleLabtext:[tabBarItemTitle objectAtIndex:index]];
    }
    [array autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0 insetSpacing:YES matchedSizes:YES];
}

- (void)tapOnclick:(UITapGestureRecognizer *)tap{
    ZDYTabBarItem *barItem = (ZDYTabBarItem *)tap.view;
    if (barItem.tag != self.tabBarItem.tag) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_height@2x",[tabBarItemImages objectAtIndex:barItem.tag - 1000]]];
        [barItem setImage:selectedimage andSelect:YES];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal@2x",[tabBarItemImages objectAtIndex:_tabBarItem.tag - 1000]]];
        [_tabBarItem setImage:unselectedimage andSelect:NO];
        
        [_tabBarDelegate fromIndex:(int)self.tabBarItem.tag - 1000 toIndex:(int)barItem.tag - 1000];
    }
    _tabBarItem = barItem;
}

- (void)setTabBarDelegate:(id<ZDYTabBarDelegate>)tabBarDelegate{
    _tabBarDelegate = tabBarDelegate;
    if ([_tabBarDelegate respondsToSelector:@selector(fromIndex:toIndex:)]) {
        [_tabBarDelegate fromIndex:0 toIndex:0];
    }
}

@end
