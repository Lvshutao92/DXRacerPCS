//
//  MainTabbarViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "Two_Place_ViewController.h"
#import "FourViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController
- (instancetype)init {
    if (self = [super init]) {
        OneViewController *oneVc = [[OneViewController alloc]init];
        MainNavigationViewController *mainoneVC = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        mainoneVC.title = @"主页";
        oneVc.navigationItem.title = @"";
        mainoneVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_2"];
        mainoneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_02"];
        
        
        
            Two_Place_ViewController *two1Vc = [[Two_Place_ViewController alloc]init];
            MainNavigationViewController *main1twoVC = [[MainNavigationViewController alloc]initWithRootViewController:two1Vc];
            two1Vc.title = @"订单";
            main1twoVC.tabBarItem.image = [UIImage imageNamed:@"tabbar3"];
            main1twoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar03"];
        
        
            TwoViewController *twoVc = [[TwoViewController alloc]init];
            MainNavigationViewController *maintwoVC = [[MainNavigationViewController alloc]initWithRootViewController:twoVc];
            twoVc.title = @"订单";
            maintwoVC.tabBarItem.image = [UIImage imageNamed:@"tabbar3"];
            maintwoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar03"];
        
        
        
        
        ThreeViewController *threeVc = [[ThreeViewController alloc]init];
        MainNavigationViewController *mainthreeVC = [[MainNavigationViewController alloc]initWithRootViewController:threeVc];

        threeVc.title = @"购物";
        mainthreeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar01"];
        mainthreeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar1"];
        
        
        FourViewController *fourVc = [[FourViewController alloc]init];
        MainNavigationViewController *mainfourVC = [[MainNavigationViewController alloc]initWithRootViewController:fourVc];
        mainfourVC.title = @"公告";
        fourVc.navigationItem.title = @"公告";
        mainfourVC.tabBarItem.image = [UIImage imageNamed:@"tabbar4"];
        mainfourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar04"];
        
        self.tabBar.tintColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
        
        if ([[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务主管"] || [[Manager redingwenjianming:@"rolename.text"] isEqualToString:@"财务收款专员"]){
            self.viewControllers = @[mainoneVC,mainfourVC];
        }else{
            self.viewControllers = @[mainoneVC,mainfourVC];
        }
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
@end
