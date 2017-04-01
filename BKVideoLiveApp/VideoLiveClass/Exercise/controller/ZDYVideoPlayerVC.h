//
//  ZDYVideoPlayerVC.h
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/29.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYMainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZDYVideoPlayerVC : ZDYMainViewController

typedef enum{
    TapGestureRecognizer = 0,
    PanGestureRecognizer,
    RecognizerTypeCount
}RecognizerType;

typedef enum{
    PerformPanGestureYingLiang = 0,
    PerformPanGestureJinDu,
    PerformPanGestureLiangDu,
    PerformPanGestureNull
}PerformPanGestureType;

/**
 *  视频播放地址 - URL
 */
@property (nonatomic, strong) NSURL *urlPlayer;

@end
