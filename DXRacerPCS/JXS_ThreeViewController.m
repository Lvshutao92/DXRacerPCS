//
//  JXS_ThreeViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_ThreeViewController.h"
#import "JXS_THREE_model.h"
#import "JXS_THREE_Cell.h"


#import "EditkaipiaoViewController.h"
#import "EditAddressViewController.h"
#import "AddrTableViewController.h"
@interface JXS_ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat height1;
    CGFloat height2;
    CGFloat height3;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation JXS_ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.tableview registerNib:[UINib nibWithNibName:@"JXS_THREE_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     JXS_THREE_model *model = [self.dataArray objectAtIndex:indexPath.row];
    AddrTableViewController *addr = [[AddrTableViewController alloc]init];
    addr.navigationItem.title = @"地址详情";
    addr.idstring = model.id;
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:addr animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200+height1+height2+height3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXS_THREE_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JXS_THREE_model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    if (model.company_name.length == 0 || [model.company_name isEqual:[NSNull null]]) {
        cell.lab1.text = @"-";
        cell.lab1.numberOfLines = 0;
        cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height1 = size.height;
        cell.height1.constant = height1;
        cell.top1.constant = size.height - 10;
    }else{
        cell.lab1.text = model.company_name;
        cell.lab1.numberOfLines = 0;
        cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height1 = size.height;
        cell.height1.constant = height1;
        cell.top1.constant = size.height - 10;
    }
    
    
    if (model.payer_code.length == 0 || [model.payer_code isEqual:[NSNull null]]){
        cell.lab2.text = @"-";
    }else{
        cell.lab2.text = model.payer_code;
    }
    
//    NSLog(@"%@\n",model.address);
    
    if (model.address.length == 0 || [model.address isEqual:[NSNull null]] || [model.address isEqualToString:@" "]) {
        cell.lab3.text = @"-";
        cell.lab3.numberOfLines = 0;
        cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height2 = size1.height;
        cell.height2.constant = height2;
        cell.top2.constant = size1.height - 10;
    }else{
        cell.lab3.text = model.address;
        cell.lab3.numberOfLines = 0;
        cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height2 = size1.height;
        cell.height2.constant = height2;
        cell.top2.constant = size1.height - 10;
    }
    
    
    if (model.phone_num.length == 0 || [model.phone_num isEqual:[NSNull null]]){
        cell.lab4.text = @"-";
    }else{
        cell.lab4.text = model.phone_num;
    }
   
    
    
    if (model.bank_name.length == 0 || [model.bank_name isEqual:[NSNull null]]) {
        cell.lab5.text = @"-";
        cell.lab5.numberOfLines = 0;
        cell.lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height3 = size2.height;
        cell.height3.constant = height3;
        cell.top3.constant = size2.height - 10;
    }else{
        cell.lab5.text = model.bank_name;
        cell.lab5.numberOfLines = 0;
        cell.lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-130, MAXFLOAT)];
        height3 = size2.height;
        cell.height3.constant = height3;
        cell.top3.constant = size2.height - 10;
    }
   
    
    if (model.bank_account.length == 0 || [model.bank_account isEqual:[NSNull null]]){
        cell.lab6.text = @"-";
    }else{
        cell.lab6.text = model.bank_account;
    }
    
    cell.lab7.text = model.partner_name;
//    cell.lab8.text = model.;
    
    return cell;
}
//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString(@"partner_invoice", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dicc in arr) {
            JXS_THREE_model *model = [JXS_THREE_model mj_objectWithKeyValues:dicc];
            [weakSelf.dataArray addObject:model];
        }
        
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
        }
        page=2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            };
    [session POST:KURLNSString(@"partner_invoice", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                JXS_THREE_model *model = [JXS_THREE_model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
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
    
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑开票信息" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JXS_THREE_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        EditkaipiaoViewController *kaipiao = [[EditkaipiaoViewController alloc]init];
        kaipiao.navigationItem.title = @"开票信息";
        kaipiao.idstring = model.id;
        kaipiao.str1 = model.partner_name;
        kaipiao.str2 = model.company_name;
        kaipiao.str3 = model.payer_code;
        kaipiao.str4 = model.address;
        kaipiao.str5 = model.phone_num;
        kaipiao.str6 = model.bank_name;
        kaipiao.str7 = model.bank_account;
        //取出根视图控制器
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        //取出当前选中的导航控制器
        UINavigationController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:kaipiao animated:YES];
    }];
    suer.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    
    
    
    UITableViewRowAction *xiaojia = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑收票地址" handler:^(UITableViewRowAction * _Nonnull xiaojia, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
       EditAddressViewController *shoupiao = [[EditAddressViewController alloc]init];
        shoupiao.navigationItem.title = @"收票地址";
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:shoupiao animated:YES];
        
    }];
    xiaojia.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    return @[suer];
}







- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
