//
//  TopUpCenterOneModel.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopUpCenterOneModel : NSObject
@property(nonatomic, strong)NSString *amount;
@property(nonatomic, strong)NSString *colaccount;
@property(nonatomic, strong)NSString *coltype;
@property(nonatomic, strong)NSString *create_note;
@property(nonatomic, strong)NSString *create_time;
@property(nonatomic, strong)NSString *id;
@property(nonatomic, strong)NSString *old_id;
@property(nonatomic, strong)NSString *partner_name;
@property(nonatomic, strong)NSString *payaccount;
@property(nonatomic, strong)NSString *paytype;
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *topuptype;

@property(nonatomic, strong)NSString *certificateurl;
@property(nonatomic, strong)NSString *collecturl;


@property(nonatomic, strong)NSString *audit_note;
@property(nonatomic, strong)NSString *audit_time;
@property(nonatomic, strong)NSString *audit_user;
@end
