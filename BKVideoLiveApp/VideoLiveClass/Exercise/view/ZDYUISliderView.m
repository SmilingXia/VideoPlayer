//
//  ZDYUISliderView.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/31.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYUISliderView.h"

@implementation ZDYUISliderView


- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, 0, bounds.size.width, 4);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    //y轴方向改变手势范围
    rect.origin.y = rect.origin.y - 25;
    rect.size.height = rect.size.height + 50;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 ,10);
}


@end
