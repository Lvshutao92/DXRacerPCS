//
//  Jiansuo_One_ViewController.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/3.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Jiansuo_One_ViewController : UIViewController
@property(nonatomic,copy)NSMutableArray *jxs_order_status_str;

@property(nonatomic,strong)NSString *order_no;
@property(nonatomic,strong)NSString *order_resource;
@property(nonatomic,strong)NSString *sku_code;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *express_order;
@property(nonatomic,strong)NSString *lv;
@property(nonatomic,strong)NSString *is_return;
@property(nonatomic,strong)NSString *is_refund;


@end
