//
//  VC2TableViewCell.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/20.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "VC2cellModel.h"

@interface VC2TableViewCell : UITableViewCell

/**
 *  用户的头像按钮
 */
@property (nonatomic, strong) UIButton *userImageButton;

/**
 *  左边图片
 */
@property (nonatomic, strong) UIImageView *leftImageView;

/**
 *  左边lab
 */
@property (nonatomic, strong) UILabel *leftLable;


/**
 *  右边lab
 */
@property (nonatomic, strong) UILabel *rightLable;

/**
 *  右边图片
 */
@property (nonatomic, strong) UIImageView *rightImageView;


/**
 *  底部横线
 */
@property (nonatomic, strong) UIView *bottomView;

/**
 *  cell的数据源
 */
@property (nonatomic, strong) VC2cellModel *vc2CellModel;


/**
 *  加载用户的头像按钮 --  左边的字体大小， 左边image图片的宽高
 */
- (void)loadUserImageButonWithLeftTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth;

/**
 *  左边的字体大小， 左边image图片的宽高
 */
- (void)setLeftTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth;

/**
 *  左边的字体大小， 左边image图片的宽高
 */
- (void)setRightTextFont:(float)textFont andImageHeigth:(float)imageHeigth andImageWidth:(float)imageWidth;


@end
