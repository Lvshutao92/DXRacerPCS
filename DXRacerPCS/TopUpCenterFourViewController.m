//
//  TopUpCenterFourViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/17.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TopUpCenterFourViewController.h"
#import "TopUpCenterFourModel.h"
#import "TopUpCenterFourCell.h"
#import "AccountViewController.h"
#import "SGTopScrollMenu.h"
@interface TopUpCenterFourViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger totalnum;
    
    float height1;
    float height2;
    float height3;
    float height4;
    //    UIButton *btn;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic, strong)SGTopScrollMenu *scr;
@end

@implementation TopUpCenterFourViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.view.frame.size.height - 64 - 40 -50-0, self.view.frame.size.width, 50);
    btn.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn setTitle:@"新增" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TopUpCenterFourCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    self.view.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:btn];
    [self setUpReflash];
}

- (void)clickadd {
    
    AccountViewController *account = [[AccountViewController alloc]init];
    account.navigationItem.title = @"新增";
    
    [self.navigationController pushViewController:account animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160+height1+height2+height3+height4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopUpCenterFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TopUpCenterFourModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.type;
    
    if (model.back_name.length == 0 || [model.back_name isEqual:[NSNull null]]) {
        cell.lab2.text = @"-";
        height1 = 20;
    }else {
        cell.lab2.text = model.back_name;
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-115, MAXFLOAT)];
        height1 = size.height;
        cell.lab2height.constant = height1;
        cell.height1.constant = height1 - 10;
    }
    
    if (model.remark1.length == 0 || [model.remark1 isEqual:[NSNull null]]) {
        cell.lab3.text = @"-";
        height2 = 20;
    }else {
        cell.lab3.text = model.remark1;
        cell.lab3.numberOfLines = 0;
        cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-115, MAXFLOAT)];
        height2 = size.height;
        cell.lab3height.constant = height2;
        cell.height2.constant = height2 - 10;
    }
    
    cell.lab4.text = model.colaccount;
    cell.lab4.numberOfLines = 0;
    cell.lab4.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab4 sizeThatFits:CGSizeMake(SCREEN_WIDTH-115, MAXFLOAT)];
    height3 = size.height;
    cell.lab4height.constant = height3;
    cell.height3.constant = height3 - 10;
    
    
    if (model.companyname.length == 0) {
        cell.lab5.text = @"-";
        height4 = 20;
    }else{
        cell.lab5.text = model.companyname;
        cell.lab5.numberOfLines = 0;
        cell.lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [cell.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-115, MAXFLOAT)];
        height4 = size1.height;
        cell.lab5height.constant = height4;
        cell.height4.constant = height4 - 10;
    }
    
    
    
    
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab6.text = @"已启用";
    }
    if ([model.status isEqualToString:@"N"]) {
        cell.lab6.text = @"已禁用";
    }
    cell.lab7.text = [Manager timezhuanhuan:model.createtime];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        AccountViewController *account = [[AccountViewController alloc]init];
        account.navigationItem.title = @"编辑";
        TopUpCenterFourModel *model = [self.dataArray objectAtIndex:indexPath.row];
        account.str1 = model.type;
        
        account.str2 = model.remark1;
        account.str3 = model.back_name;
        
        account.str4 = model.colaccount;
        account.str5 = model.companyname;
        account.idstr = model.id;
        [self.navigationController pushViewController:account animated:YES];
    }];
    suer.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    
    UITableViewRowAction *suer1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull sure1, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        TopUpCenterFourModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if (model.id.length != 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除？" message:@"删除成功，则无法找回" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self lodDelete:model.id];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    suer1.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    
    UITableViewRowAction *suer2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"状态" handler:^(UITableViewRowAction * _Nonnull sure2, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        TopUpCenterFourModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if (model.id.length != 0){
            [self lodEditStatus:model.id];
        }
    }];
    suer2.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    return @[suer1,suer,suer2];
}

- (void)lodDelete:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"id":str,
            };
    [session POST:KURLNSString(@"collaccount", @"delete") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"删除----%@",[dic objectForKey:@"result_msg"]);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"请下拉刷新列表" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else {
            [[Manager sharedManager] tishiyu:[dic objectForKey:@"result_msg"] controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}
- (void)lodEditStatus:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"id":str,
            };
    [session POST:KURLNSString(@"collaccount", @"updateStatus") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功修改状态" message:@"请下拉刷新列表" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else {
            [[Manager sharedManager] tishiyu:[dic objectForKey:@"result_msg"] controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
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
            };
    [session POST:KURLNSString(@"collaccount", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                TopUpCenterFourModel *model = [TopUpCenterFourModel mj_objectWithKeyValues:dicc];
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
            };
    [session POST:KURLNSString(@"collaccount", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                TopUpCenterFourModel *model = [TopUpCenterFourModel mj_objectWithKeyValues:dicc];
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













- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
