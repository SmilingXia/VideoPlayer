//
//  ViewController2.m
//  ZDYTabBar
//
//  Created by xia on 2017/2/27.
//  Copyright © 2017年 cn.bkw. All rights reserved.
//

#import "ViewController2.h"
#import "ZDYDateStorageDanli.h"
#import "XJFCommonmacro.h"
#import "VC2TableViewCell.h"
#import "VC2cellModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PersonalInfoVC.h"
#import "UserInfoDataVO.h"


@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *cellDataSourceArray;
    NSMutableArray *twoCellDataSourceArray;
    NSMutableArray *threeCellDataSourceArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *userImageButton;

@property (nonatomic, strong) ZDYNetworkRequest *userInfoDataRequest;
@property (nonatomic, strong) UserInfoDataVO *userInfoDataVO;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    //加入UINavigationController后防止子控件下偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self displayWidthLeftButton:YES andWidthRightButton:YES];
    self.centerTitleLable.text = @"个人";
    [self getUserInfoData];
    [self setDataSourceArrayValue];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.naviGationBarView];
}


- (void)getUserInfoData{
    NSMutableDictionary *mudict = [NSMutableDictionary dictionary];
    [mudict setObject:[ZDYDateStorageDanli initialization].sessionid forKey:@"sessionid"];
    [mudict setObject:[ZDYDateStorageDanli initialization].uid forKey:@"uid"];
    
    self.userInfoDataRequest = [[ZDYNetworkRequest alloc] init];
    [MBProgressHUD showHUD];
    self.userInfoDataRequest.requestTag = ZDYNetworkRequestUserInfoData;
    self.userInfoDataRequest.parameter = mudict;
    WEAK_SELF;
    self.userInfoDataRequest.returnSuccessData = ^(NSDictionary *dict){
        STRONG_SELF;
        [MBProgressHUD dissmiss];
        NSLog(@"请求成功后数据为：%@",dict);
        UserInfoDataVO *userInfoDataVO = [[UserInfoDataVO alloc] initWithDictionary:dict error:nil];
        [ZDYDateStorageDanli initialization].userInfoDataVO = userInfoDataVO;
        strongSelf.userInfoDataVO = userInfoDataVO;
    };
}


#pragma mark - UItableview的代理实现

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 4;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *VC2TableViewCellIdentifier = @"VC2TableViewCellIdentifier";
    VC2TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[VC2TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:VC2TableViewCellIdentifier];
    }
    if (indexPath.section == 0) {
        
        if ([ZDYDateStorageDanli initialization].loginUserInfo.nickname == nil) {
            cell.leftLable.text = [ZDYDateStorageDanli initialization].loginUserInfo.username;
        }else{
            cell.leftLable.text = [ZDYDateStorageDanli initialization].loginUserInfo.nickname;
        }
        [cell loadUserImageButonWithLeftTextFont:23 andImageHeigth:80 andImageWidth:80];
        cell.userImageButton.layer.cornerRadius = 40.0f;
        cell.userImageButton.layer.masksToBounds = YES;
        cell.userImageButton.layer.borderWidth = 1.0f;
        cell.userImageButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [cell.userImageButton addTarget:self action:@selector(userImageButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableDictionary *dataDictionary= (NSMutableDictionary *)[BKArchive unarchiveDataWithFileName:User_TouXiang_Image];
        if (dataDictionary == nil ||
            [dataDictionary objectForKey:[ZDYDateStorageDanli initialization].loginUserInfo.username] == nil){
            [cell.userImageButton setImage:[UIImage imageNamed:@"touxiang_default_icon@2x"] forState:UIControlStateNormal];
        }else{
            UIImage *smallImage = (UIImage *)[dataDictionary objectForKey:[ZDYDateStorageDanli initialization].loginUserInfo.username];
            [cell.userImageButton setImage:smallImage forState:UIControlStateNormal];
        }
        self.userImageButton = cell.userImageButton;
        return cell;
    }else{
        cell.vc2CellModel = cellDataSourceArray[indexPath.section - 1][indexPath.row];
        [cell setLeftTextFont:17 andImageHeigth:30 andImageWidth:30];
        [cell setRightTextFont:17 andImageHeigth:30 andImageWidth:30];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            PersonalInfoVC *personalVC = [[PersonalInfoVC alloc] init];
            personalVC.userInfoDataVO = self.userInfoDataVO;
            [self presentViewController:personalVC animated:YES completion:nil];
        }
    }
    else{
        
    }
}


#pragma mark - actionSheet创建一个弹窗，进行选择相册与相机
- (void)userImageButtonOnclick:(UIButton *)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择文件来源"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"本地相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}


#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = [%ld]",(long)buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
    }
}


#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        //NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        //self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    NSMutableDictionary *dataDictionary= (NSMutableDictionary *)[BKArchive unarchiveDataWithFileName:User_TouXiang_Image];
    dataDictionary = nil;
    dataDictionary = [[NSMutableDictionary alloc] init];
    [dataDictionary setObject:image forKey:[ZDYDateStorageDanli initialization].loginUserInfo.username];
    //写入数据到plist文件
    [BKArchive archiveData:dataDictionary withFileName:User_TouXiang_Image];
    [self.userImageButton setImage:image forState:UIControlStateNormal];
}


- (void)setDataSourceArrayValue{
    cellDataSourceArray = [NSMutableArray array];
    twoCellDataSourceArray = [NSMutableArray array];
    threeCellDataSourceArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        VC2cellModel *two = [[VC2cellModel alloc]init];
        switch (i) {
            case 0:
                two.leftImageText = @"userInfo_icon";
                two.leftLableText = @"个人信息";
                two.rightLableText = @"";
                two.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 1:
                two.leftImageText = @"guankanjilu_icon";
                two.leftLableText = @"观看记录";
                two.rightLableText = @"";
                two.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 2:
                two.leftImageText = @"wodekecheng_icon";
                two.leftLableText = @"我的课程";
                two.rightLableText = @"";
                two.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 3:
                two.leftImageText = @"wodexiaoxi_icon";
                two.leftLableText = @"我的消息";
                two.rightLableText = @"";
                two.rightImageText = @"cellRightLable_Image@2x";
                break;
                
        }
        [twoCellDataSourceArray addObject:two];
    }
    
    for (int i = 0; i < 4; i++) {
        VC2cellModel *three = [[VC2cellModel alloc]init];
        switch (i) {
            case 0:
                three.leftImageText = @"xiugaimima_icon";
                three.leftLableText = @"修改密码";
                three.rightLableText = @"";
                three.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 1:
                three.leftImageText = @"ruanjiangengxin_icon";
                three.leftLableText = @"软件更新";
                three.rightLableText = @"";
                three.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 2:
                three.leftImageText = @"xitongshezhi_icon";
                three.leftLableText = @"系统设置";
                three.rightLableText = @"";
                three.rightImageText = @"cellRightLable_Image@2x";
                break;
            case 3:
                three.leftImageText = @"tuichuzhanghao_icon";
                three.leftLableText = @"退出账号";
                three.rightLableText = @"";
                three.rightImageText = @"cellRightLable_Image@2x";
                break;
        }
        [threeCellDataSourceArray addObject:three];
    }
    [cellDataSourceArray addObject:twoCellDataSourceArray];
    [cellDataSourceArray addObject:threeCellDataSourceArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
