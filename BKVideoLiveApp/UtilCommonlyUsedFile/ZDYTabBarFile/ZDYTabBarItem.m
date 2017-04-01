//
//  ZDYTabBarItem.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYTabBarItem.h"

@interface ZDYTabBarItem()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab;


@end

@implementation ZDYTabBarItem

- (id)init{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_titleLab];
    }
    return self;
}



- (void)setTitleLabtext:(NSString *)titleLabtext{
    _titleLabtext = titleLabtext;
    _titleLab.text = titleLabtext;
    
    [_titleLab autoSetDimension:ALDimensionHeight toSize:20.0f];
    [_titleLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:0];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
}

- (void)setImage:(UIImage *)image andSelect:(BOOL)select{
    _imageView.image = image;
    
    [_imageView autoSetDimensionsToSize:CGSizeMake(30, 30)];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    if (select) {
        _titleLab.textColor = [UIColor blueColor];
    }else{
        _titleLab.textColor = [UIColor darkGrayColor];
    }
}


@end
