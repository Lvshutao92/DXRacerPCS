//
//  EditkaipiaoViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "EditkaipiaoViewController.h"

@interface EditkaipiaoViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textfield;
@end

@implementation EditkaipiaoViewController

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
    
    
    self.text1.text = self.str1;
    self.text2.text = self.str2;
    self.text3.text = self.str3;
    self.text4.text = self.str4;
    self.text5.text = self.str5;
    self.text6.text = self.str6;
    self.text7.text = self.str7;
    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)clickButtonSave:(id)sender {
    
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        self.text3.text = @"";
    }
    if (self.text4.text.length == 0) {
        self.text4.text = @"";
    }
    if (self.text5.text.length == 0) {
        self.text5.text = @"";
    }
    if (self.text6.text.length == 0) {
        self.text6.text = @"";
    }
    if (self.text7.text.length == 0) {
        self.text7.text = @"";
    }
    
    [self lod];
    
}




- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"id":self.idstring,
            @"partner_name":self.text1.text,
            @"company_name":self.text2.text,
            @"payer_code":self.text3.text,
            @"address":self.text4.text,
            @"phone_num":self.text5.text,
            @"bank_name":self.text6.text,
            @"bank_account":self.text7.text,
            };
    [session POST:KURLNSString(@"partner_invoice", @"update") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
}








//触摸回收键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.text1]) {
        return NO;
    }
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
