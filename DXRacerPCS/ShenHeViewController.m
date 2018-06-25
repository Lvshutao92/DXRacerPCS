//
//  ShenHeViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ShenHeViewController.h"
#import "SQMenuShowView.h"

@interface ShenHeViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    NSString *status;
}
@property(nonatomic, strong)SQMenuShowView *showView;
@property(nonatomic, assign)BOOL isShow;
@end

@implementation ShenHeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupdelegate];
    
    self.text1.text = self.str1;
    self.text2.text = self.str2;
    self.text3.text = self.str3;
    self.text4.text = self.str4;
    self.text5.text = self.str5;
    self.text6.text = self.str6;
    self.text7.text = self.str7;

    self.textview2.text = self.str8;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30) ;
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow = NO;
        [weakSelf setupbutton:index];
        [self.bgview bringSubviewToFront:_showView];
    }];
    self.text8.text = @"全部";
    status = @" ";
}

- (void)clickSave {
    if (self.textview1.text.length == 0) {
        self.textview1.text = @" ";
    }
    if (self.idStr.length != 0 && status.length != 0 && self.textview1.text.length != 0) {
        [self lodShenHe];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"提交失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (SQMenuShowView *)showView{
    if (_showView) {
        return _showView;
    }
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){110,515,SCREEN_WIDTH-120,60}
                                               items:@[@"全部",@"审核通过",@"审核不通过"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-120,60}];
    _showView.sq_backGroundColor = [UIColor whiteColor];
    [self.bgview addSubview:_showView];
    [self.bgview bringSubviewToFront:_showView];
    return _showView;
}
- (void)setupbutton:(NSInteger )index{
    if (index == 0) {
        self.text8.text = @"全部";
        status = @" ";
    }else if (index == 1) {
        self.text8.text = @"审核通过";
        status = @"Y";
    }else{
        self.text8.text = @"审核不通过";
        status = @"N";
    }
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    self.bgview.frame = CGRectMake(0, -250*SCALE_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
   self.bgview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)lodShenHe{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"user_id":[Manager redingwenjianming:@"user_id.text"],
            
            @"id":self.idStr,
            
            @"status":status,
            @"audit_note":self.textview1.text,
            };
    [session POST:KURLNSString(@"partner_topup", @"update") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"审核成功" preferredStyle:1];
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text8]) {
        _isShow = !_isShow;
        if (_isShow) {
            [self.showView showView];
        }else{
            [self.showView dismissView];
        }
    }
    return NO;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView isEqual:self.textview2]) {
        _isShow = !_isShow;
        return NO;
    }
    textView.editable = YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textview1 resignFirstResponder];
    [self.showView dismissView];
}
- (void)setupdelegate{
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text6.delegate = self;
    self.text7.delegate = self;
    self.text8.delegate = self;
    
    
    self.textview1.layer.masksToBounds = YES;
    self.textview1.layer.cornerRadius = 5;
    self.textview2.layer.masksToBounds = YES;
    self.textview2.layer.cornerRadius = 5;
    [self.textview2.layer setBorderWidth:1];
    [self.textview2.layer setBorderColor:[UIColor colorWithWhite:.8 alpha:.3].CGColor];
    self.textview1.delegate = self;
    self.textview2.delegate = self;
}
@end
