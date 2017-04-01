//
//  VCTableViewCell.m
//  ZDYTabBar
//
//  Created by xia on 2017/3/10.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#define leftMargin 15.0f

#define topMargin 10.0f
#define bottomMargin 10.0f

#define heigth 71.0f
#define rightButton_W 60.0f

#import "VCTableViewCell.h"
#import "XJFCommonmacro.h"
#import "PureLayout.h"

@interface VCTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *henXianView;

@end

@implementation VCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self loadSubView];
    }
    return self;
}


- (void)loadSubView{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:_titleLabel];
    
    _rightButton = [[UIButton alloc] init];
    _rightButton.layer.cornerRadius = 10.0f;
    _rightButton.layer.borderWidth = 0.5f;
    _rightButton.layer.borderColor = ZDYColor(0, 208, 187, 1.0).CGColor;
    [_rightButton setTitleColor:ZDYColor(0, 208, 187, 1.0) forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_rightButton];
    
    [_rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:leftMargin];
    [_rightButton autoSetDimension:ALDimensionWidth toSize:rightButton_W];
    [_rightButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [_rightButton autoSetDimension:ALDimensionHeight toSize:(heigth-20)/2];
    
    [_titleLabel autoSetDimension:ALDimensionHeight toSize:20];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:leftMargin];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topMargin];
    [_titleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_rightButton withOffset:-10.0f];
    
    
    _henXianView = [[UIView alloc] init];
    _henXianView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_henXianView];
    [_henXianView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(heigth-0.5,0,0,0)];
    
}

- (void)setVcModel:(VCModel *)vcModel{
    _vcModel = vcModel;
    
    _titleLabel.text = vcModel.title;
    if (vcModel.isFree) {
        [_rightButton setTitle:@"免费学习" forState:UIControlStateNormal];
    }else{
        [_rightButton setTitle:@"购买学习" forState:UIControlStateNormal];
    }
    for (int i = 1; i <= 5; i++) {
       UIImageView *numberView = [[UIImageView alloc] init];
        numberView.frame = CGRectMake(leftMargin+(i-1)*20, heigth/2, 20, 20);
        if (i > [vcModel.number intValue]) {
            numberView.image = [UIImage imageNamed:@"icon_normal"];
        }else{
            numberView.image = [UIImage imageNamed:@"icon_select"];
        }
        [self addSubview:numberView];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
