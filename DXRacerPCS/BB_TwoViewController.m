//
//  BB_TwoViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BB_TwoViewController.h"
#import "BB_Search_TwoViewController.h"
#import "BB_TwoCell.h"
#import "BBTwoModel.h"
@interface BB_TwoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate>
{
    NSInteger page;
    NSInteger totalnum;

}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UISearchBar *searchbar;
@property(nonatomic, strong)NSMutableArray *arr;

@end

@implementation BB_TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [NSMutableArray arrayWithCapacity:1];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-108)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"BB_TwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = vie;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    
    [self lod];
}
- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"partner_topup", @"innitPartners") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (weakSelf.arr.count != 0) {
            [weakSelf.arr removeAllObjects];
        }
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"partnerList"];
            for (NSDictionary *dic in arr) {
                NSString *str = [dic objectForKey:@"partner_name"];
                [weakSelf.arr addObject:str];
            }
            [Manager sharedManager].arr = weakSelf.arr;
            if (weakSelf.arr.count != 0) {
                [weakSelf setUpReflasharray:weakSelf.arr];
            }            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BB_TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BBTwoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.skucode;
    cell.lab2.text = model.amount;
    cell.lab3.text = [Manager jinegeshi:model.costprice];
    
    cell.lab4.text = [Manager jinegeshi:[NSString stringWithFormat:@"%d",[model.amount integerValue]*[model.costprice integerValue]]];
    return cell;
}

//刷新数据
-(void)setUpReflasharray:(NSMutableArray *)arr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeDDList:currentTimeString array:arr];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLDDList:currentTimeString array:arr];
        }
    }];
    
}

- (void)loddeDDList:(NSString *)str array:(NSMutableArray *)arr{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"starttime":str,
            @"jxs_order_status":@"E",
            @"is_return":@"N",
            @"order_resource_str":arr,
            };
    [session POST:KURLNSString1(@"order", @"report", @"getGoodsMoneyList") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];

        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dicc in arr) {
            BBTwoModel *model = [BBTwoModel mj_objectWithKeyValues:dicc];
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
- (void)loddeSLDDList:(NSString *)str array:(NSMutableArray *)arr{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"starttime":str,
            @"jxs_order_status":@"E",
            @"is_return":@"N",
            @"order_resource_str":arr,
            };
    [session POST:KURLNSString1(@"order", @"report", @"getGoodsMoneyList") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dicc in arr) {
            BBTwoModel *model = [BBTwoModel mj_objectWithKeyValues:dicc];
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


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    BB_Search_TwoViewController *search = [[BB_Search_TwoViewController alloc]init];
    search.navigationItem.title = @"检索";
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}









- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
