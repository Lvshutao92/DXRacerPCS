//
//  TwoViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TwoViewController.h"
#import "DDDetailsCell.h"
#import "MapModel.h"
#import "AddressModel.h"
#import "ItemsModel.h"
#import "DDDModel.h"
#import "DingDanDetailsController.h"
#import "Order_Search_ViewController.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    CGFloat height1;
    CGFloat height2;
    CGFloat height3;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UISearchBar *searchbar;

@end

@implementation TwoViewController
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DDDetailsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    
    [self setUpReflash];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDDModel *model = [self.dataArray objectAtIndex:indexPath.row];
    DingDanDetailsController *order = [[DingDanDetailsController alloc]init];
    order.navigationItem.title = @"订单详情";
    order.oderid = model.mapmodel.id;
    
    order.str1 = model.mapmodel.logistics;
    order.str2 = model.mapmodel.express_order;
        order.str3 = model.mapmodel.jxs_postage_cj;
    
    
    [self.navigationController pushViewController:order animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 440+height1+height3+height2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DDDModel *model = [self.dataArray objectAtIndex:indexPath.row];
    //    ItemsModel *mo = [model.orderItems firstObject];
    
    cell.lab1.text = model.mapmodel.order_no;
    
    
    if (model.mapmodel.orderItems.length == 0 || [model.mapmodel.orderItems isEqual:[NSNull null]]) {
        cell.lab2.text = @"-";
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height1 = size1.height;
        cell.height1.constant = height1;
        cell.top1.constant = size1.height - 10;
    }else{
        cell.lab2.text = model.mapmodel.orderItems;
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height1 = size1.height;
        cell.height1.constant = height1;
        cell.top1.constant = size1.height - 10;
    }
    
    if ([model.mapmodel.jxs_order_status isEqualToString:@"C"]) {
        cell.lab3.text = @"订单已创建";
    }
    else if ([model.mapmodel.jxs_order_status isEqualToString:@"E"]) {
        cell.lab3.text = @"订单已发货";
    }
    else if ([model.mapmodel.jxs_order_status isEqualToString:@"I"]) {
        cell.lab3.text = @"订单已确认";
    }
    else if ([model.mapmodel.jxs_order_status isEqualToString:@"L"]) {
        cell.lab3.text = @"订单已取消";
    }
    else if ([model.mapmodel.jxs_order_status isEqualToString:@"J"]) {
        cell.lab3.text = @"订单已分配";
    }
    else if ([model.mapmodel.jxs_order_status isEqualToString:@"G"]) {
        cell.lab3.text = @"订单待取消";
    }else if ([model.mapmodel.jxs_order_status isEqualToString:@"A"] || [model.mapmodel.jxs_order_status isEqualToString:@"N"]){
        cell.lab3.text = @"订单异常";
    }
    
    
    if (model.mapmodel.order_resource.length == 0 || [model.mapmodel.order_resource isEqual:[NSNull null]]) {
        cell.lab4.text = @"-";
    }else{
        cell.lab4.text = model.mapmodel.order_resource;
    }
    
    if (model.mapmodel.order_resource_num.length == 0 || [model.mapmodel.order_resource_num isEqual:[NSNull null]]) {
        cell.lab5.text = @"-";
    }else{
        cell.lab5.text = model.mapmodel.order_resource_num;
    }
    
    if (model.mapmodel.buyer_note.length == 0 || [model.mapmodel.buyer_note isEqual:[NSNull null]]) {
        cell.lab6.text = @"-";
        cell.lab6.numberOfLines = 0;
        cell.lab6.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height2 = size2.height;
        cell.height2.constant = height2;
        cell.top2.constant = size2.height + 25;
    }else{
        cell.lab6.text = model.mapmodel.buyer_note;
        cell.lab6.numberOfLines = 0;
        cell.lab6.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height2 = size2.height;
        cell.height2.constant = height2;
        cell.top2.constant = size2.height - 10;
    }
    
    if (model.mapmodel.logistics.length == 0 || [model.mapmodel.logistics isEqual:[NSNull null]]) {
        cell.lab7.text = @"-";
    }else{
        cell.lab7.text = model.mapmodel.logistics;
    }
    
    if (model.addressmodel.receiver_name.length == 0 || [model.addressmodel.receiver_name isEqual:[NSNull null]]) {
        cell.lab8.text = @"-";
    }else{
        cell.lab8.text = model.addressmodel.receiver_name;
    }
    
    if (model.mapmodel.express_order.length == 0 || [model.mapmodel.express_order isEqual:[NSNull null]]) {
        cell.lab9.text = @"-";
        cell.lab9.numberOfLines = 0;
        cell.lab9.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size3 = [cell.lab9 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height3 = size3.height;
        cell.height3.constant = height3;
        cell.top3.constant = size3.height - 10;
    }else{
        cell.lab9.text = model.mapmodel.express_order;
        cell.lab9.numberOfLines = 0;
        cell.lab9.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size3 = [cell.lab9 sizeThatFits:CGSizeMake(SCREEN_WIDTH-125, MAXFLOAT)];
        height3 = size3.height;
        cell.height3.constant = height3;
        cell.top3.constant = size3.height - 10;
    }
    
    if (model.mapmodel.seller_postage.length == 0 || [model.mapmodel.seller_postage isEqual:[NSNull null]]) {
        cell.lab10.text = @"-";
    }else{
        cell.lab10.text = [Manager jinegeshi:model.mapmodel.seller_postage];
    }
    
    
    
    if (model.mapmodel.jxs_total_fee.length == 0 || [model.mapmodel.jxs_total_fee isEqual:[NSNull null]]) {
        cell.lab11.text = @"-";
    }else{
        cell.lab11.text = [Manager jinegeshi:model.mapmodel.jxs_total_fee];
    }
    if (model.mapmodel.warehourse.length == 0 || [model.mapmodel.warehourse isEqual:[NSNull null]]) {
        cell.lab12.text = @"-";
    }else{
        cell.lab12.text = model.mapmodel.warehourse;
    }
    if (model.mapmodel.order_deliver_time.length == 0 || [model.mapmodel.order_deliver_time isEqual:[NSNull null]]) {
        cell.lab13.text = @"-";
    }else{
        cell.lab13.text = [Manager timezhuanhuan:model.mapmodel.order_deliver_time];
    }
    if (model.mapmodel.order_cancel_time.length == 0 || [model.mapmodel.order_cancel_time isEqual:[NSNull null]]) {
        cell.lab14.text = @"-";
    }else{
        cell.lab14.text = [Manager timezhuanhuan:model.mapmodel.order_cancel_time];
    }
    
    
    if ([model.mapmodel.is_return isEqualToString:@"Y"]) {
        UIImage *theImage = [UIImage imageNamed:@"select"];
        theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.btn1 setImage:theImage forState:UIControlStateSelected];
        [cell.btn1 setTintColor:RGBACOLOR(32, 157, 149, 1.0)];
    }else {
        [cell.btn1 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    }
    
    if ([model.mapmodel.is_refund isEqualToString:@"Y"]) {
        UIImage *theImage = [UIImage imageNamed:@"select"];
        theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.btn2 setImage:theImage forState:UIControlStateSelected];
        [cell.btn2 setTintColor:RGBACOLOR(32, 157, 149, 1.0)];
    }else {
        [cell.btn2 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    }
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
    [session POST:KURLNSString(@"order", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"resultList1"];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        [DDDModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"orderItems" : [ItemsModel class],
                     };
        }];
        for (NSDictionary *temp in array) {
            DDDModel *model = [DDDModel mj_objectWithKeyValues:temp];
            
            AddressModel *addressmodel = [AddressModel mj_objectWithKeyValues:model.orderAddress];
            MapModel *mapmodel = [MapModel mj_objectWithKeyValues:model.map];
            
            model.addressmodel = addressmodel;
            model.mapmodel = mapmodel;
            
            [weakSelf.dataArray addObject:model];
        }
        page = 2;
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
    
    [session POST:KURLNSString(@"order", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"resultList1"];
        
        [DDDModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"orderItems" : [ItemsModel class],
                     };
        }];
        for (NSDictionary *temp in array) {
            DDDModel *model = [DDDModel mj_objectWithKeyValues:temp];
            
            AddressModel *addressmodel = [AddressModel mj_objectWithKeyValues:model.orderAddress];
            MapModel *mapmodel = [MapModel mj_objectWithKeyValues:model.map];
            
            model.addressmodel = addressmodel;
            model.mapmodel = mapmodel;
            
            [weakSelf.dataArray addObject:model];
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





- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    Order_Search_ViewController *search = [[Order_Search_ViewController alloc]init];
    search.navigationItem.title = @"订单检索";
    [self.navigationController pushViewController:search animated:YES];

    return NO;
}














@end
