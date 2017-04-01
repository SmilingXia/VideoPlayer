//
//  VCTableViewCell.h
//  ZDYTabBar
//
//  Created by xia on 2017/3/10.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCModel.h"

@interface VCTableViewCell : UITableViewCell

/**
 *  数据模型
 */
@property (nonatomic, strong) VCModel *vcModel;

@end
