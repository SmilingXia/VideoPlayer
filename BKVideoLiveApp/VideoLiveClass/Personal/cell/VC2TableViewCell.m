//
//  VC2TableViewCell.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/20.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "VC2TableViewCell.h"

@interface VC2TableViewCell()

@end

@implementation VC2TableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self loadSubView];
    }
    return self;
}


- (void)loadSubView{
    _leftImageView = [[UIImageView alloc] init];
    _leftLable = [[UILabel alloc] init];
    _rightImageView = [[UIImageView alloc] init];
    _rightLable = [[UILabel alloc] init];
    _bottomView = [[UIView alloc] init];
    
    [self addSubview:_leftImageView];
    [self addSubview:_leftLable];
    [self addSubview:_rightImageView];
    [self addSubview:_rightLable];
    [self addSubview:_bottomView];
    
    
    [_bottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_bottomView autoSetDimension:ALDimensionHeight toSize:0.5];
    _bottomView.backgroundColor = [UIColor darkGrayColor];
}

- (void)setLeftTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth{
    _leftLable.font = [UIFont systemFontOfSize:textFont];
    [_leftImageView autoSetDimensionsToSize:CGSizeMake(imageWidth, imageHeigth)];
    
    [_leftImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [_leftImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_leftLable autoSetDimension:ALDimensionHeight toSize:imageHeigth];
    [_leftLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_leftImageView withOffset:15.0];
    [_leftLable autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:0.3];
    [_leftLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)setRightTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth{
    
    _rightLable.font = [UIFont systemFontOfSize:textFont];
    [_rightImageView autoSetDimensionsToSize:CGSizeMake(imageWidth, imageHeigth)];
    
    [_rightImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [_rightImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_rightLable autoSetDimension:ALDimensionHeight toSize:imageHeigth];
    [_rightLable autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_rightImageView withOffset:15.0];
    [_rightLable autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:0.3];
    [_rightLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
}


- (void)setVc2CellModel:(VC2cellModel *)vc2CellModel{
    _vc2CellModel = vc2CellModel;
    [_leftImageView setImage:[UIImage imageNamed:_vc2CellModel.leftImageText]];
    [_leftLable setText:_vc2CellModel.leftLableText];
    [_rightLable setText:_vc2CellModel.rightLableText];
    [_rightImageView setImage:[UIImage imageNamed:_vc2CellModel.rightImageText]];
}

- (void)loadUserImageButonWithLeftTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth{
    _userImageButton = [[UIButton alloc] init];
    [self addSubview:_userImageButton];
    _leftLable.font = [UIFont systemFontOfSize:textFont];
    [_userImageButton autoSetDimensionsToSize:CGSizeMake(imageWidth, imageHeigth)];
    [_userImageButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [_userImageButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_leftLable autoSetDimension:ALDimensionHeight toSize:imageHeigth];
    [_leftLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_userImageButton withOffset:15.0];
    [_leftLable autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:0.3];
    [_leftLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
