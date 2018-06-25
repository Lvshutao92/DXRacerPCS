//
//  Order_Search_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Order_Search_ViewController.h"
#import "AllPanter_nameModel.h"
#import "KSDatePicker.h"
#import "Order_Srearch_List_ViewController.h"

@interface Order_Search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *idstr;
}
@property(nonatomic,strong)UITextField *textfield;


@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray11;

@property(nonatomic, strong)UITableView *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;

@end

@implementation Order_Search_ViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textfield.delegate = self;
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text6.delegate = self;
    self.text7.delegate = self;
    self.text8.delegate = self;
    
    self.dataArray2 = [@[@"全部订单",@"订单待确认",@"订单已确认",@"订单已分配",@"订单已发货",@"订单已取消"]mutableCopy];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(120, 165, SCREEN_WIDTH-130, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    [self lodjinxiaoshang];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(120, 365, SCREEN_WIDTH-130, 130)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
}


- (IBAction)clickButtonSearch:(id)sender {
    
    Order_Srearch_List_ViewController *list = [[Order_Srearch_List_ViewController alloc]init];
    list.navigationItem.title = @"检索信息";
    
    if (self.text1.text.length == 0) {
        list.str1 = @"";
    }else{
        list.str1 = self.text1.text;
    }
    
    
    if ([self.text2.text isEqualToString:@"全部"]) {
        list.str2 = @"";
    }else{
        list.str2 = self.text2.text;
    }
    
    
    
    if (self.text3.text.length == 0) {
        list.str3 = @"";
    }else{
        list.str3 = self.text3.text;
    }
    
    
    
    if (self.text4.text.length == 0) {
        list.str4 = @"";
    }else{
        list.str4 = self.text4.text;
    }
    
    
    
    if (self.text5.text.length == 0) {
        list.str5 = @"";
    }else{
        list.str5 = self.text5.text;
    }
    
    if ([self.text6.text isEqualToString:@"全部订单"]) {
        list.str6 = @"";
    }else if ([self.text6.text isEqualToString:@"订单待确认"]){
        list.str6 = @"C";
    }else if ([self.text6.text isEqualToString:@"订单已确认"]){
        list.str6 = @"I";
    }else if ([self.text6.text isEqualToString:@"订单已分配"]){
        list.str6 = @"J";
    }else if ([self.text6.text isEqualToString:@"订单已发货"]){
        list.str6 = @"E";
    }else if ([self.text6.text isEqualToString:@"订单已取消"]){
        list.str6 = @"L";
    }
    
    if (self.text7.text.length == 0) {
        list.str7 = @"";
    }else{
        list.str7 = self.text7.text;
    }
    
    
    if (self.text8.text.length == 0) {
        list.str8 = @"";
    }else{
        list.str8 = self.text8.text;
    }
    
    
    [self.navigationController pushViewController:list animated:YES];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text2.text = self.dataArray1[indexPath.row];
        idstr = self.dataArray11[indexPath.row];
    }
    if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        self.text6.text = self.dataArray2[indexPath.row];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray2.count;
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
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//    cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
    cell.textLabel.text = self.dataArray2[indexPath.row];
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
                [weakSelf.dataArray11 addObject:model.id];
            }
            [weakSelf.dataArray1 insertObject:@"全部" atIndex:0];
            [weakSelf.dataArray11 insertObject:@"" atIndex:0];
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
    if ([textField isEqual:self.text2]) {
        self.tableview2.hidden = YES;
        [self.textfield resignFirstResponder];
        
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        
        
        return NO;
    }
    if ([textField isEqual:self.text6]) {
        self.tableview1.hidden = YES;
        [self.textfield resignFirstResponder];
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        
        return NO;
    }
    if ([textField isEqual:self.text7]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        [self.textfield resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.text7.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text8]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        [self.textfield resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.text8.text = strb;
            }
        };
        [picker show];
        return NO;
    }
    self.textfield = textField;
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
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
- (NSMutableArray *)dataArray11 {
    if (_dataArray11 == nil) {
        self.dataArray11 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray11;
}
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}

@end
