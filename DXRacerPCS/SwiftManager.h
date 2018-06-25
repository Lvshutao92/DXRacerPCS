//
//  SwiftManager.h
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/31.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
@interface SwiftManager : NSObject
+ (SwiftManager *)sharedManager;


//MD5加密
- (NSString *)md5:(NSString *)str;
//base加解密
+ (NSString*)encodeBase64String:(NSString*)input;
+ (NSString*)decodeBase64String:(NSString*)input;
+ (NSString*)encodeBase64Data:(NSData*)data;
+ (NSString*)decodeBase64Data:(NSData*)data;
//字典转json字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict;
//金额转大写
+(NSString *)digitUppercase:(NSString *)numstr;
//存取数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content;
//读取数据
+ (NSString *)redingwenjianming:(NSString *)wenjianming;
//时间格式转化
+ (NSString *)timezhuanhuan:(NSString *)str;
//金额格式转换
+ (NSString *)jinegeshi:(NSString *)text;


+ (NSDictionary *)returndiction:(NSDictionary *)dic;
+ (NSDictionary *)returndictiondata:(NSData *)responseObject;




@end
