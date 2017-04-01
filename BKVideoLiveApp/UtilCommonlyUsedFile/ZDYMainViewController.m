//
//  ZDYMainViewController.m
//  LXJichengAndDuotaiAndFengzhuang
//
//  Created by xia on 2017/3/14.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYMainViewController.h"

@interface ZDYMainViewController ()

@end

@implementation ZDYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateThemeStyle:) name:ZDY_YJMS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateThemeFontSize:) name:ZDY_FONT_SIZE object:nil];
    [self loadBarItem];
    [self setSubleViewBackgroundColor];
    [self setTextFont];
}

- (void)setSubleViewBackgroundColor{
    
    self.view.backgroundColor = [ZDYThemeStyleClass viewBackgroundColor];
    self.naviGationBarView.backgroundColor = [ZDYThemeStyleClass navigationBarBackgroundColor];
    self.centerTitleLable.textColor = [ZDYThemeStyleClass navigationBarItemTableTextColor];
    [_rightButton setTitleColor:[ZDYThemeStyleClass buttonTitleColor] forState:UIControlStateNormal];
    [_leftButton setTitleColor:[ZDYThemeStyleClass buttonTitleColor] forState:UIControlStateNormal];
}

- (void)setTextFont{
    _centerTitleLable.font = [ZDYThemeStyleClass fontOfSize:17.0f];
    _leftButton.titleLabel.font = [ZDYThemeStyleClass fontOfSize:17.0f];
    _rightButton.titleLabel.font =  [ZDYThemeStyleClass fontOfSize:17.0f];
}

- (void)loadBarItem{
    
    self.naviGationBarView = [[UIView alloc] init];
    [self.view addSubview:self.naviGationBarView];
    [self.naviGationBarView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.naviGationBarView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.naviGationBarView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.naviGationBarView autoSetDimension:ALDimensionHeight toSize:Bar_View_Heigth];
    
    [self.naviGationBarView addSubview:self.leftButton];
    [self.naviGationBarView addSubview:self.rightButton];
    [self.naviGationBarView addSubview:self.centerTitleLable];
    
    [self.leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0f];
    [self.rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0f];
    [@[self.leftButton,self.rightButton] autoSetViewsDimensionsToSize:CGSizeMake(Bar_View_Heigth, 30.0f)];
    [self.leftButton autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [self.rightButton autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    
    [self.centerTitleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.centerTitleLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.centerTitleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.leftButton withOffset:1.0f];
    [self.centerTitleLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.rightButton withOffset:1.0f];
}

- (UILabel *)centerTitleLable{
    if (_centerTitleLable) {
        return _centerTitleLable;
    }
    _centerTitleLable = [[UILabel alloc] init];
    _centerTitleLable.textAlignment = NSTextAlignmentCenter;
    return _centerTitleLable;
}

-(UIButton *)leftButton{
    if (_leftButton) {
        return _leftButton;
    }
    _leftButton = [[UIButton alloc] init];
    [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    return _leftButton;
}

-(UIButton *)rightButton{
    if (_rightButton) {
        return _rightButton;
    }
    _rightButton = [[UIButton alloc] init];
    [_rightButton setTitle:@"" forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    return _rightButton;
}

- (void)leftButtonOnclick:(UIButton *)sender{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)displayWidthLeftButton:(BOOL)isDisplayLeftButton andWidthRightButton:(BOOL)isDisplayRightButton{
    self.leftButton.hidden = isDisplayLeftButton;
    self.rightButton.hidden = isDisplayRightButton;
}

- (void)rightButtonOnclick:(UIButton *)sender{
}


#pragma mark - 接受通知
- (void)updateThemeStyle:(NSNotification *)sender{
    [self setSubleViewBackgroundColor];
}

- (void)updateThemeFontSize:(NSNotification *)sender{
    [self setTextFont];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//关闭状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
