//
//  EditAddressViewController.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text1;

@property (weak, nonatomic) IBOutlet UITextField *text2;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UITextField *text3;

@property (weak, nonatomic) IBOutlet UITextField *text4;



@property(nonatomic, strong)NSString *idstring;
@property(nonatomic, strong)NSString *str1;
@property(nonatomic, strong)NSString *str2;
@property(nonatomic, strong)NSString *str3;
@property(nonatomic, strong)NSString *str4;
@property(nonatomic, strong)NSString *str5;
@property(nonatomic, strong)NSString *str6;
@property(nonatomic, strong)NSString *str7;
@end
