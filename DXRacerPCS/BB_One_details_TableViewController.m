//
//  BB_One_details_TableViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BB_One_details_TableViewController.h"
#import "Details1_Cell.h"
#import "Details2_Cell.h"
#import "Details3_Cell.h"
#import "Details4_Cell.h"
#import "Details1_Model.h"
#import "Details2_Model.h"
#import "Details3_Model.h"
#import "Details4_Model.h"

@interface BB_One_details_TableViewController ()
{
    CGFloat height1;
}
@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *arr4;

@end

@implementation BB_One_details_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"Details1_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Details2_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Details3_Cell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Details4_Cell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    [self loddetails];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr1.count;
    }if (section == 1) {
        return self.arr2.count;
    }if (section == 2) {
        return self.arr3.count;
    }
    return self.arr4.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }if (indexPath.section == 1) {
        return 330+height1;
    }if (indexPath.section == 2) {
        return 290;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Details1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Details1_Model *model = [self.arr1 objectAtIndex:indexPath.row];
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:NSString(model.imgurl)]];
        cell.imageview.contentMode = UIViewContentModeScaleAspectFit;
        cell.lab1.text = [NSString stringWithFormat:@"ITEMNO:%@",model.skucode];
        cell.lab2.text = [NSString stringWithFormat:@"供货价:%@",[Manager jinegeshi:model.price]];
        cell.lab3.text = [NSString stringWithFormat:@"数量:%@",model.quantity];
        cell.lab4.text = [NSString stringWithFormat:@"小计:%@",[Manager jinegeshi:[NSString stringWithFormat:@"%d",[model.price integerValue]*[model.quantity integerValue]]]];
        return cell;
    }if (indexPath.section == 1) {
        Details2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Details2_Model *model = [self.arr2 objectAtIndex:indexPath.row];
//        cell.lab1.text  = model.;
//        cell.lab2.text  = model.;
//        cell.lab3.text  = model.;
        cell.lab4.text  = model.receiver_name;
        cell.lab5.text  = model.receiver_state;
        cell.lab6.text  = model.receiver_city;
        cell.lab7.text  = model.receiver_district;
        cell.lab8.text  = model.receiver_address;
        cell.lab8.numberOfLines = 0;
        cell.lab8.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab8 sizeThatFits:CGSizeMake(SCREEN_WIDTH-100, MAXFLOAT)];
        height1 = size.height;
        cell.height1.constant = height1;
        cell.ziptop.constant  = height1-10;
        
        
        
        cell.lab9.text  = model.receiver_zip;
        cell.lab10.text = model.receiver_mobile;
        cell.lab11.text = model.receiver_phone;
        
        return cell;
    }if (indexPath.section == 2) {
        Details3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Details3_Model *model = [self.arr3 objectAtIndex:indexPath.row];
        cell.lab1.text  = model.type;
        cell.lab2.text  = model.money;
        cell.lab3.text  = model.title;
        cell.lab4.text  = model.code;
        cell.lab5.text  = model.addr;
        cell.lab6.text  = model.phone;
        cell.lab7.text  = model.bank;
        cell.lab8.text  = model.bank_no;
        cell.lab9.text  = model.status;
        return cell;
    }
    Details4_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Details4_Model *model = [self.arr4 objectAtIndex:indexPath.row];
    cell.lab1.text = model.content;
    cell.lab2.text = model.user;
    cell.lab3.text = [Manager timezhuanhuan:model.createtime];
    return cell;
}

- (void)loddetails{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"order_id":self.Order_id,
            };
    [session POST:KURLNSString(@"orderitems", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultMapList"];
            NSDictionary *dic1 = arr[0];
            NSDictionary *dic2 = arr[1];
            NSDictionary *dic3 = arr[2];
            NSDictionary *dic4 = arr[3];
            
            [weakSelf.arr1 removeAllObjects];
            [weakSelf.arr2 removeAllObjects];
            [weakSelf.arr3 removeAllObjects];
            [weakSelf.arr4 removeAllObjects];
            
            for (NSDictionary *dic in [dic1 objectForKey:@"resultList"]) {
                Details1_Model *model = [Details1_Model mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
            for (NSDictionary *dic in [dic2 objectForKey:@"resultList1"]) {
                Details2_Model *model = [Details2_Model mj_objectWithKeyValues:dic];
                [weakSelf.arr2 addObject:model];
            }
            for (NSDictionary *dic in [dic3 objectForKey:@"resultList2"]) {
                Details3_Model *model = [Details3_Model mj_objectWithKeyValues:dic];
                [weakSelf.arr3 addObject:model];
            }
            for (NSDictionary *dic in [dic4 objectForKey:@"resultList3"]) {
                Details4_Model *model = [Details4_Model mj_objectWithKeyValues:dic];
                [weakSelf.arr4 addObject:model];
            }
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}






- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor colorWithWhite:.93 alpha:1];
    if (section == 0) {
        view.text = @"   订单明细";
        return view;
    }
    if (section == 1) {
        view.text = @"   物流信息";
        return view;
    }
    if (section == 2) {
        view.text = @"   发票信息";
        return view;
    }
    if (section == 3) {
        view.text = @"   订单日志";
        return view;
    }
    return view;
}

- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3{
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)arr4{
    if (_arr4 == nil) {
        self.arr4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr4;
}

@end
