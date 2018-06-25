//
//  Xiaojia_ViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/15.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Xiaojia_ViewController.h"
#import "Xiao_Jia_Cell.h"
#import "Xiaojia_Model.h"
@interface Xiaojia_ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
    NSInteger totalnum;
    NSInteger page;
    
    UIView *bgview;
    UITextField *textf;
    UITextField *textf1;
    

    
    UIView *bgview111111;
    UITextField *textf22222;
    UITextField *textf33333;
    
    UIView *Searchbgview;
    UITextField *Searchtext1;
    UITextField *Searchtext2;
    UITextField *Searchtext3;
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    CGFloat height1;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UISearchBar *searchbar;

@end

@implementation Xiaojia_ViewController


- (void)loddelete:(NSMutableArray *)arr{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"modeltype_id":self.idstr,
            @"ids":arr
            };
    [session POST:KURLNSString(@"modelprice", @"delete") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleate = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull kaipiao, NSIndexPath * _Nonnull indexPath) {
        self.tableview.editing = NO;
        Xiaojia_Model *model = [self.dataArray objectAtIndex:indexPath.row];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
        
        [arr addObject:model.id];
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除？删除后数据无法恢复！" preferredStyle:1];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self loddelete:arr];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
    }];
    deleate.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
    
    
    
    
    return @[deleate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"Xiao_Jia_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableview.tableHeaderView = view;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请点击进行检索";
    [view addSubview:_searchbar];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH/2-0.5, 50);
    btn.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn setTitle:@"经销价设置" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT-50, 1, 50)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH/2+0.5, SCREEN_HEIGHT-50, SCREEN_WIDTH/2-0.5, 50);
    btn1.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn1 setTitle:@"新增" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [self.view bringSubviewToFront:btn1];
    
    [self setupvie];
    [self setupvie1];
    [self setUpReflash];
    
    [self setupSearchView];
}
- (void)clickedit{
    bgview111111.hidden = NO;
}
- (void)clickadd{
    bgview.hidden = NO;
}
- (void)setupSearchView{
    Searchbgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Searchbgviewckickhid:)];
    [Searchbgview addGestureRecognizer:tap];
    Searchbgview.backgroundColor = [UIColor colorWithWhite:.95 alpha:.9];
    Searchbgview.hidden = YES;
    [[[UIApplication sharedApplication].delegate window]  addSubview:Searchbgview];
     [[[UIApplication sharedApplication].delegate window]  bringSubviewToFront:Searchbgview];
    
    UILabel *laab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, 100, 30)];
    laab1.text = @"ITEMNO";
    [Searchbgview addSubview:laab1];
    Searchtext1 = [[UITextField alloc]initWithFrame:CGRectMake(120, 100, SCREEN_WIDTH-130, 40)];
    Searchtext1.placeholder = @"ITEMNO";
    Searchtext1.delegate = self;
    Searchtext1.borderStyle = UITextBorderStyleRoundedRect;
    [Searchtext1.layer setBorderWidth:.5];
    [Searchtext1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [Searchbgview addSubview:Searchtext1];

    
    UILabel *laab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 100, 30)];
    laab2.text = @"MODEL";
    [Searchbgview addSubview:laab2];
    Searchtext2 = [[UITextField alloc]initWithFrame:CGRectMake(120, 175, SCREEN_WIDTH-130, 40)];
    Searchtext2.placeholder = @"MODEL";
    Searchtext2.delegate = self;
    Searchtext2.borderStyle = UITextBorderStyleRoundedRect;
    [Searchtext2.layer setBorderWidth:.5];
    [Searchtext2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [Searchbgview addSubview:Searchtext2];
    
    
    UILabel *laab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 255, 100, 30)];
    laab3.text = @"ITEM NAME";
    [Searchbgview addSubview:laab3];
    Searchtext3 = [[UITextField alloc]initWithFrame:CGRectMake(120, 250, SCREEN_WIDTH-130, 40)];
    Searchtext3.placeholder = @"ITEM NAME";
    Searchtext3.delegate = self;
    Searchtext3.borderStyle = UITextBorderStyleRoundedRect;
    [Searchtext3.layer setBorderWidth:.5];
    [Searchtext3.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [Searchbgview addSubview:Searchtext3];
    
   
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 340, SCREEN_WIDTH-40, 40);
    btn2.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn2 setTitle:@"开始检索" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(Searchclicksave) forControlEvents:UIControlEventTouchUpInside];
    [Searchbgview addSubview:btn2];
}
- (void)Searchbgviewckickhid:(UITapGestureRecognizer *)sender {
    [Searchtext1 resignFirstResponder];
    [Searchtext2 resignFirstResponder];
}

- (void)Searchclicksave{
    
    if (Searchtext1.text.length == 0) {
        Searchtext1.text = @"";
    }
    if (Searchtext2.text.length == 0) {
        Searchtext2.text = @"";
    }
    if (Searchtext3.text.length == 0) {
        Searchtext3.text = @"";
    }

    
    [Searchtext1 resignFirstResponder];
    [Searchtext2 resignFirstResponder];
    Searchbgview.hidden = YES;
 
    
    [self setUpReflash];
    
}
























- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    Searchbgview.hidden = NO;
    return NO;
}

- (void)setupvie {
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ckickhid:)];
    [bgview addGestureRecognizer:tap];
    
    bgview.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    UIView *iew = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-100, SCREEN_WIDTH-60, 160)];
    iew.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:iew];
    
    UILabel *laab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    laab1.text = @"ITEMNO";
    [iew addSubview:laab1];
    textf = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-160, 30)];
    textf.placeholder = @"ITEMNO";
    textf.delegate = self;
    textf.borderStyle = UITextBorderStyleRoundedRect;
    [textf.layer setBorderWidth:.5];
    [textf.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf];
    
    
    UILabel *laab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 80, 30)];
    laab2.text = @"实际售价";
    [iew addSubview:laab2];
    textf1 = [[UITextField alloc]initWithFrame:CGRectMake(90, 50, SCREEN_WIDTH-160, 30)];
    textf1.placeholder = @"实际售价";
    textf1.delegate = self;
    textf1.borderStyle = UITextBorderStyleRoundedRect;
    [textf1.layer setBorderWidth:.5];
    [textf1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf1];

    
    float wid = SCREEN_WIDTH-60;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 90, (wid-90)/2, 40);
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((wid-90)/2+60, 90, (wid-90)/2, 40);
    btn2.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicksave) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn2];
    
}
- (void)ckickhid:(UITapGestureRecognizer *)sender {
    [textf resignFirstResponder];
    [textf1 resignFirstResponder];
}
- (void)clickcancle{
    [textf resignFirstResponder];
    [textf1 resignFirstResponder];
    bgview.hidden = YES;
}
- (void)clicksave{
    if (textf.text.length != 0 && textf1.text.length != 0) {
        [self lodYZ];
    }
}






- (void)lodYZ{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"modeltype_id":self.idstr,
            @"skucode":textf.text
            };
    [session POST:KURLNSString(@"modelprice", @"getSkuInfo1") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"=========%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            [weakSelf lodadd];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}













- (void)lodadd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"modeltype_id":self.idstr,
            @"skucode":textf.text,
            @"realprice":textf1.text,
            };
    [session POST:KURLNSString(@"modelprice", @"add") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增成功" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增失败" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        //        NSLog(@"------%@",[dic objectForKey:@"result_msg"]);
        [textf resignFirstResponder];
        [textf1 resignFirstResponder];
        bgview.hidden = YES;
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"新增失败" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        [textf resignFirstResponder];
        [textf1 resignFirstResponder];
        bgview.hidden = YES;
    }];

}





- (void)setupvie1 {
    bgview111111 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ckickhidaaaa:)];
    [bgview111111 addGestureRecognizer:tap];
    
    bgview111111.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    bgview111111.hidden = YES;
    [self.view addSubview:bgview111111];
    [self.view bringSubviewToFront:bgview111111];
    UIView *iew = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-100, SCREEN_WIDTH-60, 160)];
    iew.backgroundColor = [UIColor whiteColor];
    [bgview111111 addSubview:iew];
    
    UILabel *laab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    laab1.text = @"MODEL";
    [iew addSubview:laab1];
    textf22222 = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-160, 30)];
    textf22222.placeholder = @"MODEL";
    textf22222.delegate = self;
    textf22222.borderStyle = UITextBorderStyleRoundedRect;
    [textf22222.layer setBorderWidth:.5];
    [textf22222.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf22222];
    
    
    UILabel *laab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 80, 30)];
    laab2.text = @"经销价";
    [iew addSubview:laab2];
    textf33333 = [[UITextField alloc]initWithFrame:CGRectMake(90, 50, SCREEN_WIDTH-160, 30)];
    textf33333.placeholder = @"经销价";
    textf33333.delegate = self;
    textf33333.borderStyle = UITextBorderStyleRoundedRect;
    [textf33333.layer setBorderWidth:.5];
    [textf33333.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [iew addSubview:textf33333];
    
    
    float wid = SCREEN_WIDTH-60;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 90, (wid-90)/2, 40);
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickcancle1111) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((wid-90)/2+60, 90, (wid-90)/2, 40);
    btn2.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicksave1111) forControlEvents:UIControlEventTouchUpInside];
    [iew addSubview:btn2];
    
}
- (void)ckickhidaaaa:(UITapGestureRecognizer *)sender {
    [textf22222 resignFirstResponder];
    [textf33333 resignFirstResponder];
}
- (void)clickcancle1111{
    [textf22222 resignFirstResponder];
    [textf33333 resignFirstResponder];
    bgview111111.hidden = YES;
}
- (void)clicksave1111{
    if (textf22222.text.length != 0 && textf33333.text.length != 0) {
        [self lodedit];
    }
}
- (void)lodedit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"modeltype_id":self.idstr,
            @"productcodeset":textf22222.text,
            @"realpriceset":textf33333.text,
            };
    [session POST:KURLNSString(@"modelprice", @"updatePriceByMODEL") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",[dic objectForKey:@"result_msg"]);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        //        NSLog(@"------%@",[dic objectForKey:@"result_msg"]);
        [textf22222 resignFirstResponder];
        [textf33333 resignFirstResponder];
        bgview111111.hidden = YES;
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[dic objectForKey:@"result_msg"] preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        [textf33333 resignFirstResponder];
        [textf22222 resignFirstResponder];
        bgview111111.hidden = YES;
    }];
    
}












- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 275+height1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Xiao_Jia_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Xiaojia_Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.skucode;
    cell.lab2.text = model.bizcode;
    
    
    
    if (model.skuname.length == 0 || [model.skuname isEqual:[NSNull null]]) {
        cell.lab3.text = @"-";
        cell.lab3.numberOfLines = 0;
        cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT)];
        height1 = size2.height;
        cell.height1.constant = height1;
        cell.top1.constant = size2.height - 10;
    }else{
        cell.lab3.text = model.skuname;
        cell.lab3.numberOfLines = 0;
        cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT)];
        height1 = size2.height;
        cell.height1.constant = height1;
        cell.top1.constant = size2.height - 10;
    }
    
    
    
    
    cell.lab4.text = model.productcode;
    cell.lab5.text = [Manager jinegeshi:model.costprice];
    cell.lab6.text = [Manager jinegeshi:model.listprice];
    cell.lab7.text = [Manager jinegeshi:model.realprice];
    cell.lab8.text = model.typename;
    cell.lab9.text = [Manager timezhuanhuan:model.createtime];
    return cell;
}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}

- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    page = 1;
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"modeltype_id":self.idstr,
            @"skucode":Searchtext1.text,
            @"productcode":Searchtext2.text,
            @"skuname":Searchtext3.text,
            };
    [session POST:KURLNSString(@"modelprice", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"--------%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary *dicc in arr) {
                Xiaojia_Model *model = [Xiaojia_Model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
            
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
        }
        page=2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList {
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",(long)page],
            @"modeltype_id":self.idstr,
            @"skucode":Searchtext1.text,
            @"productcode":Searchtext2.text,
            @"skuname":Searchtext3.text,
            };
    
    [session POST:KURLNSString(@"modelprice", @"list") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dicc in arr) {
                Xiaojia_Model *model = [Xiaojia_Model mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }else {
            [[Manager sharedManager] tishiyu:@"请求失败！" controller:weakSelf];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[Manager sharedManager] tishi:error controller:weakSelf];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}










- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
















@end
