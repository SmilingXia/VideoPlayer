//
//  PersonalInfoVC.m
//  BKVideoLiveApp
//
//  Created by xia on 2017/3/21.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "UpdataPersonalInfoVC.h"

@interface PersonalInfoVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataSourceArray;
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.centerTitleLable.text = @"账户信息";
    [self displayWidthLeftButton:NO andWidthRightButton:YES];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.naviGationBarView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (dataSourceArray) {
        return dataSourceArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataSourceArray) {
        NSArray *array = dataSourceArray[section];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *VC2TableViewCellIdentifier = @"VC2TableViewCellIdentifier";
    VC2TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[VC2TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:VC2TableViewCellIdentifier];
    }
    cell.vc2CellModel = dataSourceArray[indexPath.section][indexPath.row];
    [cell setLeftTextFont:17 andImageHeigth:30 andImageWidth:0];
    [cell setRightTextFont:17 andImageHeigth:30 andImageWidth:30];
    cell.rightLable.textAlignment = NSTextAlignmentRight;
    cell.leftLable.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VC2cellModel *lettText = dataSourceArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 2) {
            [ZDYUIAlertView jianDanAlertView:[NSString stringWithFormat:@"%@不能更改",lettText.leftLableText]];
        }
        else{
            UpdataPersonalInfoVC *updataPersonalInfo = [[UpdataPersonalInfoVC alloc]init];
            updataPersonalInfo.updataTitle = lettText.leftLableText;
            updataPersonalInfo.updataSource = lettText.rightLableText;
            [self presentViewController:updataPersonalInfo animated:YES completion:nil];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [ZDYUIAlertView jianDanAlertView:[NSString stringWithFormat:@"%@不能更改",lettText.leftLableText]];
        }
        else{
            UpdataPersonalInfoVC *updataPersonalInfo = [[UpdataPersonalInfoVC alloc]init];
            updataPersonalInfo.updataTitle = lettText.leftLableText;
            updataPersonalInfo.updataSource = lettText.rightLableText;
            [self presentViewController:updataPersonalInfo animated:YES completion:nil];
        }
    }
}


- (void)setDataSourceArray{
    dataSourceArray = [NSMutableArray array];
    oneArray = [NSMutableArray array];
    twoArray = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        VC2cellModel *one = [[VC2cellModel alloc]init];
        switch (i) {
            case 0:
                one.leftLableText = @"账户";
                one.rightLableText = _userInfoDataVO.tel;
                break;
            case 1:
                one.leftLableText = @"邮箱";
                one.rightLableText = _userInfoDataVO.email;
                break;
            case 2:
                one.leftLableText = @"手机";
                one.rightLableText = _userInfoDataVO.tel;
                break;
            case 3:
                one.leftLableText = @"QQ";
                one.rightLableText = _userInfoDataVO.qq;
                break;
        }
        [oneArray addObject:one];
    }
    [dataSourceArray addObject:oneArray];
    for (int i = 0; i < 2; i++) {
        VC2cellModel *two = [[VC2cellModel alloc]init];
        switch (i) {
            case 0:
                two.leftLableText = @"身份证号";
                two.rightLableText = _userInfoDataVO.idcard;
                break;
            case 1:
                two.leftLableText = @"收件地址";
                two.rightLableText = _userInfoDataVO.address;
                break;
        }
        [twoArray addObject:two];
    }
    [dataSourceArray addObject:twoArray];
    [self.tableView reloadData];
}


- (void)setUserInfoDataVO:(UserInfoDataVO *)userInfoDataVO{
    _userInfoDataVO = userInfoDataVO;
    [self setDataSourceArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
