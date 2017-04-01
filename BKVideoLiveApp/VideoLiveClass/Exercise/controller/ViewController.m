//
//  ViewController.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/24.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ViewController.h"
#import "XJFCommonmacro.h"
#import "PureLayout.h"
#import "VCModel.h"
#import "VCTableViewCell.h"
#import "VCView.h"
#import "ZDYVideoPlayerVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSourceMutableArray;

@property (nonatomic, strong) UITableView *tabView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) VCView *footerLeftView;
@property (nonatomic, strong) VCView *footerRightView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加入UINavigationController后防止子控件下偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.centerTitleLable.text = @"练习";
    [self displayWidthLeftButton:YES andWidthRightButton:YES];
    
    self.dataSource = @[@"yi",@"er"];
    self.tabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tabView.rowHeight = 71.0f;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabView.backgroundColor = ZDYColor(248, 248, 250, 1);
    [self.view addSubview:self.tabView];
    [self.tabView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.tabView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.naviGationBarView];
    
    
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    
//    _footerView = [[UIView alloc] init];
//    _footerView.backgroundColor = ZDYColor(248, 248, 250, 1);
//    self.tabView.tableFooterView = _footerView;
//    _footerView.frame = CGRectMake(0, 0, self.tabView.bounds.size.width, SCREEN_H*0.2);
//    
//    _footerLeftView = [[VCView alloc] init];
//    _footerLeftView.backgroundColor = ZDYColor(255, 83, 33, 1.0);
//    [_footerView addSubview:_footerLeftView];
//    _footerLeftView.image = [UIImage imageNamed:@"leftImage_bai"];
//    _footerLeftView.oneLableText = @"模拟测试";
//    _footerLeftView.twoLableText = @"SIMULATION";
//    
//    _footerRightView = [[VCView alloc] init];
//    _footerRightView.backgroundColor = ZDYColor(0, 154, 233, 1.0);
//    [_footerView addSubview:_footerRightView];
//    _footerRightView.image = [UIImage imageNamed:@"rightImage_bai"];
//    _footerRightView.oneLableText = @"考前押题";
//    _footerRightView.twoLableText = @"EXAMS";
//    

//    [_footerLeftView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15.0f];
//    [_footerLeftView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15.0f];
//    [_footerLeftView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_footerView withOffset:10.0f];
//    [_footerLeftView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_footerRightView withOffset:-10.0f];
//    
//    [_footerRightView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:_footerView withOffset:-10.0f];
//    [_footerRightView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_footerLeftView];
//    [_footerRightView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_footerLeftView];
//    [_footerRightView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_footerLeftView];
//    

//    NSArray *colorViews = @[_footerLeftView, _footerRightView];
//    [colorViews autoSetViewsDimension:ALDimensionHeight toSize:SCREEN_H*0.2 - 30];
//    [colorViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:15.0f insetSpacing:YES matchedSizes:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceMutableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *VCTableViewCellIdentifier = @"VCTableViewCellIdentifier";
    VCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[VCTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:VCTableViewCellIdentifier];
    }
    cell.vcModel = [_dataSourceMutableArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //观看视频
        ZDYVideoPlayerVC *videoPlayer = [[ZDYVideoPlayerVC alloc] init];
        NSString *urlStr = @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/c95ec0ef5135480f844e3f3fed34e68b/2016-%E4%BC%9A%E8%AE%A1%E4%BB%8E%E4%B8%9A%E8%B5%84%E6%A0%BC%E8%80%83%E8%AF%95-%E8%B4%A2%E7%BB%8F%E6%B3%95%E8%A7%84%E4%B8%8E%E4%BC%9A%E8%AE%A1%E8%81%8C%E4%B8%9A%E9%81%93%E5%BE%B7-%E5%85%AC%E5%BC%80%E8%AF%BE2-%E7%AC%AC%E4%B8%80%E7%AB%A0%E6%B3%95%E5%BE%8B%E6%A6%82%E5%BF%B5%E8%80%83%E7%82%B9%E8%AF%A6%E8%A7%A3.mp4";
        //判断当前的url是否有中文
        NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlStr,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
        NSURL *url = [NSURL URLWithString:encodedString];
        videoPlayer.urlPlayer = url;
        [self presentViewController:videoPlayer animated:YES completion:nil];
    }
}



- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    _dataSourceMutableArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        VCModel *vcm = [[VCModel alloc] init];
        switch (i) {
            case 0:
                vcm.title = @"第1部分 ：《模拟试卷》";
                vcm.number = @"2";
                vcm.isFree = YES;
                break;
            case 1:
                vcm.title = @"第2部分 ：《会计基础》";
                vcm.number = @"1";
                vcm.isFree = YES;
                break;
            case 2:
                vcm.title = @"第3部分 ：《会计基础试卷》";
                vcm.number = @"4";
                vcm.isFree = YES;
                break;
            case 3:
                vcm.title = @"第4部分 ：《会计电算化》";
                vcm.number = @"3";
                vcm.isFree = NO;
                break;
            case 4:
                vcm.title = @"第5部分 ：《会计电算化试卷》";
                vcm.number = @"0";
                vcm.isFree = YES;
                break;
            case 5:
                vcm.title = @"第6部分 ：《财经》";
                vcm.number = @"1";
                vcm.isFree = YES;
                break;
            case 6:
                vcm.title = @"第7部分 ：《财经试卷》";
                vcm.number = @"5";
                vcm.isFree = NO;
                break;
            case 7:
                vcm.title = @"第8部分 ：《护士》";
                vcm.number = @"4";
                vcm.isFree = YES;
                break;
            case 8:
                vcm.title = @"第9部分 ：《护士试卷》";
                vcm.number = @"4";
                vcm.isFree = NO;
                break;
            case 9:
                vcm.title = @"第10部分 ：《医疗试卷》";
                vcm.number = @"3";
                vcm.isFree = NO;
                break;
        }
        [_dataSourceMutableArray addObject:vcm];
    }
    [self.tabView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
