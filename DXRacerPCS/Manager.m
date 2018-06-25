//
//  Manager.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Manager.h"

static Manager *manager = nil;

@implementation Manager
+ (Manager *)sharedManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[Manager alloc] init];
    });
    return manager;
}






//MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}
//base加解密
+ (NSString*)encodeBase64String:(NSString* )input {
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)decodeBase64String:(NSString* )input {
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)encodeBase64Data:(NSData*)data {
    data = [GTMBase64 encodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
+ (NSString*)decodeBase64Data:(NSData*)data {
    data = [GTMBase64 decodeData:data];
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    return base64String;
}
//字典转json字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
//金额转大写
+(NSString *)digitUppercase:(NSString *)numstr{
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        }
        else if (valstr.length==1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        }
        else
        {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix = [NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar  objectAtIndex:[foot intValue]]];
        }
    }
    else
    {
        prefix=@"";
        suffix=@"";
        NSInteger flag = valstr.length - 2;
        NSString *head=[valstr substringToIndex:flag - 1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return@"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            NSInteger indexloc=(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        }
        else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }
        else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar  objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}
//存取读取数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = content;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
+ (NSString *)redingwenjianming:(NSString *)wenjianming {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:wenjianming];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
}
//金额格式转换
+ (NSString *)jinegeshi:(NSString *)text {
    if(!text || [text floatValue] == 0){
        return @"¥0.00";
    }
    if (text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"¥%.2f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    return [NSString stringWithFormat:@"¥%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]]];
}
//时间格式转换
+ (NSString *)timezhuanhuan:(NSString *)str {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"MMM dd,yyyy HH:mm:ss aa";
    NSDate *createDate = [fmt dateFromString:str];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * times = [fmt stringFromDate:createDate];
    
    return times;
}
//网络请求
+ (AFHTTPSessionManager *)returnsession{
    
    //https处理
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"dms.dxracer.com.cn" ofType:@".cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerSet = [NSSet setWithObjects:cerData, nil];
    //适配https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    [securityPolicy setPinnedCertificates:cerSet];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    //参数格式处理
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    
    //网络处理LoginViewController
    
    
    
    
    // 设置超时时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 60.f;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return session;
}
+ (NSDictionary *)returndiction:(NSDictionary *)dic {
    NSString *str = [[Manager sharedManager] convertToJsonData:dic];
    NSString *jsonStr = [Manager encodeBase64String:str];
    NSString *tokenStr = [[Manager sharedManager] md5:[NSString stringWithFormat:@"%@%@",str,CHECKWORD]];
    NSDictionary *para = [[NSDictionary alloc]init];
    para = @{@"token":tokenStr,@"json":jsonStr};
//    NSLog(@"传入的参数===%@",dic);
    return para;
}
+ (NSDictionary *)returndictiondata:(NSData *)responseObject {
    NSString *base64Decoded = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *madata = [[NSData alloc] initWithData:[base64Decoded dataUsingEncoding:NSUTF8StringEncoding ]] ;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:madata options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"请求返回数据===%@",dic);
    return dic;
}
//请求失败提示语
- (void)tishiyu:(NSString *)str controller:(UIViewController *)controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [controller presentViewController:alert animated:YES completion:nil];
}
- (void)tishi:(NSError *)error controller:(UIViewController *)controller{
//    NSLog(@"error---%ld",error.code);
    if (error.code == -1001) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请求超时,请检查网络是否可用" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [controller presentViewController:alert animated:YES completion:nil];
    }else if (error.code == -1004){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请求失败！" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [controller presentViewController:alert animated:YES completion:nil];
    }else if (error.code == -1011){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请求失败！" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [controller presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请求失败！" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [controller presentViewController:alert animated:YES completion:nil];
    }
}




//延时
//dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0/*延迟执行时间*/ * NSEC_PER_SEC));
//dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//});


//- (void)lod{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
//    AFHTTPSessionManager *session = [Manager returnsession];
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [[NSDictionary alloc]init];
//    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],};
//    [session POST:KURLNSString(@"user", @"login") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        
//        
//        
//        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
//            NSDictionary *diction = [[dic objectForKey:@"rows"] objectForKey:@"user"];
//            
//        }else {
//            [[Manager sharedManager] tishiyu:@"登录失败！请检查登录信息是否正确" controller:weakSelf];
//        }
//        
//        [hud hideAnimated:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[Manager sharedManager] tishi:error controller:weakSelf];
//        [hud hideAnimated:YES];
//    }];
//}
//



@end
