//
//  ZDYVideoPlayerVC.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/29.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ZDYVideoPlayerVC.h"
#import "ZDYUISliderView.h"

@interface ZDYVideoPlayerVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *playerView;

@property (nonatomic, strong) AVAsset *avasset;

@property (nonatomic, strong) AVPlayerItem *avPlayerItem;

@property (nonatomic, strong) AVPlayer *avPlayer;

@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

//=====================================================================================

@property (nonatomic, assign) BOOL isHengShuPing;//yes竖屏 no横屏

//=====================================================================================

@property (nonatomic, strong) UIView *bottomView;                       //底部控件view

@property (nonatomic, strong) UIButton *zhanTinButton;                  //暂停按钮

@property (nonatomic, strong) UIButton *quanPinButton;                  //全屏按钮

@property (nonatomic, strong) UILabel *jinDuTimeLabel;                  //播放时间

@property (nonatomic, strong) UILabel *shengYuTimeLabel;                //剩余播放时间


@property (nonatomic, strong) ZDYUISliderView *huaKuaiUISlider;         //滑块变更播放进度

//@property (nonatomic, strong) UIProgressView *boFangProgressView;     //播放进度视图

@property (nonatomic, strong) UIProgressView *huanChunProgressView;     //缓存进度视图


//======================================================================================

@property (nonatomic, assign) BOOL isShowBottomView;                    //防止连续点击

@property (nonatomic, assign) PerformPanGestureType panType;            //手势事件类型

@property (nonatomic, assign) float shouShiJindu;                       //手势事件进度调整

@property (nonatomic, strong) UILabel *shouShiJinduLabel;               //手势事件进度label

//======================================================================================

@property (nonatomic, strong) UIImageView *brightnessView;              //亮度图标

@property (nonatomic, strong) UIProgressView *brightnessProgress;       //亮度进度

//=======================================================================================


@end

@implementation ZDYVideoPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerTitleLable.text = @"视频播放";
    self.isHengShuPing = YES;
    self.panType = PerformPanGestureNull;
    [self displayWidthLeftButton:NO andWidthRightButton:NO];
    [self loadSubView];
    [self subViewSetFrame];
    [self loadPlayer];
    [self showBottomView];
}

- (void)loadSubView{
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.zhanTinButton];
    [self.bottomView addSubview:self.quanPinButton];
    [self.bottomView addSubview:self.jinDuTimeLabel];
    [self.bottomView addSubview:self.shengYuTimeLabel];
    [self.bottomView addSubview:self.huanChunProgressView];
    //[self.bottomView addSubview:self.boFangProgressView];
    [self.bottomView addSubview:self.huaKuaiUISlider];
    
}

- (void)subViewSetFrame{
    //视频显示view;
    self.playerView.frame = CGRectMake(0, Bar_View_Heigth, SCREEN_W, SCREEN_W *(9.0/16.0));
    //添加手势
    for (int i = 0; i < RecognizerTypeCount; ++ i) {
        [self view:self.playerView addGestureRecognizer:i delegate:self];
    }
    
    //视频状态栏
    [self.bottomView autoSetDimension:ALDimensionHeight toSize:40];
    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.bottomView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.playerView withOffset:-40];
    
    //暂停/播放
    [self.zhanTinButton autoSetDimensionsToSize:CGSizeMake(30, 30)];
    [self.zhanTinButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.zhanTinButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //全屏按钮
    [self.quanPinButton autoSetDimensionsToSize:CGSizeMake(30, 30)];
    [self.quanPinButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.quanPinButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //进度Label
    [self.jinDuTimeLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
    [self.jinDuTimeLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.zhanTinButton withOffset:0];
    [self.jinDuTimeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //剩余进度Label
    [self.shengYuTimeLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
    [self.shengYuTimeLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.quanPinButton withOffset:0];
    [self.shengYuTimeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //缓存进度视图
    [self.huanChunProgressView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.jinDuTimeLabel withOffset:5];
    [self.huanChunProgressView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.shengYuTimeLabel withOffset:-5];
    [self.huanChunProgressView autoSetDimension:ALDimensionHeight toSize:4];
    [self.huanChunProgressView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
//    //播放进度视图
//    [self.boFangProgressView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.jinDuTimeLabel withOffset:5];
//    [self.boFangProgressView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.shengYuTimeLabel withOffset:-5];
//    [self.boFangProgressView autoSetDimension:ALDimensionHeight toSize:4];
//    [self.boFangProgressView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //滑块进度视图 self.huaKuaiUISlider
    [self.huaKuaiUISlider autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.jinDuTimeLabel withOffset:5];
    [self.huaKuaiUISlider autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.shengYuTimeLabel withOffset:-5];
    [self.huaKuaiUISlider autoSetDimension:ALDimensionHeight toSize:4];
    [self.huaKuaiUISlider autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
}

- (void)loadPlayer{
    //准备播放器 = AsynchronousKeyValueLoading -- 异步加载
    self.avasset = [AVAsset assetWithURL:self.urlPlayer];
    [MBProgressHUD showHUDAddedTo:self.playerView animated:YES];
    //异步加载视频
    [self asynchronousLoadingofVideo:self.avasset];
    self.avPlayerItem = [[AVPlayerItem alloc] initWithAsset:self.avasset];
    self.avPlayerItem.preferredPeakBitRate = 1000.0;//理论上是限制网速
    
    [self addObserverForCurrentPlayItem:self.avPlayerItem];
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:self.avPlayerItem];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    //设置每秒执行一次进度更新
    [self updateProgressEverySecond:self.avPlayer];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = CGRectMake(0, 0, SCREEN_W,SCREEN_W *(9.0/16.0));
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//视频填充模式
    [self.playerView.layer addSublayer:self.avPlayerLayer];
    
    //手势进度Label
    [self.playerView addSubview:self.shouShiJinduLabel];
    [self.shouShiJinduLabel autoSetDimensionsToSize:CGSizeMake(100, 40)];
    [self.shouShiJinduLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.shouShiJinduLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    //屏幕亮度
    [self.playerView addSubview:self.brightnessView];
    [self.brightnessView autoSetDimensionsToSize:CGSizeMake(125, 125)];
    [self.brightnessView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.brightnessView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
     //80, 10
    [self.brightnessView addSubview:self.brightnessProgress];
    [self.brightnessProgress autoSetDimensionsToSize:CGSizeMake(80, 2)];
    [self.brightnessProgress autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.brightnessProgress autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    
}

#pragma mark - 异步加载视频 -- 防止主线程堵塞
- (void)asynchronousLoadingofVideo:(AVAsset *)avAsset{
    
    NSArray *keys=@[@"availableMetadataFormats"];
    [avAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error=nil;
        AVKeyValueStatus state=[avAsset statusOfValueForKey:@"availableMetadataFormats" error:&error];
        switch (state) {
            case AVKeyValueStatusLoaded:
                NSLog(@"%@",@"加载成功");
                break;
            case AVKeyValueStatusFailed:
                NSLog(@"%@",@"加载失败");
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 设置每秒执行一次进度更新
- (void)updateProgressEverySecond:(AVPlayer *)avPlayer{
    
    WEAK_SELF;
    [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
        STRONG_SELF;
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([strongSelf.avPlayerItem duration]);
        if (current) {
            //进度
            int hh = (int)current / 3600;        //hh
            int mm = (int)(current / 60) % 60;   //mm
            int ss = (int)current % 60;          //ss
            if (hh < 1) {
                strongSelf.jinDuTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",mm, ss];
            }else{
                strongSelf.jinDuTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hh, mm, ss];
            }
            //剩余
            int syhh = (int)(total - current) / 3600;        //hh
            int symm = (int)((total - current) / 60) % 60;   //mm
            int syss = (int)(total - current) % 60;          //ss
            
            if (syhh < 1) {
                strongSelf.shengYuTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",symm, syss];
            }else{
                strongSelf.shengYuTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",syhh, symm, syss];
            }
    
            //strongSelf.boFangProgressView.progress = current / total;
            strongSelf.huaKuaiUISlider.value = current / total;
        }
    }];
}


#pragma mark - AVPlayerItem的KVO监听添加 -- 通知的添加 （方法）
- (void)addObserverForCurrentPlayItem:(AVPlayerItem*)currentPlayerItem
{
    //播放状态的监听
    [currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //缓冲进度监听
    [currentPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //指示播放是否消耗了所有缓冲媒体，播放将停止或结束
    [currentPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
//    [currentPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    
    //媒体没有及时到达继续播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlayBuffering)
                                                 name:AVPlayerItemPlaybackStalledNotification
                                               object:currentPlayerItem];

    //播放项目已经结束了
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlayFinished)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:currentPlayerItem];

    //项目未能到达最终时间
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlayFailed)
                                                 name:AVPlayerItemFailedToPlayToEndTimeNotification
                                               object:currentPlayerItem];
    
    //项目当前时间不连续地更改
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlayJumped)
                                                 name:AVPlayerItemTimeJumpedNotification
                                               object:currentPlayerItem];

    
    

//    [[AVAudioSession sharedInstance] setActive:YES error:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChanged:)
//                                                 name:AVAudioSessionRouteChangeNotification object:nil];
}

#pragma mark - 移除KVO监听
- (void)removeObserver:(AVPlayerItem*)currentPlayerItem{
    [currentPlayerItem removeObserver:self forKeyPath:@"status" context:nil];
    [currentPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [currentPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
//    [self.avPlayer removeObserver:self forKeyPath:@"timeControlStatus" context:nil];
//    [self.avPlayer removeObserver:self forKeyPath:@"reasonForWaitingToPlay" context:nil];
//    [self.avPlayer removeTimeObserver:self];
}


#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //播放器的状态
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *avPlayerItem = (AVPlayerItem *)object;
        if (avPlayerItem.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"可以播放的状态");
            [self.avPlayer play];
        }
        if (avPlayerItem.status == AVPlayerStatusFailed) {
            NSLog(@"失败状态");
            NSError *error = avPlayerItem.error;
            NSLog(@"失败原因%@",error);
        }
        if (avPlayerItem.status == AVPlayerStatusUnknown) {
            NSLog(@"未知状态");
        }
    }
    //缓冲的进度
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        AVPlayerItem *avPlayerItem = (AVPlayerItem *)object;
        NSLog(@"当前的缓存进度：%@",avPlayerItem.loadedTimeRanges);
        CMTimeRange timeRange = [avPlayerItem.loadedTimeRanges.firstObject CMTimeRangeValue];
        CMTime startTime = timeRange.start;         //时间范围的开始时间
        float startNumber = CMTimeGetSeconds(startTime);
        CMTime durationTime = timeRange.duration;   //开始到当前时间的差 -- 时间范围的持续时间
        float durationNumber = CMTimeGetSeconds(durationTime);
        if (durationNumber > 10) {
            [MBProgressHUD hideHUDForView:self.playerView animated:YES];
        }
        //刷新缓存进度
        float total = CMTimeGetSeconds([avPlayerItem duration]);
        self.huanChunProgressView.progress = (durationNumber + startNumber) / total;
    }
    //指示播放是否消耗了所有缓冲媒体，播放将停止或结束
    if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        AVPlayerItem *avPlayerItem = (AVPlayerItem *)object;
        if (avPlayerItem.playbackBufferEmpty) {
            [MBProgressHUD showHUDAddedTo:self.playerView animated:YES];
            NSLog(@"网络缓冲消耗完毕:状态为YES");
            //判断是否是断网情况
        }
    }
    
    //播放器视频播放状态 - 暂停、没有缓冲、调整进度监听
    if ([keyPath isEqualToString:@"timeControlStatus"]) {
        AVPlayer *avPlayer = (AVPlayer *)object;
        //暂停的时候
        if (avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
            NSLog(@"暂停");
        }
        //没有缓冲的时候
        if (avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
            NSLog(@"没有缓冲");
        }
        //调整进度的时候
        if (avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
            NSLog(@"调整进度");
        }
    }
    
    //
    if ([keyPath isEqualToString:@"reasonForWaitingToPlay"]) {
        AVPlayer *avPlayer = (AVPlayer *)object;
        //这个属性是可观察的关键值。
        //可能的值是AVPlayerWaitingWithNoItemToPlayReason，AVPlayerWaitingWhileEvaluatingBufferingRateReason和AVPlayerWaitingToMinimizeStallsReason。
        if ([avPlayer.reasonForWaitingToPlay isEqualToString:@"AVPlayerWaitingWithNoItemToPlayReason"]) {
            NSLog(@"播放器等待原因是：没有任何播放项目 ------------ 1");
        }
        if ([avPlayer.reasonForWaitingToPlay isEqualToString:@"AVPlayerWaitingWhileEvaluatingBufferingRateReason"]) {
            NSLog(@"播放器等待原因是：在评估缓冲率 ------------ 2");
        }
        if ([avPlayer.reasonForWaitingToPlay isEqualToString:@"AVPlayerWaitingToMinimizeStallsReason"]) {
            NSLog(@"播放器等待原因是：最小化 ------------ 3");
        }
    }
}

#pragma mark - 通知回调

- (void)onPlayBuffering{
    NSLog(@"媒体没有及时到达继续播放");
}

- (void)onPlayFinished{
    NSLog(@"播放结束");
    if (self.avPlayer.actionAtItemEnd == AVPlayerActionAtItemEndPause) {
        //1.改变暂停、开始播放按钮的状态
        self.zhanTinButton.selected = !self.zhanTinButton.selected;
        self.huaKuaiUISlider.value = 0;
    }
    //2.改变播放器的状态 - 暂停播放 - 或者 - 结束播放
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndPause;
}

- (void)onPlayFailed{
    NSLog(@"项目未能到达最终时间");
}

- (void)onPlayJumped{
     NSLog(@"项目当前时间不连续地更改");
}


#pragma mark - 基础控件的懒加载
- (UIView *)playerView{
    if (_playerView) {
        return _playerView;
    }
    _playerView = [[UIView alloc] init];
    _playerView.backgroundColor = [UIColor blackColor];
    return _playerView;
}

- (UIView *)bottomView{
    if (_bottomView) {
        return _bottomView;
    }
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = ZDYColor(128, 138, 135, 1);
    return _bottomView;
}

- (UIButton *)zhanTinButton{
    if (_zhanTinButton) {
        return _zhanTinButton;
    }
    _zhanTinButton = [[UIButton alloc] init];
    [_zhanTinButton setImage:[UIImage imageNamed:@"zhanting_icon"] forState:UIControlStateNormal];
    [_zhanTinButton setImage:[UIImage imageNamed:@"bofang_icon"] forState:UIControlStateSelected];
    [_zhanTinButton addTarget:self action:@selector(zhanTinButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    return _zhanTinButton;
}

- (UIButton *)quanPinButton{
    if (_quanPinButton) {
        return _quanPinButton;
    }
    _quanPinButton = [[UIButton alloc] init];
    [_quanPinButton setImage:[UIImage imageNamed:@"quanpin_icon"] forState:UIControlStateNormal];
    [_quanPinButton addTarget:self action:@selector(quanPinButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    return _quanPinButton;
}

- (UILabel *)jinDuTimeLabel{
    if (_jinDuTimeLabel) {
        return _jinDuTimeLabel;
    }
    _jinDuTimeLabel = [[UILabel alloc] init];
    _jinDuTimeLabel.textColor = [UIColor whiteColor];
    _jinDuTimeLabel.font = [UIFont systemFontOfSize:12];
    _jinDuTimeLabel.text = @"00:00";
    _jinDuTimeLabel.textAlignment = NSTextAlignmentRight;
    return _jinDuTimeLabel;
}

- (UILabel *)shengYuTimeLabel{
    if (_shengYuTimeLabel) {
        return _shengYuTimeLabel;
    }
    _shengYuTimeLabel = [[UILabel alloc] init];
    _shengYuTimeLabel.textColor = [UIColor whiteColor];
    _shengYuTimeLabel.font = [UIFont systemFontOfSize:12];
    _shengYuTimeLabel.text = @"00:00";
    _shengYuTimeLabel.textAlignment = NSTextAlignmentLeft;
    return _shengYuTimeLabel;
}

//- (UIProgressView *)boFangProgressView{
//    if (_boFangProgressView) {
//        return _boFangProgressView;
//    }
//    _boFangProgressView = [[UIProgressView alloc] init];
//    _boFangProgressView.progressTintColor = [UIColor blueColor];
//    _boFangProgressView.trackTintColor = [UIColor clearColor];
//    return _boFangProgressView;
//}

- (UIProgressView *)huanChunProgressView{
    if (_huanChunProgressView) {
        return _huanChunProgressView;
    }
    _huanChunProgressView = [[UIProgressView alloc] init];
    _huanChunProgressView.progressTintColor = ZDYColor(211, 211, 211, 1);
    _huanChunProgressView.trackTintColor = [UIColor whiteColor];
    return _huanChunProgressView;
}

- (UISlider *)huaKuaiUISlider{
    if (_huaKuaiUISlider) {
        return _huaKuaiUISlider;
    }
    //得到滑块的值属性 value
    _huaKuaiUISlider = [[ZDYUISliderView alloc] init];
    _huaKuaiUISlider.continuous = YES;                                  //设置滑块是否连续变化 yes变化
    _huaKuaiUISlider.minimumTrackTintColor = [UIColor blueColor];       //滑块左边的线条颜色
    _huaKuaiUISlider.maximumTrackTintColor = [UIColor clearColor];      //滑块右边的线条颜色
    _huaKuaiUISlider.thumbTintColor = [UIColor redColor];               //滑块的颜色
    [_huaKuaiUISlider addTarget:self action:@selector(huaKuaiUISliderOnclick:) forControlEvents:UIControlEventValueChanged];
    return _huaKuaiUISlider;
}

- (UILabel *)shouShiJinduLabel{
    if (_shouShiJinduLabel) {
        return _shouShiJinduLabel;
    }
    _shouShiJinduLabel = [[UILabel alloc] init];
    _shouShiJinduLabel.textColor = [UIColor whiteColor];
    _shouShiJinduLabel.textAlignment = NSTextAlignmentCenter;
    _shouShiJinduLabel.font = [UIFont systemFontOfSize:30];
    _shouShiJinduLabel.alpha = 0.0;
    return _shouShiJinduLabel;
}

- (UIImageView *)brightnessView{
    if (_brightnessView) {
        return _brightnessView;
    }
    _brightnessView = [[UIImageView alloc] init];
    _brightnessView.image = [UIImage imageNamed:@"video_brightness_bg.png"];
    _brightnessView.alpha = 0.0;
    return _brightnessView;
}

- (UIProgressView *)brightnessProgress{
    if (_brightnessProgress) {
        return _brightnessProgress;
    }
    _brightnessProgress = [[UIProgressView alloc] init];
    _brightnessProgress.trackImage = [UIImage imageNamed:@"video_num_bg.png"];
    _brightnessProgress.progressImage = [UIImage imageNamed:@"video_num_front.png"];
    _brightnessProgress.progress = [UIScreen mainScreen].brightness;
    [_brightnessView addSubview:_brightnessProgress];
    return _brightnessProgress;
}

- (void)setUrlPlayer:(NSURL *)urlPlayer{
    _urlPlayer = urlPlayer;
}



#pragma mark - 控件的基础事件
//暂停、播放按钮事件
- (void)zhanTinButtonOnclick:(UIButton *)sender{
    self.zhanTinButton.selected = !self.zhanTinButton.selected;
    //情况 1.如果是播放完成后点击的 --- 重头播放isCarryOut
    if (self.avPlayer.actionAtItemEnd == AVPlayerActionAtItemEndPause) {
        self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        [self.avPlayer seekToTime:kCMTimeZero];
    }
    if (self.zhanTinButton.selected) {
        [self.avPlayer pause];
    }else{
        [self.avPlayer play];
    }
}

//全屏按钮事件
- (void)quanPinButtonOnclick:(UIButton *)sender{
    self.quanPinButton.selected = !self.quanPinButton.selected;
    if (self.quanPinButton.selected) {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((objc_objectptr_t)UIInterfaceOrientationLandscapeRight)];
        }
    }else{
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((objc_objectptr_t)UIInterfaceOrientationPortrait)];
        }
    }
    
    
//    self.quanPinButton.selected = !self.quanPinButton.selected;
//    if (self.quanPinButton.selected) {
//        NSLog(@"全屏了");
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
//        self.view.transform = transform;
//        self.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
//        self.naviGationBarView.alpha = 0.0;
//        self.playerView.frame = CGRectMake(0, 0, SCREEN_H, SCREEN_W);
//        self.avPlayerLayer.frame = CGRectMake(0, 0, SCREEN_H,SCREEN_W);
//    }else{
//        NSLog(@"退出全屏");
//        self.view.transform  = CGAffineTransformIdentity;
//        self.view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
//        self.naviGationBarView.alpha = 1.0;
//        self.playerView.frame = CGRectMake(0, Bar_View_Heigth, SCREEN_W, SCREEN_W *(9.0/16.0));
//        self.avPlayerLayer.frame = CGRectMake(0, 0, SCREEN_W,SCREEN_W *(9.0/16.0));
//    }
}

//滑块进度改变
- (void)huaKuaiUISliderOnclick:(UISlider *)sender{
    NSLog(@"当前滑块的进度为：%f",sender.value);
    if (sender.value == 1) {
        float total = CMTimeGetSeconds([self.avPlayerItem duration]) * sender.value;
        CMTime fiveSecondsIn = CMTimeMake(total - 10, 1);
        [self.avPlayerItem seekToTime:fiveSecondsIn toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }else{
        float total = CMTimeGetSeconds([self.avPlayerItem duration]) * sender.value;
        CMTime fiveSecondsIn = CMTimeMake(total, 1);
        [self.avPlayerItem seekToTime:fiveSecondsIn toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}


#pragma mark - 播放器view的手势事件 -- 与手势需要执行的方法
//执行方法 -- 透明度
- (void)showBottomView{
    self.bottomView.alpha = 1.0;
    //延迟加载
    if (!self.isShowBottomView) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0/*延迟加载的时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.alpha = 0.0;
                self.isShowBottomView = NO;
            }];
        });
    }
}

//音量控制
- (void)uploadVolume:(CGFloat)step addAndsubtraction:(BOOL)isAdd{
    if (isAdd) {
        [MPMusicPlayerController applicationMusicPlayer].volume += step;
    }else{
        [MPMusicPlayerController applicationMusicPlayer].volume -= step;
    }
}

//系统亮度控制
- (void)brightness:(CGFloat)step addAndsubtraction:(BOOL)isAdd{
    if (isAdd) {
        [UIScreen mainScreen].brightness += step;
    }else{
        [UIScreen mainScreen].brightness -= step;
    }
    self.brightnessProgress.progress = [UIScreen mainScreen].brightness;
}

//各种手势
- (void)performTapGesture:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"点击显示BottomView");
    //防止重复连续点击 - isShowBottomView
    [self showBottomView];
    self.isShowBottomView = YES;
}

- (void)performPanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint qiDianPoint = [gestureRecognizer locationOfTouch:0 inView:self.playerView];
        NSLog(@"起点位置为：(%f,%f)",qiDianPoint.x,qiDianPoint.y);
        if (qiDianPoint.x >= SCREEN_W/3*2 && qiDianPoint.x < SCREEN_W) {
            //滑动改变音量
            self.panType = PerformPanGestureYingLiang;
        }
        if (qiDianPoint.x >= SCREEN_W/3 && qiDianPoint.x < SCREEN_W/3*2) {
            //滑动改变进度
            self.panType = PerformPanGestureJinDu;
        }
        if (qiDianPoint.x >= 0 && qiDianPoint.x < SCREEN_W/3) {
            //改变亮度
            self.panType = PerformPanGestureLiangDu;
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat moveX = [gestureRecognizer translationInView:self.playerView].x;
        CGFloat moveY = [gestureRecognizer translationInView:self.playerView].y;
        if (self.panType == PerformPanGestureYingLiang) {
            NSLog(@"音量 =======：%f",moveY);
            if (moveY > 0) {
                NSLog(@"音量减 --------- 音量减");
                [self uploadVolume:moveY/6/(SCREEN_W *(9.0/16.0)) addAndsubtraction:NO];
            }
            if (moveY < 0) {
                NSLog(@"音量加 --------- 音量加");
                [self uploadVolume:-moveY/6/(SCREEN_W *(9.0/16.0)) addAndsubtraction:YES];
            }
        }
        if (self.panType == PerformPanGestureJinDu) {
            NSLog(@"进度 =======：%f",moveX);
            self.shouShiJinduLabel.alpha = 1.0;
            if (moveX > 0) {
                NSLog(@"进度加 --------- 进度加");
                self.shouShiJindu = moveX/3;
                self.shouShiJinduLabel.text = [NSString stringWithFormat:@"+%d s",(int)self.shouShiJindu];
            }
            if (moveX < 0) {
                NSLog(@"进度减 --------- 进度减");
                self.shouShiJindu = moveX/3;
                self.shouShiJinduLabel.text = [NSString stringWithFormat:@"%d s",(int)self.shouShiJindu];
            }
        }
        if (self.panType == PerformPanGestureLiangDu) {
            NSLog(@"亮度 =======：%f",moveY);
            if (moveY > 0) {
                NSLog(@"亮度减 --------- 亮度减");
                //brightnessAdd
                self.brightnessView.alpha = 1.0;
                [self brightness:moveY/6/(SCREEN_W *(9.0/16.0)) addAndsubtraction:NO];
            }
            if (moveY < 0) {
                NSLog(@"亮度加 --------- 亮度加");
                self.brightnessView.alpha = 1.0;
                [self brightness:-moveY/6/(SCREEN_W *(9.0/16.0)) addAndsubtraction:YES];
            }
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.panType == PerformPanGestureJinDu) {
            //当前播放进度时间加当前的 == self.shouShiJindu
            self.shouShiJinduLabel.alpha = 0.0;
            float total = CMTimeGetSeconds([self.avPlayerItem duration]) * self.huaKuaiUISlider.value;
            CMTime fiveSecondsIn = CMTimeMake(total + self.shouShiJindu, 1);
            [self.avPlayerItem seekToTime:fiveSecondsIn toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        }
        if (self.panType == PerformPanGestureLiangDu) {
            self.brightnessView.alpha = 0.0;
        }
    }
}



#pragma mark - 手势添加
- (void)view:(UIView *)view addGestureRecognizer:(NSInteger)type
    delegate:(id<UIGestureRecognizerDelegate>)delegate
{
    UIGestureRecognizer *recognizer = nil;
    SEL action = nil;
    switch (type) {
        case TapGestureRecognizer:
            action = @selector(performTapGesture:);
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTapsRequired = 1;
            break;

        case PanGestureRecognizer:
            action = @selector(performPanGesture:);
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
            break;
            
//        case LongPressGestureRecognizer:
//            action = @selector(performLongPressGesture:);
//            recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
//            break;
//        
//        case PinchGestureRecognizer:
//            action = @selector(performPinchGesture:);
//            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
//            break;
//        case RotationGestureRecognizer:
//            action = @selector(performRotationSwipeGesture:);
//            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:action];
//            break;
//        case SwipeGestureRecognizer:
//            action = @selector(performSwipeGesture:);
//            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
//            break;
//        
//        default:
//            return;
    }
    recognizer.delegate = delegate;
    [view addGestureRecognizer:recognizer];
}


#pragma mark - 重写返回事件
- (void)leftButtonOnclick:(UIButton *)sender{
    //取消监听  - AVPlayerItem的监听
    [self.avPlayer pause];
    [self removeObserver:self.avPlayerItem];
    self.avasset = nil;
    self.avPlayerItem = nil;
    self.avPlayer = nil;
    [self.avPlayerLayer removeFromSuperlayer];
    //取消通知 -- 默认的匿名通知不移除
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 屏幕旋转 -- 按钮实现方法---必须实现的方法
- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        // 横屏
        [self hengPing];
    }
    else{
        //竖屏
        [self shuPing];
    }
}

//强制横屏 UIInterfaceOrientationLandscapeRight -- 强制竖屏 UIInterfaceOrientationPortrait
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        [self hengPing];
    }
    if (orientation == UIInterfaceOrientationPortrait) {
        [self shuPing];
    }
    return orientation;
}

//横屏,竖屏调用修改布局
- (void)hengPing{
    self.naviGationBarView.alpha = 0.0;
    self.quanPinButton.selected = YES;
    self.playerView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.avPlayerLayer.frame = CGRectMake(0, 0, SCREEN_W,SCREEN_H);
}
- (void)shuPing{
    self.naviGationBarView.alpha = 1.0;
    self.quanPinButton.selected = NO;
    self.playerView.frame = CGRectMake(0, Bar_View_Heigth, SCREEN_W, SCREEN_W *(9.0/16.0));
    self.avPlayerLayer.frame = CGRectMake(0, 0, SCREEN_W,SCREEN_W *(9.0/16.0));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
