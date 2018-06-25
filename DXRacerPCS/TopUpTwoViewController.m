//
//  TopUpTwoViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TopUpTwoViewController.h"
#import "LookPictureViewController.h"
#import "TopUPCenterTwoModel.h"
#import "TopUpCenterTwoCell.h"
#import "SearchTwoTableViewController.h"
@interface TopUpTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger page;
    NSInteger totalnum;
    float height1;
    float height2;
    float height3;
    float height4;
    float height5;
    
    UILabel *lab;
    UILabel *lab1;
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    
    NSString *str5;
    NSString *str6;
    NSString *str7;
    NSString *str8;
    
    NSString *biaozhi;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UISearchBar *searchbar;
@end

@implementation TopUpTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TopUpCenterTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, SCREEN_WIDTH-40, 30)];
    lab.textColor = RGBACOLOR(32, 157, 149, 1.0);
    lab.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab];
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 89, SCREEN_WIDTH, 1)];
    lab1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [view addSubview:lab1];
    
    [self setUpReflash];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topupsearchtwo:) name:@"topupsearchtwo" object:nil];
    
}
- (void)topupsearchtwo:(NSNotification *)text {
    biaozhi = @"biaozhi";
    
    str1 = [text.userInfo objectForKey:@"key1"];
    str2 = [text.userInfo objectForKey:@"key2"];
    str3 = [text.userInfo objectForKey:@"key3"];
    str4 = [text.userInfo objectForKey:@"key4"];
    str5 = [text.userInfo objectForKey:@"key5"];
    str6 = [text.userInfo objectForKey:@"key6"];
    str7 = [text.userInfo objectForKey:@"key7"];
    str8 = [text.userInfo objectForKey:@"key8"];
    if ([str4 isEqualToString:@"全部"]) {
        str4 = @" ";
    }
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



- (void)viewWillAppear:(BOOL)animated {
    [self lodMoney];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchTwoTableViewController *search = [[SearchTwoTableViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}


- (void)lodMoney{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"partner_topup_all", @"getAmount") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSNumber *number = [[dic objectForKey:@"rows"]objectForKey:@"totalamount"];
            NSString *str=[Manager jinegeshi:[NSString stringWithFormat:@"%@",number]];
            NSMutableAttributedString *notestr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"充值统计   %@",str]];
            NSRange ran1 = NSMakeRange(0, 7);
            [notestr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:ran1];
            [lab setAttributedText:notestr1];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 370+height1+height2+height3+height4+height5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopUpCenterTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TopUPCenterTwoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.btn1 setTitleColor:RGBACOLOR(32, 157, 149, 1.0) forState:UIControlStateNormal];
    [cell.btn2 setTitleColor:RGBACOLOR(32, 157, 149, 1.0) forState:UIControlStateNormal];
    
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag = indexPath.row;
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn2.tag = indexPath.row;
    
    
    cell.lab1.text = model.partner_name;
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height1 = size.height;
    cell.lab1height.constant = height1;
    
    
    cell.lab2.text = model.topuptype;
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
    CGSize size2 = [cell.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height3 = size2.height;
    cell.lab6height.constant = height3;
    
    cell.lab7.text = [Manager jinegeshi:model.amount];
    
    
    if ([model.status isEqualToString:@"B"]) {
        cell.lab8.text  = @"待审核";
        cell.lab8.textColor = [UIColor lightGrayColor];
    }
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab8.text  = @"审核通过";
        cell.lab8.textColor = [UIColor greenColor];
    }
    if ([model.status isEqualToString:@"N"]) {
        cell.lab8.text  = @"审核不通过";
        cell.lab8.textColor = [UIColor redColor];
    }
    
    cell.lab9.text  = model.create_note;
    cell.lab9.numberOfLines = 0;
    cell.lab9.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size3 = [cell.lab9 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height4 = size3.height;
    cell.lab9height.constant = height4;
    
    
    cell.lab10.text = [Manager timezhuanhuan:model.create_time];
    
    if (model.audit_user.length == 0) {
        cell.lab11.text = @"-";
    }else{
        cell.lab11.text = model.audit_user;
    }
    
    if (model.audit_time.length == 0){
        cell.lab12.text = @"-";
    }else{
        cell.lab12.text = [Manager timezhuanhuan:model.audit_time];
    }
    
    if (model.audit_note.length == 0){
        cell.lab13.text = @"-";
        height5 = 20;
    }else{
        cell.lab13.text = model.audit_note;
        cell.lab13.numberOfLines = 0;
        cell.lab13.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size4 = [cell.lab13 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height5 = size4.height;
        cell.lab13height.constant = height5;
    }
    
    
    
    cell.height1.constant = height1-10;
    cell.height2.constant = height2-10;
    cell.height3.constant = height3-10;
    cell.height4.constant = height4-10;
    return cell;
}
- (void)clickbtn1:(UIButton *)sender {
    //TopUpCenterOneCell *cell = (TopUpCenterOneCell *)[sender.superview superview];
    TopUPCenterTwoModel *model = [self.dataArray objectAtIndex:sender.tag];
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    lookpic.imgStr =  model.certificateurl;
    [self.navigationController pushViewController:lookpic animated:YES];
}
- (void)clickbtn2:(UIButton *)sender {
    TopUPCenterTwoModel *model = [self.dataArray objectAtIndex:sender.tag];
    LookPictureViewController *lookpic = [[LookPictureViewController alloc]init];
    NSLog(@"%@",model.collecturl);
    
    
    
    if (![[model.collecturl substringToIndex:4] isEqualToString:@"http"]) {
        lookpic.imgStr =  [NSString stringWithFormat:@"https:%@",model.collecturl];
    }else{
        lookpic.imgStr =  model.collecturl;
    }
    
    
    
    
//
    [self.navigationController pushViewController:lookpic animated:YES];
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
    if ([biaozhi isEqualToString:@"biaozhi"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                @"partner_name":str1,
                @"status":str2,
                @"topuptype":str3,
                @"paytype":str4,
                @"topup_start_time":str5,
                @"topup_end_time":str6,
                @"check_start_time":str7,
                @"check_end_time":str8,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                };
    }
    [session POST:KURLNSString(@"partner_topup_all", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                TopUPCenterTwoModel *model = [TopUPCenterTwoModel mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"登录失败！请检查登录信息是否正确" controller:weakSelf];
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
    if ([biaozhi isEqualToString:@"biaozhi"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                @"partner_name":str1,
                @"status":str2,
                @"paytype":str3,
                @"topuptype":str4,
                @"topup_start_time":str5,
                @"topup_end_time":str6,
                @"check_start_time":str7,
                @"check_end_time":str8,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                };
    }
    [session POST:KURLNSString(@"partner_topup_all", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                TopUPCenterTwoModel *model = [TopUPCenterTwoModel mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }            
        }else {
            [[Manager sharedManager] tishiyu:@"登录失败！请检查登录信息是否正确" controller:weakSelf];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}
















- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
