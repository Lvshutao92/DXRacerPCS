//
//  TopUpCenterThreeViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TopUpCenterThreeViewController.h"
#import "AllPanter_nameModel.h"
#import "TopUpCenterThreeModel.h"
#import "TopUpCenterThreeCell.h"

@interface TopUpCenterThreeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger page;
    NSInteger totalnum;
   
    
    NSString *partnername;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)UITextField *textfield;
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@end

@implementation TopUpCenterThreeViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TopUpCenterThreeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    vie.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    self.tableview.tableHeaderView = vie;

    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 40)];
    [self.textfield.layer setBorderWidth:0];
    self.textfield.delegate = self;
    self.textfield.text = @"全部";
     partnername = @" ";
    [self.textfield.layer setBorderColor:[UIColor colorWithWhite:.8 alpha:.4].CGColor];
    [vie addSubview:self.textfield];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(1, 50, SCREEN_WIDTH-2, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableview addSubview:self.tableview1];
    [self.tableview bringSubviewToFront:self.tableview1];
    
    
    [self lodjinxiaoshang];
    [self setUpReflash];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.textfield.text = self.dataArray1[indexPath.row];
        partnername = self.dataArray1[indexPath.row];
        if ([self.dataArray1[indexPath.row] isEqualToString:@"全部"]) {
            partnername = @" ";
        }
        [self setUpReflash];
    }
    self.tableview1.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 275;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//        cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
        cell.textLabel.text = self.dataArray1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    TopUpCenterThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TopUpCenterThreeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.partner_name;
    cell.lab2.text = [Manager jinegeshi:model.mymoney];
    cell.lab3.text = [Manager jinegeshi:model.change_money];
    cell.lab4.text = [Manager jinegeshi:model.old_money];
    
    cell.lab5.text = @"-";
    cell.lab6.text = [Manager timezhuanhuan:model.create_time];
    cell.lab7.text = model.opreat_type;
    
    
    
    if (model.note.length == 0 || [model.note isEqual:[NSNull null]]) {
        cell.lab8.text = @"-";
    }else{
        cell.lab8.text = model.note;
    }
    
    
    return cell;
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
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"partner_name":partnername,
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString(@"partner_money_log", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                TopUpCenterThreeModel *model = [TopUpCenterThreeModel mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        page=2;
        [weakSelf.tableview reloadData];
        weakSelf.tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_header endRefreshing];
        weakSelf.tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }];
}
- (void)loddeSLDDList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"partner_name":partnername,
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString(@"partner_money_log", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                TopUpCenterThreeModel *model = [TopUpCenterThreeModel mj_objectWithKeyValues:dicc];
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



- (void)lodjinxiaoshang{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"partner_topup", @"innitPartners") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"partnerList"];
            [weakSelf.dataArray1 removeAllObjects];
            for (NSDictionary *dic in arr) {
                AllPanter_nameModel *model = [AllPanter_nameModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArray1 addObject:model.partner_name];
            }
            [weakSelf.dataArray1 insertObject:@"全部" atIndex:0];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.tableview1.hidden == NO) {
        self.tableview1.hidden = YES;
    }else {
        self.tableview1.hidden = NO;
    }
    return NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textfield resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
@end
