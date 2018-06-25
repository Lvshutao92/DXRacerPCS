//
//  JXS_One_Search_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/14.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JXS_One_Search_ViewController.h"
#import "AllPanter_nameModel.h"
#import "JXS_Search_One_details_ViewController.h"
@interface JXS_One_Search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITextField *textfield;

@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;


@property(nonatomic, strong)UITableView *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;


@property(nonatomic, strong)UITableView *tableview3;
@property(nonatomic, strong)NSMutableArray *dataArray3;
@end

@implementation JXS_One_Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.dataArray2 = [@[@"全部",@"已审核",@"未审核"]mutableCopy];
    self.dataArray3 = [@[@"全部",@"一级",@"二级"]mutableCopy];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(105, 125, SCREEN_WIDTH-115, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    [self lodjinxiaoshang];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(105, 185, SCREEN_WIDTH-115, 130)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(105, 245, SCREEN_WIDTH-115, 130)];
    [self.tableview3.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview3.layer setBorderWidth:1];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    self.tableview3.hidden = YES;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableview3];
    [self.view bringSubviewToFront:self.tableview3];
}


- (IBAction)clickButtonSearch:(id)sender {
    JXS_Search_One_details_ViewController *one = [[JXS_Search_One_details_ViewController alloc]init];
    one.navigationItem.title = @"经销商列表";
    
    if ([self.text1.text isEqualToString:@"全部"]) {
        one.name = [NSNull null];
    }else{
        one.name = self.text1.text;
    }
    
    if ([self.text2.text isEqualToString:@"全部"]) {
        one.status = [NSNull null];
    }else if ([self.text2.text isEqualToString:@"已审核"]){
        one.status = @"B";
    }else if ([self.text2.text isEqualToString:@"未审核"]){
        one.status = @"A";
    }
    
    if ([self.text3.text isEqualToString:@"全部"]) {
        one.partner =  [NSNull null];
    }else if ([self.text3.text isEqualToString:@"一级"]){
        one.partner = @"1";
    }else if ([self.text3.text isEqualToString:@"二级"]){
        one.partner = @"2";
    }
    
    [self.navigationController pushViewController:one animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text1.text = self.dataArray1[indexPath.row];
    }
    if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        self.text2.text = self.dataArray2[indexPath.row];
    }
    if ([tableView isEqual:self.tableview3]) {
        self.tableview3.hidden = YES;
        self.text3.text = self.dataArray3[indexPath.row];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    if ([tableView isEqual:self.tableview2]) {
        return self.dataArray2.count;
    }
    return self.dataArray3.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//        cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
        cell.textLabel.text = self.dataArray1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ([tableView isEqual:self.tableview2]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//        cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//        cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
        cell.textLabel.text = self.dataArray2[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//    cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
    cell.textLabel.text = self.dataArray3[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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




//触摸回收键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if ([textField isEqual:self.text1]) {
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
    }
    if ([textField isEqual:self.text2]) {
        self.tableview1.hidden = YES;
        self.tableview3.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
    }
    if ([textField isEqual:self.text3]) {
        self.tableview2.hidden = YES;
        self.tableview1.hidden = YES;
        if (self.tableview3.hidden == YES) {
            self.tableview3.hidden = NO;
        }else{
            self.tableview3.hidden = YES;
        }
    }
    self.textfield = textField;
    return NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    [self.textfield resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}
- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}
@end
