//
//  LoginViewController.m
//  DXRacer
//
//  Created by ilovedxracer on 2017/6/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LoginViewController.h"




@interface LoginViewController ()<UITextFieldDelegate>
{
//    MBProgressHUD *hud;
}
@property(nonatomic, strong)UITextField *textfield;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(33, 157, 149, 1.0);
    [self setupshuxingdaila];
    
    self.numberTextfield.text   = [Manager redingwenjianming:@"bianhao.text"];
    self.usernameTextfield.text = [Manager redingwenjianming:@"user.text"];
    self.passwordTextfield.text = [Manager redingwenjianming:@"password.text"];
    
}



- (void)setupshuxingdaila {
    self.numberTextfield.delegate = self;
    self.numberTextfield.borderStyle = UITextBorderStyleNone;
    self.numberTextfield.keyboardType = UIKeyboardTypePhonePad;
    self.numberTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.usernameTextfield.delegate = self;
    self.usernameTextfield.borderStyle = UITextBorderStyleNone;
    self.usernameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordTextfield.delegate = self;
    self.passwordTextfield.borderStyle = UITextBorderStyleNone;
    self.passwordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextfield.secureTextEntry = YES;
    self.passwordTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    self.textfield.delegate = self;
}
- (IBAction)clickButton:(id)sender {
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.numberTextfield resignFirstResponder];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络(断网)");
                [self noNetWorking];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"手机自带网络");
                [self lodlogin];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"WIFI");
                [self lodlogin];
                break;
        }
    }];
    // 开始监控
    [manager startMonitoring];
}


- (void)noNetWorking{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法连接网络！请检查蜂窝移动网络或WI-FI是否可用" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}





- (void)lodlogin {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中...", @"HUD loading title");
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (self.numberTextfield.text != nil && self.usernameTextfield.text && self.passwordTextfield.text) {
        dic = @{@"business_id":self.numberTextfield.text,
                @"user_name":self.usernameTextfield.text,
                @"password":self.passwordTextfield.text
                };
//        NSLog(@"%@===%@",dic,[Manager returndiction:dic]);
        [session POST:KURLNSString(@"user", @"login") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"++%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
                NSDictionary *diction = [[dic objectForKey:@"rows"] objectForKey:@"user"];
                
                
                NSDictionary *diction1 = [[dic objectForKey:@"rows"] objectForKey:@"role"];
                [Manager writewenjianming:@"rolename.text" content:[diction1 objectForKey:@"rolename"]];
                
                [Manager writewenjianming:@"bianhao.text" content:weakSelf.numberTextfield.text];
                [Manager writewenjianming:@"password.text" content:weakSelf.passwordTextfield.text];
                [Manager writewenjianming:@"user.text" content:self.usernameTextfield.text];
                
                [Manager writewenjianming:@"business_id.text" content:[diction objectForKey:@"business_id"]];
                
                [Manager writewenjianming:@"login.text" content:[diction objectForKey:@"YES"]];
                
                [Manager writewenjianming:@"create_time.text" content:[diction objectForKey:@"create_time"]];
                [Manager writewenjianming:@"user_id.text" content:[NSString stringWithFormat:@"%@",[diction objectForKey:@"id"]]];
                [Manager writewenjianming:@"realname.text" content:[diction objectForKey:@"realname"]];
                [Manager writewenjianming:@"status.text" content:[diction objectForKey:@"status"]];
                [Manager writewenjianming:@"username.text" content:[diction objectForKey:@"username"]];
                
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"hiddenlogin" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }else {
                [[Manager sharedManager] tishiyu:@"登录失败！请检查登录信息是否正确" controller:weakSelf];
            }
            [weakSelf.numberTextfield resignFirstResponder];
            [weakSelf.usernameTextfield resignFirstResponder];
            [weakSelf.passwordTextfield resignFirstResponder];
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error = %@",error);
            [[Manager sharedManager] tishi:error controller:weakSelf];
            [hud hideAnimated:YES];
        }];
    }
}


//触摸回收键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textfield = textField;
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textfield resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
