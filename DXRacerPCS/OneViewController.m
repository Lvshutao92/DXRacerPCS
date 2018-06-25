//
//  OneViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "OneViewController.h"
#import "CustomButton.h"

#import "TopUpViewController.h"
#import "TopUpCenterOneViewController.h"
#import "TopUpTwoViewController.h"
#import "TopUpCenterThreeViewController.h"
#import "TopUpCenterFourViewController.h"



#import "BaoBiaoViewController.h"
#import "BB_OneViewController.h"
#import "BB_TwoViewController.h"

#import "JingXiaoShangViewController.h"
#import "UserViewController.h"

#import "GongGaoModel.h"
#import "GongGaoViewController.h"
#import "Order_ViewController.h"
@interface OneViewController ()
{
    UILabel *lab;
}
@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)NSMutableArray *dataSourceArray;

@property(nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic, strong)NSMutableArray *imgArray;



@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"迪锐克斯";
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.scrollview];
    
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220*SCALE_HEIGHT)];
    headView.backgroundColor = RGBACOLOR(230, 243, 242, 1.0);
    [self.scrollview addSubview:headView];
    
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 65*SCALE_HEIGHT,80*SCALE_HEIGHT, 80*SCALE_HEIGHT)];
    self.userImageView.layer.cornerRadius = 40;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageview:)];
    [headView addGestureRecognizer:tap];
    UIImage *theImage = [UIImage imageNamed:@"user"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.userImageView.image = theImage;
    self.userImageView.tintColor = RGBACOLOR(32, 157, 149, 1.0);
    [headView addSubview:self.userImageView];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 65*SCALE_HEIGHT + 90*SCALE_HEIGHT, SCREEN_WIDTH-40, 50*SCALE_HEIGHT)];
    lab.numberOfLines = 0;
    lab.text = [NSString stringWithFormat:@"%@\n%@",[Manager redingwenjianming:@"username.text"],[Manager redingwenjianming:@"rolename.text"]];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor lightGrayColor];
    [headView addSubview:lab];
    
    [self.view addSubview:self.scrollview];
    
//    NSLog(@"%@",[Manager redingwenjianming:@"rolename.text"]);

    if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务收款专员"]) {
        self.dataSourceArray = [@[@"充值中心",@"公告"]mutableCopy];//翁玉菲
        self.imgArray = [@[@"01",@"05"]mutableCopy];
    }else if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"经销商管理员"]) {
        self.dataSourceArray = [@[@"报表中心",@"订单管理",@"经销商",@"公告"]mutableCopy];//朱蓉
        self.imgArray = [@[@"02",@"03",@"04",@"05"]mutableCopy];
    }else if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务主管"]) {
        self.dataSourceArray = [@[@"充值中心",@"经销商",@"公告"]mutableCopy];//方雅凤
        self.imgArray = [@[@"01",@"04",@"05"]mutableCopy];
    }else{
        self.dataSourceArray = [@[@"充值中心",@"报表中心",@"订单管理",@"经销商",@"公告"]mutableCopy];
        self.imgArray = [@[@"01",@"02",@"03",@"04",@"05"]mutableCopy];
    }
    
    
     
    
    [self setbutton];
    
    
    
}


- (void)clickImageview:(UITapGestureRecognizer *)sender{
    UserViewController *user = [[UserViewController alloc]init];
    user.navigationItem.title = @"设置";
    [self.navigationController pushViewController:user animated:YES];
}



- (void)setbutton {
    
    int b = 0;
    int hangshu;
    if (self.dataSourceArray.count % 3 == 0 ) {
        hangshu = (int )self.dataSourceArray.count / 3;
    } else {
        hangshu = (int )self.dataSourceArray.count / 3 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 3; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < self.dataSourceArray.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/3), 220*SCALE_HEIGHT + i * 120*SCALE_HEIGHT,SCREEN_WIDTH/3, 120*SCALE_HEIGHT);
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = b;
                [btn setTitle:self.dataSourceArray[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, i * 120*SCALE_HEIGHT + 350*SCALE_HEIGHT)];
                
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArray[b]]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                [btn.layer setBorderWidth:0.5f];
                [btn.layer setMasksToBounds:YES];
                [self.scrollview addSubview:btn];
                if (b > self.dataSourceArray.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}

- (void)clickButton:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"充值中心"]) {
        TopUpViewController *vc = [[TopUpViewController alloc] initWithAddVCARY:@[[TopUpCenterOneViewController new],[TopUpTwoViewController new],[TopUpCenterThreeViewController new],[TopUpCenterFourViewController new]] TitleS:@[@"充值审核",@"充值记录",@"消费流水",@"收款账户"]];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"报表中心"]) {
        
        if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"经销商管理员"]){
            BB_OneViewController *vc = [[BB_OneViewController alloc] init];
            vc.navigationItem.title = @"报表中心";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BaoBiaoViewController *vc = [[BaoBiaoViewController alloc] initWithAddVCARY:@[[BB_OneViewController new],[BB_TwoViewController new]] TitleS:@[@"订单利润",@"货物货款"]];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"订单管理"]) {
        Order_ViewController *jnigxiaoshang = [[Order_ViewController alloc]init];

        jnigxiaoshang.navigationItem.title = @"订单列表";
        [self.navigationController pushViewController:jnigxiaoshang animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"经销商"]) {
        JingXiaoShangViewController *jnigxiaoshang = [[JingXiaoShangViewController alloc]init];

        [self.navigationController pushViewController:jnigxiaoshang animated:YES];
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"公告"]) {
        GongGaoViewController *jnigxiaoshang = [[GongGaoViewController alloc]init];
        jnigxiaoshang.navigationItem.title = @"公告中心";
        [self.navigationController pushViewController:jnigxiaoshang animated:YES];
    }
}











- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}
- (NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        self.imgArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArray;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
@end
