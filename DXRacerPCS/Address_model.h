//
//  Address_model.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address_model : NSObject
@property(nonatomic,strong)NSString *business_id ;
@property(nonatomic,strong)NSString *id ;
@property(nonatomic,strong)NSString *invoice_id ;
@property(nonatomic,strong)NSString *receiver_address;

@property(nonatomic,strong)NSString *receiver_city ;
@property(nonatomic,strong)NSString *receiver_district ;
@property(nonatomic,strong)NSString *receiver_mobile ;
@property(nonatomic,strong)NSString *receiver_name;

@property(nonatomic,strong)NSString *receiver_phone ;
@property(nonatomic,strong)NSString *receiver_state ;
@end