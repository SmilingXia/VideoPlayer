//
//  VC2cellModel.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/20.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VC2cellModel : NSObject

/**
 *  左边lab
 */
@property (nonatomic, strong) NSString *leftLableText;

/**
 *  左边图片名称
 */
@property (nonatomic, strong) NSString *leftImageText;


/**
 *  右边lab
 */
@property (nonatomic, strong) NSString *rightLableText;

/**
 *  右边图片名称
 */
@property (nonatomic, strong) NSString *rightImageText;

@end
