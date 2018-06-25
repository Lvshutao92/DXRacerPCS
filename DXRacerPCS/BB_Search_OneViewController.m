//
//  BB_Search_OneViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BB_Search_OneViewController.h"
#import "KSDatePicker.h"
#import "SQMenuShowView.h"
#import "Jiansuo_One_ViewController.h"

@interface BB_Search_OneViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITextField *textfield1;
    UITextField *textfield2;
    UITextField *textfield3;
    UITextField *textfield4;
    UITextField *textfield5;
    UITextField *textfield6;
    UITextField *textfield7;
    UITextField *textfield8;
    UITextField *textfield9;
    UITextField *textfield10;
    
    UIScrollView *scrollview;
    NSArray *arr1;
    NSArray *arr2;
    
    NSInteger indexs;
    NSString *string;
}


@property(nonatomic, strong)SQMenuShowView *showView1;
@property(nonatomic, assign)BOOL isShow1;

@property(nonatomic, strong)SQMenuShowView *showView2;
@property(nonatomic, assign)BOOL isShow2;

@property(nonatomic, strong)SQMenuShowView *showView3;
@property(nonatomic, assign)BOOL isShow3;

@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *arr;

@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *array;
@property(nonatomic, strong)NSMutableArray *selextedArr;

@property(nonatomic, strong)NSMutableArray *abcArr;
@end

@implementation BB_Search_OneViewController
- (NSMutableArray *)abcArr {
    if (_abcArr == nil) {
        self.abcArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _abcArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    arr1 = @[@"订单编号",@"经销商",@"ITEMNO",@"物流单号",@"发货开始日期",@"发货结束日期",@"订单状态",@"利润筛选",@"退货状态",@"退款状态"];
    self.array = [@[@"订单待确认",@"订单已确认",@"订单已分配",@"订单已发货",@"订单已取消"]mutableCopy];
    [self setupview];
    self.selextedArr = [@[@"订单待确认",@"订单已确认",@"订单已分配",@"订单已发货"]mutableCopy];
    textfield7.text = [self.selextedArr componentsJoinedByString:@" "];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(110, 105, SCREEN_WIDTH-120, 250)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.hidden = YES;
    [scrollview addSubview:self.tableview];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(110, 355, SCREEN_WIDTH-120, 190)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableview1.hidden = YES;
    [scrollview addSubview:self.tableview1];
    
    
    __weak typeof(self) weakSelf = self;
    [self.showView1 selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow1 = NO;
        [weakSelf setupbutton1:index];
        [scrollview bringSubviewToFront:_showView1];
    }];
    [self.showView2 selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow2 = NO;
        [weakSelf setupbutton2:index];
        [scrollview bringSubviewToFront:_showView2];
    }];
    [self.showView3 selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow3 = NO;
        [weakSelf setupbutton3:index];
        [scrollview bringSubviewToFront:_showView3];
    }];
    
    [self lod];
    
}
//开始检索了
- (void)clickButton{
    Jiansuo_One_ViewController *jiansuo = [[Jiansuo_One_ViewController alloc]init];
    jiansuo.navigationItem.title = @"订单利润";
    for (string in self.selextedArr) {
        if ([string isEqualToString:@"订单待确认"]) {
            string = @"C";
        }else if ([string isEqualToString:@"订单已确认"]) {
            string = @"I";
        }else if ([string isEqualToString:@"订单已分配"]) {
            string = @"J";
        }else if ([string isEqualToString:@"订单已发货"]) {
            string = @"E";
        }else if ([string isEqualToString:@"订单已取消"]) {
            string = @"L";
        }
        [self.abcArr addObject:string];
    }
    jiansuo.jxs_order_status_str = self.abcArr;
    
    if (textfield1.text.length != 0) {
        jiansuo.order_no = textfield1.text;
    }else{
        jiansuo.order_no   = @" ";
    }
    
    if (textfield2.text.length != 0) {
        jiansuo.order_resource   = textfield2.text;
    }else{
        jiansuo.order_resource   = @" ";
    }
    
    if (textfield3.text.length != 0) {
        jiansuo.sku_code = textfield3.text;
    }else{
        jiansuo.sku_code   = @" ";
    }
    
    if (textfield4.text.length != 0) {
        jiansuo.express_order = textfield4.text;
    }else{
        jiansuo.express_order   = @" ";
    }
    
    if (textfield5.text.length != 0) {
        jiansuo.starttime = textfield5.text ;
    }else{
        jiansuo.starttime = @" ";
    }
    
    if (textfield6.text.length != 0) {
        jiansuo.endtime   = textfield6.text ;
    }else{
        jiansuo.endtime   = @" ";
    }
    
    if ([textfield8.text isEqualToString:@"全部"]) {
        jiansuo.lv   = @" ";
    }else if ([textfield8.text isEqualToString:@"盈利"]){
        jiansuo.lv   = @"Y";
    }else {
        jiansuo.lv   = @"N";
    }
    
    if ([textfield9.text isEqualToString:@"全部状态"]) {
        jiansuo.is_return   = @" ";
    }else if ([textfield9.text isEqualToString:@"已退货"]){
        jiansuo.is_return   = @"Y";
    }else {
        jiansuo.is_return   = @"N";
    }
    
    if ([textfield10.text isEqualToString:@"全部状态"]) {
        jiansuo.is_refund   = @" ";
    }else if ([textfield10.text isEqualToString:@"已退款"]){
        jiansuo.is_refund   = @"Y";
    }else {
        jiansuo.is_refund   = @"N";
    }
    [self.navigationController pushViewController:jiansuo animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview]) {
        return self.arr.count;
    }
    return self.array.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview]) {
        self.tableview.hidden = YES;
        textfield2.text = self.arr[indexPath.row];
    }
    if ([tableView isEqual:self.tableview1]){
        //判断该行原先是否选中
        NSString *str = [self.array objectAtIndex:indexPath.row];
        if ([self.selextedArr containsObject:str] == YES) {
            [self.selextedArr removeObject:str];
        }else{
            [self.selextedArr addObject:str];
        }
        textfield7.text = [self.selextedArr componentsJoinedByString:@" "];
        ////刷新该行
        [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
        return cell;
    }
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell1.textLabel.text = [self.array objectAtIndex:indexPath.row];
    //判断是否选中（选中单元格尾部打勾）
    if ([self.selextedArr containsObject:self.array[indexPath.row]]) {
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell1.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell1;
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
        [weakSelf.arr removeAllObjects];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"partnerList"];
            for (NSDictionary *dic in arr) {
                NSString *str = [dic objectForKey:@"partner_name"];
                [weakSelf.arr addObject:str];
            }
            
            
            textfield2.text = [weakSelf.arr firstObject];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}







- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:textfield1]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self hid];
        return YES;
    }
    if ([textField isEqual:textfield3]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self hid];
        return YES;
    }
    if ([textField isEqual:textfield4]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self hid];
        return YES;
    }
    
    if ([textField isEqual:textfield2]) {
        self.tableview1.hidden = YES;
        [self hid1];
        if (self.tableview.hidden == NO) {
            self.tableview.hidden = YES;
        }else{
            self.tableview.hidden = NO;
        }
    }
    if ([textField isEqual:textfield5]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self hid1];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                textfield5.text = strb;
            }
        };
        [picker show];
    }
    if ([textField isEqual:textfield6]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self hid1];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                textfield6.text = strb;
            }
        };
        [picker show];
    }
    if ([textField isEqual:textfield7]) {
        
        self.tableview.hidden = YES;
        [self hid1];
        if (self.tableview1.hidden == NO) {
            self.tableview1.hidden = YES;
        }else{
            self.tableview1.hidden = NO;
        }
        
    }
    if ([textField isEqual:textfield8]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self.showView3 dismissView];
        [self.showView2 dismissView];
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.showView1 BBOneshowView1];
        }else{
            [self.showView1 dismissView];
        }
    }
    if ([textField isEqual:textfield9]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self.showView1 dismissView];
        [self.showView3 dismissView];
        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.showView2 BBOneshowView2];
        }else{
            [self.showView2 dismissView];
        }
    }
    if ([textField isEqual:textfield10]) {
        self.tableview1.hidden = YES;
        self.tableview.hidden = YES;
        [self.showView1 dismissView];
        [self.showView2 dismissView];
        _isShow3 = !_isShow3;
        if (_isShow3) {
            [self.showView3 BBOneshowView3];
        }else{
            [self.showView3 dismissView];
        }
    }
    return NO;
}
- (void)setupview{
    scrollview = [[UIScrollView alloc]initWithFrame:self.view.frame];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture:)];
    tap.delegate = self;
    [scrollview addGestureRecognizer:tap];
    if (SCREEN_WIDTH == 320) {
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.12);
    }else if (SCREEN_WIDTH == 375) {
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.05);
    }
    [self.view addSubview:scrollview];
    
    for (int i = 0; i < arr1.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+20*i+30*i, 100, 30)];
        lab.text = arr1[i];
        lab.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lab];
        
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(110, 10*(i+1)+40*i, SCREEN_WIDTH-120, 40)];
        switch (i) {
            case 0:
                textfield1 = textfield;
                textfield1.placeholder = @"订单编号";
                break;
            case 1:
                textfield2 = textfield;
                textfield2.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 2:
                textfield3 = textfield;
                textfield3.placeholder = @"ITEMNO";
                break;
            case 3:
                textfield4 = textfield;
                textfield4.placeholder = @"物流单号";
                break;
            case 4:
                textfield5 = textfield;
                textfield5.placeholder = @"请选择";
                textfield5.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 5:
                textfield6 = textfield;
                textfield6.placeholder = @"请选择";
                textfield6.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 6:
                textfield7 = textfield;
                textfield7.placeholder = @"请选择";
                textfield7.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 7:
                textfield8 = textfield;
                textfield8.text = @"全部";
                textfield8.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 8:
                textfield9 = textfield;
                textfield9.text = @"未退货";
                textfield9.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            case 9:
                textfield10 = textfield;
                textfield10.text = @"未退款";
                textfield10.backgroundColor = RGBACOLOR(236, 235, 235, 1);
                break;
            default:
                break;
        }
        textfield.delegate = self;
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [scrollview addSubview:textfield];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 540, SCREEN_WIDTH-20, 40);
    btn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    [btn setTitle:@"开始检索" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn];
}

- (SQMenuShowView *)showView1{
    if (_showView1) {
        return _showView1;
    }
    _showView1 = [[SQMenuShowView alloc]initWithFrame:(CGRect){110,399,SCREEN_WIDTH-120,90}
                                                items:@[@"全部",@"盈利",@"亏损"]
                                            showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView1.sq_backGroundColor = [UIColor whiteColor];
    [scrollview addSubview:_showView1];
    [scrollview bringSubviewToFront:_showView1];
    return _showView1;
}
- (void)setupbutton1:(NSInteger )index{
    if (index == 0) {
        textfield8.text = @"全部";
    }else if (index == 1) {
        textfield8.text = @"盈利";
    }else{
        textfield8.text = @"亏损";
    }
}



- (SQMenuShowView *)showView2{
    if (_showView2) {
        return _showView2;
    }
    _showView2 = [[SQMenuShowView alloc]initWithFrame:(CGRect){110,449,SCREEN_WIDTH-120,90}
                                               items:@[@"全部状态",@"已退货",@"未退货"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView2.sq_backGroundColor = [UIColor whiteColor];
    [scrollview addSubview:_showView2];
    [scrollview bringSubviewToFront:_showView2];
    return _showView2;
}
- (void)setupbutton2:(NSInteger )index{
    if (index == 0) {
        textfield9.text = @"全部状态";
    }else if (index == 1) {
        textfield9.text = @"已退货";
    }else{
        textfield9.text = @"未退货";
    }
}




- (SQMenuShowView *)showView3{
    if (_showView3) {
        return _showView3;
    }
    _showView3 = [[SQMenuShowView alloc]initWithFrame:(CGRect){110,499,SCREEN_WIDTH-120,90}
                                               items:@[@"全部状态",@"已退款",@"未退款"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView3.sq_backGroundColor = [UIColor whiteColor];
    [scrollview addSubview:_showView3];
    [scrollview bringSubviewToFront:_showView3];
    return _showView3;
}
- (void)setupbutton3:(NSInteger )index{
    if (index == 0) {
        textfield10.text = @"全部状态";
    }else if (index == 1) {
        textfield10.text = @"已退款";
    }else{
        textfield10.text = @"未退款";
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:_showView1])
    {
        return NO;
    }
    if ([touch.view isDescendantOfView:_showView2])
    {
        return NO;
    }
    if ([touch.view isDescendantOfView:_showView3])
    {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.tableview])
    {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.tableview1])
    {
        return NO;
    }
    return YES;
}







- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textfield1 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    return YES;
}

- (void)tapgesture:(UITapGestureRecognizer *)sender {
    [textfield1 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [self.showView1 dismissView];
    [self.showView2 dismissView];
    [self.showView3 dismissView];
    self.tableview.hidden = YES;
    self.tableview1.hidden = YES;
}
- (void)hid{
    [self.showView1 dismissView];
    [self.showView2 dismissView];
    [self.showView3 dismissView];
}
- (void)hid1{
    [textfield1 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [self.showView1 dismissView];
    [self.showView2 dismissView];
    [self.showView3 dismissView];
}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray arrayWithCapacity:1];
    }
    return _array;
}
- (NSMutableArray *)selextedArr{
    if (_selextedArr == nil) {
        self.selextedArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedArr;
}
@end
