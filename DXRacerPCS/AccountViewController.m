//
//  AccountViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "AccountViewController.h"
#import "SQMenuShowView.h"
@interface AccountViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)SQMenuShowView *showView;
@property(nonatomic, assign)BOOL isShow;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfield1.delegate = self;
    self.textfield2.delegate = self;
    self.textfield3.delegate = self;
    self.textfield4.delegate = self;
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        self.textfield1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        
        self.textfield1.text = self.str1;
        if ([self.str1 isEqualToString:@"支付宝"]) {
            self.textfield2.text = self.str2;
            self.name.text = @"支付宝名称";
        }else {
            self.textfield2.text = self.str3;
            self.name.text = @"银行名称";
        }
        self.textfield3.text = self.str4;
        self.textfield4.text = self.str5;
    }
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        __weak typeof(self) weakSelf = self;
        [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
            weakSelf.isShow = NO;
            [weakSelf setupbutton:index];
            [self.view bringSubviewToFront:_showView];
        }];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30) ;
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    
    
}
- (void)clickSave{
    if (self.textfield1.text.length == 0 || self.textfield2.text.length == 0 || self.textfield3.text.length == 0 || self.textfield4.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请提交完整信息，重新提交" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        if ([self.navigationItem.title isEqualToString:@"编辑"]) {
            [self lodedit];
        }else{
            [self lodadd];
        }
    }
}


- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if ([self.textfield1.text isEqualToString:@"支付宝"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"type":self.textfield1.text,
                @"remark1":self.textfield2.text,
                @"colaccount":self.textfield3.text,
                @"companyname":self.textfield4.text,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"type":self.textfield1.text,
                @"back_name":self.textfield2.text,
                @"colaccount":self.textfield3.text,
                @"companyname":self.textfield4.text,
                };
    }
    [session POST:KURLNSString(@"collaccount", @"add") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}
- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if ([self.textfield1.text isEqualToString:@"支付宝"]) {
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"id":self.idstr,
                @"type":self.textfield1.text,
                @"remark1":self.textfield2.text,
                @"colaccount":self.textfield3.text,
                @"companyname":self.textfield4.text,
                };
    }else{
        dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"id":self.idstr,
                @"type":self.textfield1.text,
                @"back_name":self.textfield2.text,
                @"colaccount":self.textfield3.text,
                @"companyname":self.textfield4.text,
                };
    }
    [session POST:KURLNSString(@"collaccount", @"update") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"修改成功！" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
    }];
}











- (SQMenuShowView *)showView{
    if (_showView) {
        return _showView;
    }
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){105,119,SCREEN_WIDTH-115,60}
                                               items:@[@"支付宝",@"网银转账"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,60}];
    _showView.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView];
    [self.view bringSubviewToFront:_showView];
    return _showView;
}
- (void)setupbutton:(NSInteger )index{
    if (index == 0) {
        self.textfield1.text = @"支付宝";
        self.name.text = @"支付宝名称";
        self.textfield2.placeholder = @"支付宝名称";
    }
    if (index == 1){
        self.textfield1.text = @"网银转账";
        self.name.text = @"开户银行";
        self.textfield2.placeholder = @"开户银行";
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        if ([textField isEqual:self.textfield1]) {
            return NO;
        }
        return YES;
    }
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        if ([textField isEqual:self.textfield1]) {
            _isShow = !_isShow;
            if (_isShow) {
                [self.showView showView];
            }else{
                [self.showView dismissView];
            }
            return NO;
        }
        [self.showView dismissView];
        return YES;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield3 resignFirstResponder];
    [self.textfield4 resignFirstResponder];
    [self.showView dismissView];
}




@end
