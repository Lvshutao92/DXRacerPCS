//
//  AccountViewController.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet UITextField *textfield4;


@property(nonatomic, strong)NSString *str1;
@property(nonatomic, strong)NSString *str2;
@property(nonatomic, strong)NSString *str3;
@property(nonatomic, strong)NSString *str4;
@property(nonatomic, strong)NSString *str5;

@property(nonatomic, strong)NSString *idstr;
@end
