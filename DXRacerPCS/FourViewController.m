//
//  FourViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/8/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "FourViewController.h"
#import "GongGaoModel.h"
#import "WebViewController.h"
@interface FourViewController ()
{
    NSInteger page;
    NSInteger totalNum;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation FourViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self lodSLList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GongGaoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    WebViewController *webview = [[WebViewController alloc]init];
   
    webview.webStr = model.ann_content;
    
    [self.navigationController pushViewController:webview animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GongGaoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text= model.ann_theme;
    return cell;
}


- (void)lodSLList {
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = @{@"business_id":[Manager redingwenjianming:@"business_id.text"],
            };
    [session POST:KURLNSString(@"announce", @"getIndexAnnounce") parameters:[Manager returndiction:dic] constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *array = [[dic objectForKey:@"rows"] objectForKey:@"annoList"];
        totalNum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        for (NSDictionary *dic in array) {
            GongGaoModel *model = [GongGaoModel mj_objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


@end
