//
//  EditAddressViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "EditAddressViewController.h"
#import "FYLCityPickView.h"


#import "FYLCityModel.h"
#import "YYModel.h"


@interface EditAddressViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    NSString *sheng;
    NSString *shi;
    NSString *qu;
}
@property(nonatomic,strong)UITextField *textfield;

@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textfield.delegate = self;
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.textview.delegate = self;
   
    
    self.text1.text = self.str1;
    self.text2.text = [NSString stringWithFormat:@"%@-%@-%@",self.str2,self.str3,self.str4];
    
    self.textview.text = self.str5;
    self.text3.text = self.str6;
    self.text4.text = self.str7;
   
   
    
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FYLCity" ofType:@"plist"];
    NSArray *arrData = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *dic in arrData) {
        
        if ([[dic objectForKey:@"v"] containsString:self.str2]) {
            sheng = [dic objectForKey:@"k"];
            arr1 = [dic objectForKey:@"n"];
            for (NSDictionary *dic in arr1) {
                if ([[dic objectForKey:@"v"]containsString:self.str3]) {
                    shi = [dic objectForKey:@"k"];
                    arr2 = [dic objectForKey:@"n"];
                    for (NSDictionary *dic in arr2) {
                        if ([[dic objectForKey:@"v"]containsString:self.str4]) {
                            qu = [dic objectForKey:@"k"];
                         }
                    }
                    
                }
            }
            
            
        }
       
    }
//    110000  110100  110101
}
- (IBAction)clickButtonSave:(id)sender {
    
    if (self.text1.text.length == 0 || sheng.length == 0 || shi.length == 0 || qu.length == 0 || self.textview.text.length == 0 || self.text3.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"编辑失败！检查信息是否完整" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if (self.text4.text.length == 0) {
            self.text4.text = @"";
        }
        [self lod];
    }
    
    
}




- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"invoice_id":self.idstring,
            @"receiver_name":self.text1.text,
            @"receiver_state":sheng,
            @"receiver_city":shi,
            @"receiver_district":qu,
            @"receiver_address":self.textview.text,
            @"receiver_mobile":self.text3.text,
            @"receiver_phone":self.text4.text,
            };
     NSLog(@"---%@",dic);
    [session POST:KURLNSString(@"partner_address", @"update") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSLog(@"===%@",dic);
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






-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//触摸回收键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.text1]) {
         [self.textfield resignFirstResponder];
         return NO;
    }
    if ([textField isEqual:self.text2]) {
        [self.textfield resignFirstResponder];
        [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
            self.text2.text = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
            sheng = arr[3];
            shi = arr[4];
            qu = arr[5];
        }];
        return NO;
    }
//    self.textfield = textField;
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
    [self.text4 resignFirstResponder];
    [self.textview resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
