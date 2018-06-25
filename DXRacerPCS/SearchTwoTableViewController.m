//
//  SearchTwoTableViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SearchTwoTableViewController.h"
#import "SQMenuShowView.h"
#import "AllPanter_nameModel.h"
#import "KSDatePicker.h"

@interface SearchTwoTableViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;

@property(nonatomic, strong)SQMenuShowView *showView;
@property(nonatomic, assign)BOOL isShow;

@property(nonatomic, strong)SQMenuShowView *showView1;
@property(nonatomic, assign)BOOL isShow1;

@property(nonatomic, strong)SQMenuShowView *showView2;
@property(nonatomic, assign)BOOL isShow2;


@end

@implementation SearchTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfield1.delegate = self;
    self.textfield2.delegate = self;
    self.textfield3.delegate = self;
    self.textfield4.delegate = self;
    self.textfield5.delegate = self;
    self.textfield6.delegate = self;
    self.textfield7.delegate = self;
    self.textfield8.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow = NO;
        [weakSelf setupbutton:index];
        [self.view bringSubviewToFront:_showView];
    }];
    [self.showView1 selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow1 = NO;
        [weakSelf setupbutton1:index];
        [self.view bringSubviewToFront:_showView1];
    }];
    [self.showView2 selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow2 = NO;
        [weakSelf setupbutton2:index];
        [self.view bringSubviewToFront:_showView2];
    }];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(120, 125, SCREEN_WIDTH-130, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodjinxiaoshang];
}



- (IBAction)clickButtonSearch:(id)sender {
    if (self.textfield5.text.length == 0) {
        self.textfield5.text = @" ";
    }
    if (self.textfield6.text.length == 0) {
        self.textfield6.text = @" ";
    }
    if (self.textfield7.text.length == 0) {
        self.textfield7.text = @" ";
    }
    if (self.textfield8.text.length == 0) {
        self.textfield8.text = @" ";
    }
    if ([self.textfield2.text isEqualToString:@"待审核"]) {
        str = @"B";
    }else if ([self.textfield2.text isEqualToString:@"财务审核不通过"]){
        str = @"N";
    }else if ([self.textfield2.text isEqualToString:@"财务审核通过"]){
        str = @"Y";
    }else {
        str = @"全部";
    }
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.textfield1.text,@"key1",str,@"key2",self.textfield3.text,@"key3",self.textfield4.text,@"key4",self.textfield5.text,@"key5",self.textfield6.text,@"key6",self.textfield7.text,@"key7",self.textfield8.text,@"key8", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"topupsearchtwo" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
}





- (SQMenuShowView *)showView2{
    if (_showView2) {
        return _showView2;
    }
    _showView2 = [[SQMenuShowView alloc]initWithFrame:(CGRect){120,270,SCREEN_WIDTH-130,60}
                                               items:@[@"全部",@"支付宝",@"网银转账"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,190*SCALE_HEIGHT}];
    _showView2.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView2];
    [self.view bringSubviewToFront:_showView2];
    return _showView2;
}
- (void)setupbutton2:(NSInteger )index{
    if (index == 0) {
        self.textfield4.text = @"全部";
    }else if (index == 1) {
        self.textfield4.text = @"支付宝";
    }else{
        self.textfield4.text = @"网银转账";
    }
}
- (SQMenuShowView *)showView1{
    if (_showView1) {
        return _showView1;
    }
    _showView1 = [[SQMenuShowView alloc]initWithFrame:(CGRect){120,220,SCREEN_WIDTH-130,60}
                                                items:@[@"全部",@"货款充值",@"挂帐充值",@"虚拟充值"]
                                            showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView1.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView1];
    [self.view bringSubviewToFront:_showView1];
    return _showView1;
}
- (void)setupbutton1:(NSInteger )index{
    if (index == 0) {
        self.textfield3.text = @"全部";
    }else if (index == 1) {
        self.textfield3.text = @"货款充值";
    }else if (index == 2){
        self.textfield3.text = @"挂帐充值";
    }else{
        self.textfield3.text = @"虚拟充值";
    }
}
- (SQMenuShowView *)showView{
    if (_showView) {
        return _showView;
    }
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){120,170,SCREEN_WIDTH-130,60}
                                                items:@[@"全部",@"待审核",@"财务审核不通过",@"财务审核通过"]
                                            showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView];
    [self.view bringSubviewToFront:_showView];
    return _showView;
}
- (void)setupbutton:(NSInteger )index{
    if (index == 0) {
        self.textfield2.text = @"全部";
    }else if (index == 1) {
        self.textfield2.text = @"待审核";
    }else if (index == 2){
        self.textfield2.text = @"财务审核不通过";
    }else{
        self.textfield2.text = @"财务审核通过";
    }
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.textfield1]) {
        [self.showView dismissView];
        [self.showView1 dismissView];
        [self.showView2 dismissView];
        
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
    }
    if ([textField isEqual:self.textfield2]) {
        [self.showView1 dismissView];
        [self.showView2 dismissView];
        self.tableview1.hidden = YES;
        _isShow = !_isShow;
        if (_isShow) {
            [self.showView showView];
        }else{
            [self.showView dismissView];
        }
    }
    if ([textField isEqual:self.textfield3]) {
        [self.showView dismissView];
        [self.showView2 dismissView];
        self.tableview1.hidden = YES;
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.showView1 showView1];
        }else{
            [self.showView1 dismissView];
        }
    }
    if ([textField isEqual:self.textfield4]) {
        [self.showView1 dismissView];
        [self.showView dismissView];
        self.tableview1.hidden = YES;
        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.showView2 showView2];
        }else{
            [self.showView2 dismissView];
        }
    }
    if ([textField isEqual:self.textfield5]) {
        //x,y 值无效，默认是居中的
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        //配置中心，详情见KSDatePikcerApperance
        picker.appearance.radius = 5;
        //设置回调
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *stra = [formatter stringFromDate:currentDate];
                self.textfield5.text = stra;
            }
        };
        // 显示
        [picker show];
    }
    if ([textField isEqual:self.textfield6]) {
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.textfield6.text = strb;
            }
        };
        [picker show];
    }
    if ([textField isEqual:self.textfield7]) {
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strc = [formatter stringFromDate:currentDate];
                self.textfield7.text = strc;
            }
        };
        [picker show];
    }
    if ([textField isEqual:self.textfield8]) {
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strd = [formatter stringFromDate:currentDate];
                self.textfield8.text = strd;
            }
        };
        [picker show];
    }
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    self.textfield1.text = self.dataArray1[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
//    cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
    cell.textLabel.text = self.dataArray1[indexPath.row];
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















- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield3 resignFirstResponder];
    
    [self.showView dismissView];
     [self.showView1 dismissView];
     [self.showView2 dismissView];
    self.tableview1.hidden = YES;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

@end
