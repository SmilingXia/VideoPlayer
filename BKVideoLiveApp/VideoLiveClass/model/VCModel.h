//
//  VCModel.h
//  ZDYTabBar
//
//  Created by xia on 2017/3/10.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCModel : NSObject

/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;

/**
 *  能力指数
 */
@property (nonatomic, strong) NSString *number;

/**
 *  是否免费
 */
@property (nonatomic, assign) BOOL isFree;

@end
