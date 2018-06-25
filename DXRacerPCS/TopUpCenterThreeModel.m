//
//  TopUpCenterThreeModel.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "TopUpCenterThreeModel.h"

@implementation TopUpCenterThreeModel
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"mymoney"]) propertyName = @"new_money";
    return propertyName;
}

@end
