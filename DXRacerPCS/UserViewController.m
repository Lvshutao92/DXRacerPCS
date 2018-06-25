//
//  UserViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/11.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
@interface UserViewController ()<UITextFieldDelegate>
{
    UIView *bgview;
    UITextField *textf;
    UITextField *textf1;
}
@end

@implementation UserViewController
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupvie];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickBtn:(id)sender {
    LoginViewController *login = [[LoginViewController alloc]init];
    login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:login animated:YES completion:nil];
    
}
- (IBAction)clickeditpassword:(id)sender {
    bgview.hidden = NO;
}
- (void)ckickhid:(UITapGestureRecognizer *)sender {
    [textf resignFirstResponder];
    [textf1 resignFirstResponder];
}
- (void)clickcancle{
    [textf resignFirstResponder];
    [textf1 resignFirstResponder];
    bgview.hidden = YES;
}
- (void)clicksave{
    if (textf.text.length != 0 && [textf.text isEqualToString:textf1.text]) {
        [self lodpassword];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入密码不同，请重新输入" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *ca = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:ca];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)lodpassword {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"user_id":[Manager redingwenjianming:@"user_id.text"],
            @"restpassword":textf.text
            };
    NSString *str = [[Manager sharedManager] convertToJsonData:dic];
    NSString *jsonStr = [Manager encodeBase64String:str];
    NSString *tokenStr = [[Manager sharedManager] md5:[NSString stringWithFormat:@"%@%@",str,CHECKWORD]];
    NSDictionary *para = [[NSDictionary alloc]init];
    para = @{@"token":tokenStr,@"json":jsonStr};
    [session POST:KURLNSString(@"user", @"restMyPwd") parameters:para constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *base64Decoded = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *madata = [[NSData alloc] initWithData:[base64Decoded dataUsingEncoding:NSUTF8StringEncoding ]];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:madata options:NSJSONReadingAllowFragments error:nil];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            [textf resignFirstResponder];
            [textf1 resignFirstResponder];
            bgview.hidden = YES;
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码修改成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *ca = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:ca];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}


- (void)setupvie {
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ckickhid:)];
    [bgview addGestureRecognizer:tap];
    
    bgview.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    UIView *iew = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-100, SCREEN_WIDTH-60, 160)];
    iew.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:iew];
    
    UILabel *laab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
    laab1.text = @"新密码";
    [iew addSubview:laab1];
    UILabel *laab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 80, 20)];
    laab2.text = @"重复密码";
    [iew addSubview:laab2];
    textf = [[UITextField alloc]initWithFrame:CGRectMake(90, 15, SCREEN_WIDTH-160, 30)];
    textf.placeholder = @"";
    textf.delegate = self;
        textf.borderStyle = UITextBorderStyleRoundedRect;
    [textf.layer setBorderWidth:.5];
    [textf.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf];
    textf1 = [[UITextField alloc]initWithFrame:CGRectMake(90, 55, SCREEN_WIDTH-160, 30)];
    textf1.delegate = self;
    [textf1.layer setBorderWidth:.5];
        textf1.borderStyle = UITextBorderStyleRoundedRect;
    [textf1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf1];
    
    float wid = SCREEN_WIDTH-60;
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 110, (wid-90)/2, 40);
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((wid-90)/2+60, 110, (wid-90)/2, 40);
    btn2.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicksave) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn2];
    
}













@end
