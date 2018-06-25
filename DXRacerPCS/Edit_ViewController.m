//
//  Add_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/14.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Edit_ViewController.h"
#import "FYLCityPickView.h"

#import "AllPanter_nameModel.h"
#import "XDC_model.h"

#import "FYLCityModel.h"
#import "YYModel.h"
@interface Edit_ViewController ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollview;
    CGFloat height1;
    CGFloat height2;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    
    UIButton *btn5;
    UIButton *btn6;
    
    
    UIButton *btn7;
    UIButton *btn8;
    
    
    
    UITextField *jxs;
    UITextField *pass;
    UITextField *agin_pass;
    UITextField *sheng_shi_qu;
    
    UITextView *addr;
    UITextView *shopping_wangzhi;
    
    UITextField *shopping_name;
    UITextField *youxiang_addr;
    UITextField *mobile_num;
    UITextField *phone_num;
    UITextField *ww;
    UITextField *qq;
    UITextField *msn;
    
    UITextField *sj_jxs;
    UITextField *xiadancang;
    UITextField *kaipiaotime;
    UITextField *kaipiaomoney;
    UITextField *anquankucun;
    UITextField *shenqingyongjintime;
    
    UILabel *lab28;
    UITextField *baozhengjin;
    
    
   
    
    
    UIButton *btn;
    UIView *bgview;
    
    
    NSString *sheng;
    NSString *shi;
    NSString *qu;
    NSString *shengname;
    NSString *shiname;
    NSString *quname;
    
    NSString *string1;
    NSString *string2;
    NSString *string3;
    NSString *string4;
    NSString *string5;
    NSString *string6;
    
    NSString *str7;
}
@property(nonatomic, strong)UITextView *textview;
@property(nonatomic, strong)UITextField *textfield;

@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray11;

@property(nonatomic, strong)UITableView *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)NSMutableArray *dataArray3;
@property(nonatomic, strong)NSMutableArray *selextedArr;
@property(nonatomic, strong)NSMutableArray *selextedIDArr;

@end

@implementation Edit_ViewController

- (NSMutableArray *)selextedIDArr {
    if (_selextedIDArr == nil) {
        self.selextedIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedIDArr;
}
- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}


- (void)clickCommitInformation{
    if ([sj_jxs.text isEqualToString:@"无"]) {
        str7 = [NSNull null];
    }
    if (addr.text.length == 0) {
        addr.text = @"";
    }
    
    if (shopping_wangzhi.text.length == 0) {
        shopping_wangzhi.text = @"";
    }
    
    if (shopping_name.text.length == 0) {
        shopping_name.text = @"";
    }
    
    if (youxiang_addr.text.length == 0) {
        youxiang_addr.text = @"";
    }
    
    if (phone_num.text.length == 0) {
        phone_num.text = @"";
    }
    
    if (ww.text.length == 0) {
        ww.text = @"";
    }
    
    if (qq.text.length == 0) {
        qq.text = @"";
    }
    
    if (msn.text.length == 0) {
        msn.text = @"";
    }
    if (baozhengjin.text.length == 0 || [baozhengjin isEqual:[NSNull null]]) {
        baozhengjin.text = @"";
    }
    
   
        if (jxs.text.length == 0 || sheng_shi_qu.text.length == 0 || mobile_num.text.length == 0 || xiadancang.text.length == 0 ) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请检查必填项是否为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [self commitinformation];
        }
    
    
    
}



- (void)commitinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    
   
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
                @"id":self.idString,
                @"partner_name":jxs.text,
                
                @"province":sheng,
                @"city":shi,
                @"area":qu,
                @"detail_address":addr.text,
                @"shop_addr":shopping_wangzhi.text,
                @"shop_name":shopping_name.text,
                @"email":youxiang_addr.text,
                @"mobile":mobile_num.text,
                @"telephone":phone_num.text,
                @"wangwang":ww.text,
                @"qq":qq.text,
                @"msn":msn.text,
                
                @"allow_confirm_order":string1,
                @"no_limit_inventory":string2,
                @"type":string3,
                @"is_store":string4,
                
                @"parent_partner_id":str7,
                @"storeIds":self.selextedIDArr,
                @"invoice_time":kaipiaotime.text,
                @"invoice_money":kaipiaomoney.text,
                @"safe_inventory":anquankucun.text,
                @"commission_time":shenqingyongjintime.text,
                
                @"ispaydeposit":string5,
                
                @"deposit":baozhengjin.text,
                
            };
    
//    NSLog(@"%@",dic);
    [session POST:KURLNSString(@"partner", @"update") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"++++%@",dic);
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
//        NSLog(@"+-----%@",error);
    }];
}













- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -90, SCREEN_WIDTH, SCREEN_HEIGHT+90)];
    
    
    if (SCREEN_WIDTH > 667) {
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
    }else if (SCREEN_WIDTH < 667){
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2.3);
    }else{
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2.7);
    }
    
    
    
    
    
    [self.view addSubview:scrollview];
    self.textfield.delegate = self;
    
    [self setupview_one];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 910, SCREEN_WIDTH-110, 250)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [scrollview addSubview:self.tableview1];
    [scrollview bringSubviewToFront:self.tableview1];
    
    [self lodjinxiaoshang];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(100, 960, SCREEN_WIDTH-110, 250)];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [scrollview addSubview:self.tableview2];
    [scrollview bringSubviewToFront:self.tableview2];
    
    [self lod];
    
    jxs.text = self.str1;
    sheng = self.str2;
    shi = self.str3;
    qu = self.str4;
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FYLCity" ofType:@"plist"];
    NSArray *arrData = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in arrData) {
        if ([[dic objectForKey:@"k"] containsString:self.str2]) {
            shengname = [dic objectForKey:@"v"];
            arr1 = [dic objectForKey:@"n"];
            for (NSDictionary *dic in arr1) {
                if ([[dic objectForKey:@"k"]containsString:self.str3]) {
                    shiname = [dic objectForKey:@"v"];
                    arr2 = [dic objectForKey:@"n"];
                    for (NSDictionary *dic in arr2) {
                        if ([[dic objectForKey:@"k"]containsString:self.str4]) {
                            quname = [dic objectForKey:@"v"];
                        }
                    }
                    
                }
            }
        }
    }
    sheng_shi_qu.text = [NSString stringWithFormat:@"%@-%@-%@",shengname,shiname,quname];
    addr.text = self.str5;
    shopping_wangzhi.text = self.str6;
    shopping_name.text = self.str7;
    youxiang_addr.text = self.str8;
    mobile_num.text = self.str9;
    phone_num.text = self.str10;
    ww.text = self.str11;
    qq.text = self.str12;
    msn.text = self.str13;
    
    if ([self.str14 isEqualToString:@"Y"]) {
        [btn1 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn1.selected = NO;
        string1 = @"Y";
    }else{
        [btn1 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn1.selected = YES;
        string1 = @"N";
    }
    
    if ([self.str15 isEqualToString:@"Y"]) {
        [btn2 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn2.selected = NO;
        string2 = @"Y";
    }else{
        [btn2 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn2.selected = YES;
        string2 = @"N";
    }
    
    if ([self.str16 isEqualToString:@"Y"]) {
        [btn3 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn3.selected = NO;
        string3 = @"Y";
    }else{
        [btn3 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn3.selected = YES;
        string3 = @"N";
    }
    
    if ([self.str17 isEqualToString:@"Y"]) {
        [btn4 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn4.selected = NO;
        string4 = @"Y";
    }else{
        [btn4 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn4.selected = YES;
        string4 = @"N";
    }
    
    
    self.selextedArr   = self.arr1;
    self.selextedIDArr = self.arr2;
    xiadancang.text = [self.selextedArr componentsJoinedByString:@" "];
    kaipiaotime.text = self.str20;
    kaipiaomoney.text = self.str21;
    anquankucun.text = self.str22;
    shenqingyongjintime.text = self.str23;
    
    
    
    if ([self.str24 isEqualToString:@"是"]) {
        height1 = 1260;
        lab28.hidden = NO;
        baozhengjin.hidden = NO;
        [btn5 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        [btn6 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        string5 = @"是";
        baozhengjin.text = self.str25;
    }else{
        height1 = 1200;
        lab28.hidden = YES;
        baozhengjin.hidden = YES;
        [btn5 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [btn6 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        string5 = @"否";
        baozhengjin.text = @"0";
    }
//    NSLog(@"%@-----------%@",self.str24,self.str25);
//    if (self.str25.length == 0 || [self.str25 isEqual:[NSNull null]]) {
//        baozhengjin.text = @"0";
//    }else{
//        baozhengjin.text = self.str25;
//    }
    
    
   
}

- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2 {
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self lodyanzheng];
}

- (void)lodyanzheng{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"partner_name":jxs.text,
            };
    [session POST:KURLNSString(@"partner", @"check") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (jxs.text.length != 0) {
            if ([[dic objectForKey:@"valid"] integerValue] == 0) {
                jxs.text = nil;
                [jxs becomeFirstResponder];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"经销商已存在" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"partner", @"initWarahouse") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"storeList"];
            [weakSelf.dataArray2 removeAllObjects];
            for (NSDictionary *dic in arr) {
                XDC_model *model = [XDC_model mj_objectWithKeyValues:dic];
                [weakSelf.dataArray2 addObject:model.name];
                [weakSelf.dataArray3 addObject:model.id];
            }
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodjinxiaoshang{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"partner_topup", @"innitPartners") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"partnerList"];
            [weakSelf.dataArray1 removeAllObjects];
            for (NSDictionary *dic in arr) {
                AllPanter_nameModel *model = [AllPanter_nameModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArray1 addObject:model.partner_name];
                [weakSelf.dataArray11 addObject:model.id];
            }
            [weakSelf.dataArray1  insertObject:@"无" atIndex:0];
            [weakSelf.dataArray11 insertObject:@"" atIndex:0];
            
            
            
            if ([weakSelf.str18 isEqual:[NSNull null]] || weakSelf.str18 == nil || weakSelf.str18.length == 0) {
                sj_jxs.text = @"无";
                str7 = [NSNull null];
            }else{
                int a = 0;
                for (NSString *str in self.dataArray11) {
                    if ([str isEqualToString:self.str18]) {
                        sj_jxs.text = self.dataArray1[a];
                        str7 = str;
                    }
                    a++;
                }
            }
            
            
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败" controller:weakSelf];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        sj_jxs.text = self.dataArray1[indexPath.row];
        str7 = self.dataArray11[indexPath.row];
    }
    
    if ([tableView isEqual:self.tableview2]) {
        //判断该行原先是否选中
        NSString *str  = [self.dataArray2 objectAtIndex:indexPath.row];
        NSString *str1 = [self.dataArray3 objectAtIndex:indexPath.row];
        if ([self.selextedArr containsObject:str] == YES) {
            [self.selextedArr removeObject:str];
            [self.selextedIDArr removeObject:str1];
        }else{
            [self.selextedArr addObject:str];
            [self.selextedIDArr addObject:str1];
        }
        xiadancang.text = [self.selextedArr componentsJoinedByString:@" "];
        ////刷新该行
        [self.tableview2 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]){
        return self.dataArray1.count;
    }
    return self.dataArray2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //        cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
        //        cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
        cell.textLabel.text = self.dataArray1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    //    cell.contentView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    //    cell.textLabel.backgroundColor = [UIColor colorWithWhite:.99 alpha:.05];
    cell.textLabel.text = self.dataArray2[indexPath.row];
    //判断是否选中（选中单元格尾部打勾）
    if ([self.selextedArr containsObject:self.dataArray2[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}






- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:jxs]){
        return NO;
    }
    if ([textField isEqual:sheng_shi_qu]) {
        [self.textfield resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
            sheng_shi_qu.text = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
            sheng = arr[3];
            shi = arr[4];
            qu = arr[5];
//            NSLog(@"%@-%@-%@-%@-%@-%@",arr[0],arr[1],arr[2],arr[3],arr[4],arr[5]);
        }];
        return NO;
    }
    if ([textField isEqual:sj_jxs]) {
        
        self.tableview2.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
            [scrollview bringSubviewToFront:self.tableview1];
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:xiadancang]) {
        self.tableview1.hidden = YES;
        
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
            [scrollview bringSubviewToFront:self.tableview2];
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    
    
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}





- (void)click1{
    if (btn1.selected == NO) {
        [btn1 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn1.selected = YES;
        string1 = @"Y";
    }else{
        [btn1 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn1.selected = NO;
        string1 = @"N";
    }
}
- (void)click2{
    if (btn2.selected == NO) {
        [btn2 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn2.selected = YES;
        string2 = @"Y";
    }else{
        [btn2 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn2.selected = NO;
        string2 = @"N";
    }
}
- (void)click3{
    if (btn3.selected == NO) {
        [btn3 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn3.selected = YES;
        string3 = @"Y";
    }else{
        [btn3 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn3.selected = NO;
        string3 = @"N";
    }
}
- (void)click4{
    if (btn4.selected == NO) {
        [btn4 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        btn4.selected = YES;
        string4 = @"Y";
    }else{
        [btn4 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        btn4.selected = NO;
        string4 = @"N";
    }
}


- (void)click5{
    NSLog(@"888888");
    height1 = 1260;
    lab28.hidden = NO;
    baozhengjin.hidden = NO;
    [btn5 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn6 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    
    
    string5 = @"是";
    
}

- (void)click6{
    
    height1 = 1200;
    lab28.hidden = YES;
    baozhengjin.hidden = YES;
    [btn5 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn6 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    
    
    string5 = @"否";
}





- (void)setupview_one{
    
    string1 = @"N";
    string2 = @"Y";
    string3 = @"Y";
    string4 = @"Y";
    string5 = @"否";
    string6 = @"普通发票";
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 85, 20)];
    lab1.text = @"经销商账号";
    lab1.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab1];
    jxs = [[UITextField alloc]initWithFrame:CGRectMake(100, 105, SCREEN_WIDTH-110, 30)];
    jxs.borderStyle = UITextBorderStyleRoundedRect;
    jxs.delegate = self;
    jxs.placeholder = @"必填";
    jxs.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [scrollview addSubview:jxs];
    
//    
//    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 85, 20)];
//    lab2.text = @"密码";
//    lab2.font = [UIFont systemFontOfSize:10];
//    [scrollview addSubview:lab2];
//    pass = [[UITextField alloc]initWithFrame:CGRectMake(100, 55, SCREEN_WIDTH-110, 30)];
//    pass.borderStyle = UITextBorderStyleRoundedRect;
//    pass.delegate = self;
//    pass.placeholder = @"必填";
//    [scrollview addSubview:pass];
//    
//    
//    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 85, 20)];
//    lab3.text = @"重复密码";
//    lab3.font = [UIFont systemFontOfSize:10];
//    [scrollview addSubview:lab3];
//    agin_pass = [[UITextField alloc]initWithFrame:CGRectMake(100, 105, SCREEN_WIDTH-110, 30)];
//    agin_pass.borderStyle = UITextBorderStyleRoundedRect;
//    agin_pass.delegate = self;
//    agin_pass.placeholder = @"必填";
//    [scrollview addSubview:agin_pass];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 85, 20)];
    lab4.text = @"省市区";
    lab4.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab4];
    sheng_shi_qu = [[UITextField alloc]initWithFrame:CGRectMake(100, 155, SCREEN_WIDTH-110, 30)];
    sheng_shi_qu.borderStyle = UITextBorderStyleRoundedRect;
    sheng_shi_qu.delegate = self;
    sheng_shi_qu.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    sheng_shi_qu.placeholder = @"请选择";
    [scrollview addSubview:sheng_shi_qu];
    
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, 85, 20)];
    lab5.text = @"详细地址";
    lab5.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab5];
    addr = [[UITextView alloc]initWithFrame:CGRectMake(100, 205, SCREEN_WIDTH-110, 80)];
    addr.layer.masksToBounds = YES;
    addr.layer.cornerRadius = 6;
    addr.delegate = self;
    addr.layer.borderColor = [UIColor colorWithWhite:.9 alpha:1].CGColor;
    [addr.layer setBorderWidth:1];
    [scrollview addSubview:addr];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 85, 20)];
    lab6.text = @"店铺网址";
    lab6.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab6];
    shopping_wangzhi = [[UITextView alloc]initWithFrame:CGRectMake(100, 295, SCREEN_WIDTH-110, 80)];
    shopping_wangzhi.layer.masksToBounds = YES;
    shopping_wangzhi.layer.cornerRadius = 6;
    shopping_wangzhi.delegate = self;
    shopping_wangzhi.layer.borderColor = [UIColor colorWithWhite:.9 alpha:1].CGColor;
    [shopping_wangzhi.layer setBorderWidth:1];
    [scrollview addSubview:shopping_wangzhi];
    
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, 85, 20)];
    lab7.text = @"店铺名称";
    lab7.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab7];
    shopping_name = [[UITextField alloc]initWithFrame:CGRectMake(100, 395, SCREEN_WIDTH-110, 30)];
    shopping_name.borderStyle = UITextBorderStyleRoundedRect;
    shopping_name.delegate = self;
    [scrollview addSubview:shopping_name];
    
    
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, 85, 20)];
    lab8.text = @"邮箱地址";
    lab8.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab8];
    youxiang_addr = [[UITextField alloc]initWithFrame:CGRectMake(100, 445, SCREEN_WIDTH-110, 30)];
    youxiang_addr.borderStyle = UITextBorderStyleRoundedRect;
    youxiang_addr.delegate = self;
    [scrollview addSubview:youxiang_addr];
    
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 500, 85, 20)];
    lab9.text = @"手机号码";
    lab9.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab9];
    mobile_num = [[UITextField alloc]initWithFrame:CGRectMake(100, 495, SCREEN_WIDTH-110, 30)];
    mobile_num.borderStyle = UITextBorderStyleRoundedRect;
    mobile_num.delegate = self;
    mobile_num.placeholder = @"必填";
    mobile_num.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:mobile_num];
    
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 550, 85, 20)];
    lab10.text = @"电话号码";
    lab10.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab10];
    phone_num = [[UITextField alloc]initWithFrame:CGRectMake(100, 545, SCREEN_WIDTH-110, 30)];
    phone_num.borderStyle = UITextBorderStyleRoundedRect;
    phone_num.delegate = self;
    [scrollview addSubview:phone_num];
    
    
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 600, 85, 20)];
    lab11.text = @"旺旺";
    lab11.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab11];
    ww = [[UITextField alloc]initWithFrame:CGRectMake(100, 595, SCREEN_WIDTH-110, 30)];
    ww.borderStyle = UITextBorderStyleRoundedRect;
    ww.delegate = self;
    [scrollview addSubview:ww];
    
    
    
    UILabel *lab12 = [[UILabel alloc]initWithFrame:CGRectMake(10, 650, 85, 20)];
    lab12.text = @"QQ";
    lab12.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab12];
    qq = [[UITextField alloc]initWithFrame:CGRectMake(100, 645, SCREEN_WIDTH-110, 30)];
    qq.borderStyle = UITextBorderStyleRoundedRect;
    qq.delegate = self;
    qq.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:qq];
    
    
    
    UILabel *lab13 = [[UILabel alloc]initWithFrame:CGRectMake(10, 700, 85, 20)];
    lab13.text = @"MSN";
    lab13.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab13];
    msn = [[UITextField alloc]initWithFrame:CGRectMake(100, 695, SCREEN_WIDTH-110, 30)];
    msn.borderStyle = UITextBorderStyleRoundedRect;
    msn.delegate = self;
    [scrollview addSubview:msn];
    
    UILabel *lab14 = [[UILabel alloc]initWithFrame:CGRectMake(10, 750, 85, 20)];
    lab14.text = @"账号设置:";
    lab14.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab14];
    
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 750, 20, 20);
    [btn1 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn1];
    UILabel *lab15 = [[UILabel alloc]initWithFrame:CGRectMake(130, 750, SCREEN_WIDTH-140, 20)];
    lab15.text = @"自动确认订单";
    lab15.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab15];
    
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 780, 20, 20);
    [btn2 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn2];
    UILabel *lab16 = [[UILabel alloc]initWithFrame:CGRectMake(130, 780, SCREEN_WIDTH-140, 20)];
    lab16.text = @"检查安全库存";
    lab16.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab16];
    
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 810, 20, 20);
    [btn3 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn3];
    UILabel *lab17 = [[UILabel alloc]initWithFrame:CGRectMake(130, 810, SCREEN_WIDTH-140, 20)];
    lab17.text = @"预充值账号";
    lab17.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab17];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(100, 840, 20, 20);
    [btn4 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn4];
    UILabel *lab18 = [[UILabel alloc]initWithFrame:CGRectMake(130, 840, SCREEN_WIDTH-140, 20)];
    lab18.text = @"不参与利润统计";
    lab18.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab18];
    
    
    UILabel *lab19 = [[UILabel alloc]initWithFrame:CGRectMake(10, 880, 85, 20)];
    lab19.text = @"上级经销商";
    lab19.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab19];
    sj_jxs = [[UITextField alloc]initWithFrame:CGRectMake(100, 875, SCREEN_WIDTH-110, 30)];
    sj_jxs.borderStyle = UITextBorderStyleRoundedRect;
    sj_jxs.delegate = self;
    sj_jxs.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    sj_jxs.text = @"无";
    [scrollview addSubview:sj_jxs];
    
    
    UILabel *lab20 = [[UILabel alloc]initWithFrame:CGRectMake(10, 930, 85, 20)];
    lab20.text = @"下单仓";
    lab20.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab20];
    xiadancang = [[UITextField alloc]initWithFrame:CGRectMake(100, 925, SCREEN_WIDTH-110, 30)];
    xiadancang.borderStyle = UITextBorderStyleRoundedRect;
    xiadancang.delegate = self;
    xiadancang.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    xiadancang.placeholder = @"请选择（必填）";
    [scrollview addSubview:xiadancang];
    
    
    UILabel *lab21 = [[UILabel alloc]initWithFrame:CGRectMake(10, 980, 85, 20)];
    lab21.text = @"开票时间(天)";
    lab21.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab21];
    kaipiaotime = [[UITextField alloc]initWithFrame:CGRectMake(100, 975, SCREEN_WIDTH-110, 30)];
    kaipiaotime.borderStyle = UITextBorderStyleRoundedRect;
    kaipiaotime.delegate = self;
    kaipiaotime.text = @"7";
    [scrollview addSubview:kaipiaotime];
    
    
    UILabel *lab22 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1030, 85, 20)];
    lab22.text = @"开票限额(元)";
    lab22.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab22];
    kaipiaomoney = [[UITextField alloc]initWithFrame:CGRectMake(100, 1025, SCREEN_WIDTH-110, 30)];
    kaipiaomoney.borderStyle = UITextBorderStyleRoundedRect;
    kaipiaomoney.delegate = self;
    kaipiaomoney.text = @"100000";
//    kaipiaomoney.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:kaipiaomoney];
    
    
    UILabel *lab23 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1080, 85, 20)];
    lab23.text = @"安全库存";
    lab23.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab23];
    anquankucun = [[UITextField alloc]initWithFrame:CGRectMake(100, 1075, SCREEN_WIDTH-110, 30)];
    anquankucun.borderStyle = UITextBorderStyleRoundedRect;
    anquankucun.delegate = self;
    anquankucun.text = @"0";
//    anquankucun.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:anquankucun];
    
    
    UILabel *lab24 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1130, 85, 20)];
    lab24.text = @"申请佣金时间(天)";
    lab24.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab24];
    shenqingyongjintime = [[UITextField alloc]initWithFrame:CGRectMake(100, 1125, SCREEN_WIDTH-110, 30)];
    shenqingyongjintime.borderStyle = UITextBorderStyleRoundedRect;
    shenqingyongjintime.delegate = self;
    shenqingyongjintime.text = @"14";
//    shenqingyongjintime.keyboardType = UIKeyboardTypeNumberPad;
    [scrollview addSubview:shenqingyongjintime];
    
    
    UILabel *lab25 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1175, 85, 20)];
    lab25.text = @"交纳保证金:";
    lab25.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab25];
    
    
    btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(100, 1175, 20, 20);
    [btn5 setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(click5) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn5];
    UILabel *lab26 = [[UILabel alloc]initWithFrame:CGRectMake(120, 1175, 20, 20)];
    lab26.text = @"是";
    lab26.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab26];
    
    
    btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(150, 1175, 20, 20);
    [btn6 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(click6) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn6];
    UILabel *lab27 = [[UILabel alloc]initWithFrame:CGRectMake(170, 1175, 20, 20)];
    lab27.text = @"否";
    lab27.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:lab27];
    
    height1 = 1200;
    
    lab28 = [[UILabel alloc]initWithFrame:CGRectMake(10, height1+25, 85, 20)];
    lab28.text = @"保证金金额";
    lab28.hidden = YES;
    lab28.font = [UIFont systemFontOfSize:10];
    [scrollview addSubview:lab28];
    baozhengjin = [[UITextField alloc]initWithFrame:CGRectMake(100, 1220, SCREEN_WIDTH-110, 30)];
    baozhengjin.borderStyle = UITextBorderStyleRoundedRect;
    baozhengjin.delegate = self;
    baozhengjin.hidden = YES;
    baozhengjin.text = @"0";
    [scrollview addSubview:baozhengjin];
    
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    [btn setTitle:@"资料无误，创建经销商" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickCommitInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //    [self.view bringSubviewToFront:btn];
    
    
    
    scrollview.userInteractionEnabled = YES;
}





-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray11 {
    if (_dataArray11 == nil) {
        self.dataArray11 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray11;
}
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}
- (NSMutableArray *)selextedArr{
    if (_selextedArr == nil) {
        self.selextedArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedArr;
}
@end
