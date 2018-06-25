//
//  JXS_Search_One_details_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/14.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_Search_One_details_ViewController.h"
#import "JXS_ONE_model.h"
#import "JXS_ONE_Cell.h"
#import "Edit_ViewController.h"
#import "Xiaojia_ViewController.h"

@interface JXS_Search_One_details_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalnum;
    NSInteger page;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation JXS_Search_One_details_ViewController

- (void)lodbianjidetails:(NSString *)str {
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"id":str,
            };
    [session POST:KURLNSString(@"partner", @"editPage") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            NSDictionary   *dic1 = [[dic objectForKey:@"rows"] objectForKey:@"partner"];
            
            NSMutableArray *arr  = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
            NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:1];
            arr = [[dic objectForKey:@"rows"] objectForKey:@"partner_storeList"];
            for (NSDictionary *dic in arr) {
                [arr1 addObject:[dic objectForKey:@"name"]];
                [arr2 addObject:[dic objectForKey:@"id"]];
            }
            
            
            
            Edit_ViewController *add = [[Edit_ViewController alloc]init];
            add.navigationItem.title = @"编辑";
            
            add.idString = [dic1 objectForKey:@"id"];
            
            add.str1  = [dic1 objectForKey:@"partner_name"];
            add.str2  = (NSString *)[dic1 objectForKey:@"province"];
            add.str3  = (NSString *)[dic1 objectForKey:@"city"];
            add.str4  = (NSString *)[dic1 objectForKey:@"area"];
            add.str5  = [dic1 objectForKey:@"detail_address"];
            add.str6  = [dic1 objectForKey:@"shop_addr"];
            add.str7  = [dic1 objectForKey:@"shop_name"];
            add.str8  = [dic1 objectForKey:@"email"];
            add.str9  = [dic1 objectForKey:@"mobile"];
            add.str10 = [dic1 objectForKey:@"telephone"];
            add.str11 = [dic1 objectForKey:@"wangwang"];
            add.str12 = [dic1 objectForKey:@"qq"];
            add.str13 = [dic1 objectForKey:@"msn"];
            
            add.str14 = [dic1 objectForKey:@"allow_confirm_order"];
            add.str15 = [dic1 objectForKey:@"no_limit_inventory"];
            add.str16 = [dic1 objectForKey:@"type"];
            add.str17 = [dic1 objectForKey:@"is_store"];
            
            add.str18 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"parent_partner_id"]];
            
            
            //            NSLog(@"%ld==%ld",arr1.count,arr2.count);
            add.arr1 = arr1;          //下单仓名字
            add.arr2 = arr2;          //下单仓id
            
            
            add.str20 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"invoice_time"]];      //开票时间
            add.str21 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"invoice_money"]];     //开票限额
            add.str22 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"safe_inventory"]];    //安全库存
            add.str23 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"commission_time"]];
            add.str24 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"ispaydeposit"]];      //是否缴纳保证金
            add.str25 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"deposit"]];           //保证金金额
            //取出根视图控制器
            UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            //取出当前选中的导航控制器
            UINavigationController *Nav = [tabBarVc selectedViewController];
            [Nav pushViewController:add animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *suer = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull sure, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        
        JXS_ONE_model *model = [self.dataArray objectAtIndex:indexPath.row];
        [self lodbianjidetails:model.id];
    }];
    suer.backgroundColor = RGBACOLOR(254, 91, 91, 1.0);
    
    UITableViewRowAction *deleate = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JXS_ONE_model *model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.status isEqualToString:@"A"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除？删除后数据无法恢复！" preferredStyle:1];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self loddelete:model.id];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核、停用状态，不能删除" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    deleate.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    
    UITableViewRowAction *xiugai = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"审核" handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JXS_ONE_model *model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.status isEqualToString:@"B"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核状态，不能再次审核" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定审核吗？" preferredStyle:1];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self lodshenhe:indexPath str:model.id];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    xiugai.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    
    UITableViewRowAction *tingyong = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"停用" handler:^(UITableViewRowAction * _Nonnull tingyong, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        JXS_ONE_model *model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.status isEqualToString:@"B"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定停用吗？" preferredStyle:1];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self lodtingyong:indexPath str:model.id];
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"停用状态，不能再次停用" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    tingyong.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    
    UITableViewRowAction *xiaojia = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"$销价" handler:^(UITableViewRowAction * _Nonnull xiaojia, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        Xiaojia_ViewController *xiao_jia = [[Xiaojia_ViewController alloc]init];
        xiao_jia.navigationItem.title = @"销价设置";
        //取出根视图控制器
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        //取出当前选中的导航控制器
        UINavigationController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:xiao_jia animated:YES];
    }];
    xiaojia.backgroundColor = RGBACOLOR(39, 194, 183, 1.0);
    return @[suer,deleate,xiugai,tingyong];
}

- (void)lodtingyong:(NSIndexPath *)indexPath str:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"user_id":[Manager redingwenjianming:@"user_id.text"],
            @"id":idstr,
            };
    [session POST:KURLNSString(@"partner", @"unaudit") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"停用失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
}
- (void)lodshenhe:(NSIndexPath *)indexPath str:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"user_id":[Manager redingwenjianming:@"user_id.text"],
            @"id":idstr,
            };
    [session POST:KURLNSString(@"partner", @"audit") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
        [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
}
- (void)loddelete:(NSString *)idstr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"id":idstr,
            };
    [session POST:KURLNSString(@"partner", @"delete") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        //        NSLog(@"------%@",[dic objectForKey:@"result_msg"]);
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
}












- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"JXS_ONE_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
//    NSLog(@"%@--%@---%@",self.str1,self.str2,self.str3);
    [self setUpReflash];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 305;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXS_ONE_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    JXS_ONE_model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lab1.text = model.partner_name;
    
    cell.lab2.text = [Manager jinegeshi:model.money];
    
    if ([model.parent_partner_id isEqual:[NSNull null]] || model.parent_partner_id.length == 0) {
        cell.lab3.text = @"-";
    }else{
        cell.lab3.text = model.parent_partner_id;
    }
    
    
    cell.lab4.text = model.province;
    
    cell.lab5.text = model.city;
    
    cell.lab6.text = [Manager timezhuanhuan:model.apply_time];
    
    if ([model.status isEqualToString:@"A"]) {
        cell.lab7.text = @"未审核";
    }else if ([model.status isEqualToString:@"B"]) {
        cell.lab7.text = @"已审核";
    }else{
        cell.lab7.text = @"已停用";
    }
    
    cell.lab8.text = [Manager timezhuanhuan:model.audit_time];
    
    cell.lab9.text = model.mobile;
    
    
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
            @"partner_name":self.name,
            @"status":self.status,
            @"parent_partner_id":self.partner,
            };
    [session POST:KURLNSString(@"partner", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                JXS_ONE_model *model = [JXS_ONE_model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
//            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
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
            @"partner_name":self.name,
            @"status":self.status,
            @"parent_partner_id":self.partner,
            };
    
    [session POST:KURLNSString(@"partner", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                JXS_ONE_model *model = [JXS_ONE_model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }else {
//            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
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
