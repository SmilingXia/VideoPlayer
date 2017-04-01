//
//  VCView.m
//  ZDYTabBar
//
//  Created by xia on 2017/3/10.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "VCView.h"

@interface VCView()

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, assign) CGFloat viewWidth;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *oneLable;

@property (nonatomic, strong) UILabel *twoLable;

@end

@implementation VCView

//- (id)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        _viewWidth = self.bounds.size.width;
//        _viewHeight = self.bounds.size.height;
//        self.layer.cornerRadius = _viewHeight*0.05;
//        [self loadSubView];
//    }
//    return self;
//}

- (id)init{
    self = [super init];
    if (self) {
//        _viewWidth = self.bounds.size.width;
//        _viewHeight = self.bounds.size.height;
//        self.layer.cornerRadius = _viewHeight*0.05;
//        [self loadSubView];
    }
    return self;
}

- (void)loadSubView{
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(_viewWidth*0.1, (_viewHeight -_viewWidth*0.2)/2, _viewWidth*0.2, _viewWidth*0.2);
    [self addSubview:_imageView];
    
    _oneLable = [[UILabel alloc] init];
    _oneLable.frame = CGRectMake(CGRectGetMaxX(_imageView.frame)+_viewWidth*0.1, (_viewHeight -_viewWidth*0.2)/2, _viewWidth*0.5, _viewWidth*0.2*0.6);
    _oneLable.textAlignment = NSTextAlignmentCenter;
    _oneLable.textColor = [UIColor whiteColor];
    _oneLable.lineBreakMode =NSLineBreakByCharWrapping;
    [self addSubview:_oneLable];
    
    _twoLable = [[UILabel alloc] init];
    _twoLable.frame = CGRectMake(CGRectGetMaxX(_imageView.frame)+_viewWidth*0.1, CGRectGetMaxY(_oneLable.frame)+_viewWidth*0.2*0.1, _viewWidth*0.5, _viewWidth*0.2*0.3);
    _twoLable.textAlignment = NSTextAlignmentCenter;
    _twoLable.textColor = [UIColor whiteColor];
    _twoLable.font = [UIFont systemFontOfSize:12.0f];
    _twoLable.lineBreakMode =NSLineBreakByCharWrapping;
    [self addSubview:_twoLable];
}


- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
}

- (void)setOneLableText:(NSString *)oneLableText{
    _oneLableText = oneLableText;
    _oneLable.text = oneLableText;
}

- (void)setTwoLableText:(NSString *)twoLableText{
    _twoLableText = twoLableText;
    _twoLable.text = twoLableText;
}

@end
