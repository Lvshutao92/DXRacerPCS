//
//  Jiansuo_One_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/3.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Jiansuo_One_ViewController.h"
#import "BB_Search_OneViewController.h"
#import "BB_OneCell.h"
#import "BB_One_details_TableViewController.h"
#import "BBOneModel.h"
@interface Jiansuo_One_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger page;
    NSInteger totalnum;
    CGFloat height1;
    CGFloat height2;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation Jiansuo_One_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"BB_OneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = vie;
    
    [self setUpReflash];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BB_One_details_TableViewController *details = [[BB_One_details_TableViewController alloc]init];
    details.navigationItem.title = @"详情";
     BBOneModel *model = [self.dataArray objectAtIndex:indexPath.row];
    details.Order_id = model.id;
    [self.navigationController pushViewController:details animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200+height1+height2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BB_OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BBOneModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.order_no;
    
    cell.lab2.text = model.items;
    cell.lab2.font = [UIFont systemFontOfSize:16];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height1 = size.height;
    cell.height1.constant = height1;
    cell.jxstop.constant  = height1-10;
    
    cell.lab3.text = model.order_resource;
    cell.lab3.font = [UIFont systemFontOfSize:16];
    cell.lab3.numberOfLines = 0;
    cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size1 = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
    height2 = size1.height;
    cell.height2.constant = height2;
    cell.xsjtop.constant = height2-10;
    
    cell.lab4.text = [Manager jinegeshi:model.total_money];
    cell.lab5.text = [Manager jinegeshi:model.totalcostprice];
    cell.lab6.text = [Manager jinegeshi:model.seller_postage];
    cell.lab7.text = [Manager jinegeshi:model.lr];
    
    
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
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"order_no":self.order_no,
            @"order_resource":self.order_resource,
            @"sku_code":self.sku_code,
            
            @"starttime":self.starttime,
            @"endtime":self.endtime,
            
            @"jxs_order_status_str":self.jxs_order_status_str,
            @"express_order":self.express_order,
            @"lv":self.lv,
            @"is_return":self.is_return,
            @"is_refund":self.is_refund,
            };
//    NSLog(@"---%@",dic);
    [session POST:KURLNSString2(@"order", @"report", @"all", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                BBOneModel *model = [BBOneModel mj_objectWithKeyValues:dicc];
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
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"order_no":self.order_no,
            @"order_resource":self.order_resource,
            @"sku_code":self.sku_code,
            
            @"starttime":self.starttime,
            @"endtime":self.endtime,
            
            @"jxs_order_status_str":self.jxs_order_status_str,
            @"express_order":self.express_order,
            @"lv":self.lv,
            @"is_return":self.is_return,
            @"is_refund":self.is_refund,
            };
    [session POST:KURLNSString2(@"order", @"report", @"all", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                BBOneModel *model = [BBOneModel mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }        page++;
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
