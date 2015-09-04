//
//  LFNavigationController.m
//  微博
//
//  Created by lanou3g on 15/8/13.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "LFNavigationController.h"

@interface LFNavigationController ()

@end

@implementation LFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////重写push方法
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.viewControllers.count >0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    [super pushViewController:viewController animated:YES];
//    
//}
+(void)initialize{

   //设置导航栏主题
//设置背景
//[self setupNavbarTeme];
    //设置导航栏的按钮主题
   // [self setupNavbarTemeTheme];
}

+(void)setupNavbarTemeTheme{
    UIBarButtonItem * item= [UIBarButtonItem appearance];

        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_send_background_disabled"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
}
  
//第一次使用这个类的时候就会调用一次


@end
