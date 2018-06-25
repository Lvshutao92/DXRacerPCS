//
//  MapModel.h
//  DXRacer
//
//  Created by ilovedxracer on 2017/7/3.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapModel : NSObject

@property(nonatomic, strong)NSString *business_id;
@property(nonatomic, strong)NSString *buyer_nick;
@property(nonatomic, strong)NSString *buyer_note;
@property(nonatomic, strong)NSString *buyer_postage;
//@property(nonatomic, strong)NSString *create_user;
@property(nonatomic, strong)NSString *express_order;
@property(nonatomic, strong)NSString *field1;
@property(nonatomic, strong)NSString *field2;
@property(nonatomic, strong)NSString *id;
@property(nonatomic, strong)NSString *is_refund;//退款
@property(nonatomic, strong)NSString *is_return;//退货
@property(nonatomic, strong)NSString *jxs_order_status;
@property(nonatomic, strong)NSString *jxs_pay_time;
@property(nonatomic, strong)NSString *jxs_postage;
@property(nonatomic, strong)NSString *jxs_postage_cj;
@property(nonatomic, strong)NSString *jxs_total_fee;



@property(nonatomic, strong)NSString *last_update;
@property(nonatomic, strong)NSString *logistics;
@property(nonatomic, strong)NSString *order_create_time;
@property(nonatomic, strong)NSString *order_deliver_time;
@property(nonatomic, strong)NSString *order_no;
@property(nonatomic, strong)NSString *order_resource;
@property(nonatomic, strong)NSString *order_resource_num;
@property(nonatomic, strong)NSString *order_status;
@property(nonatomic, strong)NSString *order_type;
@property(nonatomic, strong)NSString *parent_jxs_total_fee;
@property(nonatomic, strong)NSString *product_total_price;
@property(nonatomic, strong)NSString *seller_postage;
@property(nonatomic, strong)NSString *total_fee;
@property(nonatomic, strong)NSString *user_sendtime;
@property(nonatomic, strong)NSString *warehourse;

@property(nonatomic, strong)NSString *orderItems;



@property(nonatomic, strong)NSString *order_cancel_time;







@end
