//
//  TopUpCenterOneViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TopUpCenterOneViewController.h"
#import "TopUpCenterOneCell.h"
#import "TopUpCenterOneModel.h"
#import "LookPictureViewController.h"
#import "ShenHeViewController.h"
#import "SearchOneTableViewController.h"

@interface TopUpCenterOneViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UISearchBarDelegate>
{
   NSInteger page;
   NSInteger totalnum;
    float height1;
    float height2;
    float height3;
    float height4;
    
    UIView *bgview;
    UIImageView *imgview;
    NSString *strid;
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    NSString *biaozhiya;
}

@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation TopUpCenterOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TopUpCenterOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    
    [self setUpReflash];
    
    [self setupvie];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topupsearchone:) name:@"topupsearchone" object:nil];
}
- (void)topupsearchone:(NSNotification *)text {
    biaozhiya = @"biaozhiya";
    str1 = [text.userInfo objectForKey:@"key1"];
    str2 = [text.userInfo objectForKey:@"key2"];
    str3 = [text.userInfo objectForKey:@"key3"];
    if ([str3 isEqualToString:@"全部"]) {
        str3 = @" ";
    }
    if ([str2 isEqualToString:@"全部"]) {
        str2 = @" ";
    }
    if ([str1 isEqualToString:@"全部"]) {
        str1 = @" ";
    }
    [self setUpReflash];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchOneTableViewController *search = [[SearchOneTableViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 310+height1+height2+height3+height4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopUpCenterOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TopUpCenterOneModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.btn1 setTitleColor:RGBACOLOR(32, 157, 149, 1.0) forState:UIControlStateNormal];
    [cell.btn2 setTitleColor:RGBACOLOR(32, 157, 149, 1.0) forState:UIControlStateNormal];
    
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag = indexPath.row;
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn2.tag = indexPath.row;
    
    cell.lab1.text = model.topuptype;
    
    cell.lab2.text = model.partner_name;
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height1 = size.height;
    cell.lab2height.constant = height1;
    
    cell.lab3.text = model.paytype;
    
    cell.lab4.text = model.payaccount;
    cell.lab4.numberOfLines = 0;
    cell.lab4.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size1 = [cell.lab4 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height2 = size1.height;
    cell.lab4height.constant = height2;
    
    
    cell.lab5.text = model.coltype;
    
    cell.lab6.text = model.colaccount;
    cell.lab6.numberOfLines = 0;
    cell.lab6.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size3 = [cell.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height3 = size3.height;
    cell.lab6height.constant = height3;
    
    cell.lab7.text = [Manager jinegeshi:model.amount];
    cell.lab8.text = [Manager digitUppercase:model.amount];
    
    cell.lab9.text  = model.create_note;
    cell.lab9.numberOfLines = 0;
    cell.lab9.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size4 = [cell.lab9 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height4 = size4.height;
    cell.lab9height.constant = height4;
    
    cell.lab10.text = [Manager timezhuanhuan:model.create_time];
    
    cell.heighttop1.constant = height1-10;
    cell.heighttop2.constant = height2-10;
    cell.heighttop3.constant = height3-10;
    cell.height4.constant = height4-10;
    
    if (model.collecturl.length == 0 || [model.collecturl isEqual:[NSNull null]]) {
        [cell.btn2 setTitle:@"未上传" forState:UIControlStateNormal];
    }else{
        [cell.btn2 setTitle:@"凭证预览" forState:UIControlStateNormal];
    }
    
    
    return cell;
}

- (void)clickbtn1:(UIButton *)sender {
    //TopUpCenterOneCell *cell = (TopUpCenterOneCell *)[sender.superview superview];
    TopUpCenterOneModel *model = [self.dataArray objectAtIndex:sender.tag];
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    lookpic.imgStr =  model.certificateurl;
    [self.navigationController pushViewController:lookpic animated:YES];
}
- (void)clickbtn2:(UIButton *)sender {
    TopUpCenterOneModel *model = [self.dataArray objectAtIndex:sender.tag];
    ;
    if (model.collecturl.length != 0 && ![model.collecturl isEqual:[NSNull null]]) {
        TopUpCenterOneModel *model = [self.dataArray objectAtIndex:sender.tag];
        LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
        lookpic.imgStr =  model.collecturl;
        [self.navigationController pushViewController:lookpic animated:YES];
    }
}


//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeDDList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLDDList];
        }
    }];
}

- (void)loddeDDList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if ([biaozhiya isEqualToString:@"biaozhiya"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                @"partner_name":str1,
                @"paytype":str2,
                @"topuptype":str3,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                };
    }
        [session POST:KURLNSString(@"partner_topup", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            totalnum = [[dic objectForKey:@"total"] integerValue];
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
                [weakSelf.dataArray removeAllObjects];
                for (NSDictionary *dicc in arr) {
                    TopUpCenterOneModel *model = [TopUpCenterOneModel mj_objectWithKeyValues:dicc];
                    [weakSelf.dataArray addObject:model];
                }
            }else {
                [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
            }
            page=2;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[Manager sharedManager] tishi:error controller:weakSelf];
            [weakSelf.tableview.mj_header endRefreshing];
        }];
}
- (void)loddeSLDDList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if ([biaozhiya isEqualToString:@"biaozhiya"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                @"partner_name":str1,
                @"paytype":str2,
                @"topuptype":str3,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                };
    }
    [session POST:KURLNSString(@"partner_topup", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                TopUpCenterOneModel *model = [TopUpCenterOneModel mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"审核" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        TopUpCenterOneModel *model = [self.dataArray objectAtIndex:indexPath.row];
        strid = model.id;
        if (model.collecturl.length == 0 || [model.collecturl isEqual:[NSNull null]]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请上传凭证，再进行审核" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                bgview.hidden = NO;
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            ShenHeViewController *shenhe = [[ShenHeViewController alloc]init];
            shenhe.navigationItem.title = @"审核";
            
            shenhe.idStr = model.id;
            
            shenhe.str1 = model.partner_name;
            shenhe.str2 = model.topuptype;
            shenhe.str3 = model.paytype;
            shenhe.str4 = model.payaccount;
            shenhe.str5 = model.colaccount;
            shenhe.str6 = model.amount;
            shenhe.str8 = model.create_note;
            shenhe.str7 = [Manager timezhuanhuan:model.create_time];
            
            [self.navigationController pushViewController:shenhe animated:YES];
        }
    }];
    suer.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    
    UITableViewRowAction *suer1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"上传收款凭证" handler:^(UITableViewRowAction * _Nonnull sure1, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        bgview.hidden = NO;
        TopUpCenterOneModel *model = [self.dataArray objectAtIndex:indexPath.row];
        strid = model.id;
    }];
    suer1.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    
    if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务收款专员"]){
        return @[suer1];
    }else if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务主管"]){
        return @[suer];
    }
     return @[suer1,suer];
}
- (void)setupvie {
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ckickhid:)];
    [bgview addGestureRecognizer:tap];
    bgview.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    
    
    UIView *botomview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-125, 100, 250, 270)];
    botomview.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:botomview];
    
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 200, 200)];
    imgview.image = [UIImage imageNamed:@"img"];
    imgview.contentMode = UIViewContentModeScaleAspectFit;
    imgview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ckickpicture:)];
    [imgview addGestureRecognizer:tapview];
    
    [botomview addSubview:imgview];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(40, 220, 65, 30);
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [botomview addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(145, 220, 70, 30);
    btn2.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicksave) forControlEvents:UIControlEventTouchUpInside];
    [botomview addSubview:btn2];
    
}
- (void)ckickpicture:(UITapGestureRecognizer *)sender{
    [self selectedImage];
}
- (void)ckickhid:(UITapGestureRecognizer *)sender {
    bgview.hidden = YES;
}
- (void)clickcancle {
    bgview.hidden = YES;
}
- (void)clicksave {
    if (strid.length != 0) {
        [self lodShangChuanPic];
    }
}

- (void)lodShangChuanPic{
    AFHTTPSessionManager *session = [Manager returnsession];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * fullPathToFile = [documentsDirectory stringByAppendingString:@"/pic.png"];
    UIImage * image =  [UIImage imageNamed:fullPathToFile];
    
    CGSize size = image.size;
    size.height = size.height/5;
    size.width  = size.width/5;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"user_id":[Manager redingwenjianming:@"user_id.text"],
            @"topup_id":strid,
            };
    [session POST:KURLNSString(@"colleurl", @"add") parameters:[Manager returndiction:dic] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data   =  UIImagePNGRepresentation(scaledImage);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"collecturl" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"上传成功😊" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                bgview.hidden = YES;
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
 
    
}

- (void)selectedImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionA setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionB setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionC setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [alert addAction:actionA];
    [alert addAction:actionB];
    [alert addAction:actionC];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
//从手机相册选取图片功能
- (void)pickerPictureFromAlbum {
    //1.创建图片选择器对象
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.allowsEditing = YES;
    imagepicker.delegate = self;
    [self presentViewController:imagepicker animated:YES completion:nil];
}
//拍照--照相机是否可用
- (void)pictureFromCamera {
    //照相机是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        //提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"摄像头不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;//如果不存在摄像头，直接返回即可，不需要做调用相机拍照的操作；
    }
    //创建图片选择器对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //设置图片选择器选择图片途径
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//从照相机拍照选取
    //设置拍照时下方工具栏显示样式
    imagePicker.allowsEditing = YES;
    //设置代理对象
    imagePicker.delegate = self;
    //最后模态退出照相机即可
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
//当得到选中的图片或视频时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagesave = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageOrientation imageOrientation = imagesave.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(imagesave.size);
        [imagesave drawInRect:CGRectMake(0, 0, imagesave.size.width, imagesave.size.height)];
        imagesave = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    imgview.image = imagesave;
    
    NSData * imageData = UIImagePNGRepresentation(imagesave);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * fullPathToFile = [documentsDirectory stringByAppendingString:@"/pic.png"];
    [imageData writeToFile:fullPathToFile atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
