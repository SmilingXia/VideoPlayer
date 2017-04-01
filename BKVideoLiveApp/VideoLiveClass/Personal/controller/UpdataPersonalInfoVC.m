//
//  UpdataPersonalInfoVC.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/22.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "UpdataPersonalInfoVC.h"

@interface UpdataPersonalInfoVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *editTextField;

@end

@implementation UpdataPersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayWidthLeftButton:NO andWidthRightButton:NO];
    [self loadSubView];
}

- (void)loadSubView{
    [self.view addSubview:self.editTextField];
    UIView *henxian = [[UIView alloc] init];
    [self.view addSubview:henxian];
    
    [_editTextField autoSetDimensionsToSize:CGSizeMake(300, 50)];
    [_editTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.naviGationBarView withOffset:50];
    [_editTextField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    henxian.backgroundColor = [UIColor darkGrayColor];
    [henxian autoSetDimensionsToSize:CGSizeMake(300, 0.5)];
    [henxian autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_editTextField];
    [henxian autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
}

- (UITextField *)editTextField{
    if (_editTextField) {
        return _editTextField;
    }
    _editTextField = [[UITextField alloc] init];
    _editTextField.delegate = self;
    _editTextField.layer.borderColor = [UIColor clearColor].CGColor;
    _editTextField.placeholder = _updataSource;
    return _editTextField;
}

- (void)rightButtonOnclick:(UIButton *)sender{
    //保存修改的数据
}


- (void)setUpdataTitle:(NSString *)updataTitle{
    _updataTitle = updataTitle;
    self.centerTitleLable.text = [NSString stringWithFormat:@"编辑%@",updataTitle];
}

- (void)setUpdataSource:(NSString *)updataSource{
    _updataSource = updataSource;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_editTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
