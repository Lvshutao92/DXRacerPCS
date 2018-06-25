//
//  AddrTableViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AddrTableViewController.h"
#import "AddrTableViewCell.h"
#import "Address_model.h"
#import "EditAddressViewController.h"
@interface AddrTableViewController ()
{
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation AddrTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddrTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    
    [self setUpReflash];
}


//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableView.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"invoice_id":self.idstring,
            @"page":[NSString stringWithFormat:@"%ld",(long)page]
            };
    [session POST:KURLNSString(@"partner_address", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                Address_model *model = [Address_model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
        }
        page=2;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableView.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"invoice_id":self.idstring,
            @"page":[NSString stringWithFormat:@"%ld",(long)page]
            };
    [session POST:KURLNSString(@"partner_address", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                Address_model *model = [Address_model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
        }
        page++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}






#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Address_model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.receiver_name;
    cell.lab2.text = model.receiver_state;
    cell.lab3.text = model.receiver_city;
    cell.lab4.text = model.receiver_district;
    cell.lab5.text = model.receiver_address;
    cell.lab6.text = model.receiver_mobile;
    cell.lab7.text = model.receiver_phone;
    return cell;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *xiaojia = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑收票地址" handler:^(UITableViewRowAction * _Nonnull xiaojia, NSIndexPath * _Nonnull indexPath) {
        self.tableView.editing = NO;
        
        EditAddressViewController *shoupiao = [[EditAddressViewController alloc]init];
        shoupiao.navigationItem.title = @"收票地址";
        
        
        Address_model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        shoupiao.idstring = self.idstring;
        
        shoupiao.str1 = model.receiver_name;
        shoupiao.str2 = model.receiver_state;
        shoupiao.str3 = model.receiver_city;
        shoupiao.str4 = model.receiver_district;
        shoupiao.str5 = model.receiver_address;
        shoupiao.str6 = model.receiver_mobile;
        shoupiao.str7 = model.receiver_phone;
        
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:shoupiao animated:YES];
    }];
    xiaojia.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    return @[xiaojia];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
