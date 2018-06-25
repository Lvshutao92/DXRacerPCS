//
//  BB_Search_TwoViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BB_Search_TwoViewController.h"
#import "KSDatePicker.h"
#import "SQMenuShowView.h"
#import "Jiansuo_Two_ViewController.h"
@interface BB_Search_TwoViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)SQMenuShowView *showView1;
@property(nonatomic, assign)BOOL isShow1;

@property(nonatomic, strong)SQMenuShowView *showView2;
@property(nonatomic, assign)BOOL isShow2;


@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *arr;

@property(nonatomic, strong)NSMutableArray *selextedArr;
@end

@implementation BB_Search_TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    for (int i = 0; i<[Manager sharedManager].arr.count; i++) {
        if (i != 2 && i != 3) {
            [self.selextedArr addObject:[Manager sharedManager].arr[i]];
        }
    }
   
    for (NSString *str in [Manager sharedManager].arr) {
        if (![str isEqualToString:@"迪锐克斯天猫旗舰店"] && ![str isEqualToString:@"迪锐克斯京东旗舰店"]) {
            self.text1.text = [self.text1.text stringByAppendingString:str];
        }
    }
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(95, 125, SCREEN_WIDTH-105, 250)];
    [self.tableview.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview.layer setBorderWidth:1];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.hidden = YES;
    [self.view addSubview:self.tableview];
    
    __weak typeof(self) weakSelf = self;
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
    

}

- (IBAction)clickBtnSearch:(id)sender {
    
    Jiansuo_Two_ViewController *jiansuo = [[Jiansuo_Two_ViewController alloc]init];
    jiansuo.jxsarr           = self.selextedArr;
    jiansuo.dingdanzhuangtai = @"E";
    jiansuo.navigationItem.title = @"货物货款";
    if ([self.text3.text isEqualToString:@"全部状态"]) {
        jiansuo.tuihuozhuangtai  = @" ";
    }
    if ([self.text3.text isEqualToString:@"已退货"]) {
        jiansuo.tuihuozhuangtai  = @"Y";
    }
    if ([self.text3.text isEqualToString:@"未退货"]) {
        jiansuo.tuihuozhuangtai  = @"N";
    }
    if (self.text4.text.length != 0) {
        jiansuo.shijian           = [self.text4.text substringToIndex:7];
    }else{
         jiansuo.shijian          = @" ";
    }
    
    [self.navigationController pushViewController:jiansuo animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Manager sharedManager].arr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断该行原先是否选中
    NSString *str = [[Manager sharedManager].arr objectAtIndex:indexPath.row];
    if ([self.selextedArr containsObject:str] == YES) {
        [self.selextedArr removeObject:str];
    }else{
        [self.selextedArr addObject:str];
    }
    
    self.text1.text = [self.selextedArr componentsJoinedByString:@" "];

    ////刷新该行
    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[Manager sharedManager].arr objectAtIndex:indexPath.row];
    
    //判断是否选中（选中单元格尾部打勾）
    if ([self.selextedArr containsObject:[Manager sharedManager].arr[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tableview.hidden = YES;
    [self.showView1 dismissView];
    [self.showView2 dismissView];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_text1]) {
        [self.showView1 dismissView];
        [self.showView2 dismissView];
        if (self.tableview.hidden == NO) {
            self.tableview.hidden = YES;
        }else{
            self.tableview.hidden = NO;
        }
    }
    if ([textField isEqual:_text2]) {
        self.tableview.hidden = YES;
        [self.showView2 dismissView];
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.showView1 BBshowView1];
        }else{
            [self.showView1 dismissView];
        }
    }
    if ([textField isEqual:_text3]) {
        self.tableview.hidden = YES;
        [self.showView1 dismissView];
        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.showView2 BBshowView2];
        }else{
            [self.showView2 dismissView];
        }
    }
    if ([textField isEqual:_text4]) {
        self.tableview.hidden = YES;
        [self.showView1 dismissView];
        [self.showView2 dismissView];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *strb = [formatter stringFromDate:currentDate];
                self.text4.text = strb;
            }
        };
        [picker show];
    }
    
    return NO;
}
- (SQMenuShowView *)showView1{
    if (_showView1) {
        return _showView1;
    }
    _showView1 = [[SQMenuShowView alloc]initWithFrame:(CGRect){95,180,SCREEN_WIDTH-105,60}
                                                items:@[@"订单已发货"]
                                            showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,190*SCALE_HEIGHT}];
    _showView1.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView1];
    [self.view bringSubviewToFront:_showView1];
    return _showView1;
}
- (void)setupbutton1:(NSInteger )index{
    self.text2.text = @"订单已发货";
}


- (SQMenuShowView *)showView2{
    if (_showView2) {
        return _showView2;
    }
    _showView2 = [[SQMenuShowView alloc]initWithFrame:(CGRect){95,240,SCREEN_WIDTH-105,90}
                                                items:@[@"全部状态",@"已退货",@"未退货"]
                                            showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,260*SCALE_HEIGHT}];
    _showView2.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView2];
    [self.view bringSubviewToFront:_showView2];
    return _showView2;
}
- (void)setupbutton2:(NSInteger )index{
    if (index == 0) {
        self.text3.text = @"全部状态";
    }else if (index == 1) {
      self.text3.text = @"已退货";
    }else{
       self.text3.text = @"未退货";
    }
}


- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)selextedArr{
    if (_selextedArr == nil) {
        self.selextedArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedArr;
}

@end
