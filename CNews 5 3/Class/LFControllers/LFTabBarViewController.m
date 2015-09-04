//
//  LFTabBarViewController.m
//  微博
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "LFTabBarViewController.h"


#import "LFNavigationController.h"
#import "IWTabar.h"
#import "NewsViewController.h"
#import "LoginCollectionViewController.h"
#import "MovieTableViewController.h"
#import "XqLiveViewController.h"
#import "LiveTableViewController.h"

#import "ReadingViewController.h"
#import "TFunViewController.h"
//#import "LFNavigationController.h"
@interface LFTabBarViewController ()
@property(nonatomic ,weak)IWTabar * customTabBar;
@end

@implementation LFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];

    [self setupAllChildControllers];
   }

-(void)setupTabbar{
    IWTabar * customTabBar=[[IWTabar alloc] init];
   // customTabBar.backgroundColor = [UIColor purpleColor];
    [self.tabBar addSubview:customTabBar];
    
    customTabBar.frame = self.tabBar.bounds;
    self.customTabBar  = customTabBar;
    customTabBar.delegate = self;

}
#pragma mark----执行代理
//监听taBar的改变

-(void)taBar:(IWTabar *)taBer didselectedButtonFrom:(long)from to:(long)to{
    self.selectedIndex = to;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)setupAllChildControllers{

    //首页
    
    
       NewsViewController * topNew = [[NewsViewController alloc] init];
 
       [self setupChildViewConttroller:topNew title:@"新闻" imageName:@"a55-1.png" selectedImageName:@"a55-1.png"];
    
    

    
    //新闻
    TFunViewController * newsVC =[[TFunViewController alloc]init];
   


     [self setupChildViewConttroller:newsVC title:@"娱乐" imageName:@"a44.png" selectedImageName:@"a44.png"];
    
    //视听
    LiveTableViewController * movieLV = [[LiveTableViewController alloc] init];
    [self setupChildViewConttroller:movieLV title:@"视听" imageName:@"a11.png" selectedImageName:@"a11.png"];
    

    
    
    //阅读
    ReadingViewController * readVC = [[ReadingViewController alloc]init];
    
    [self setupChildViewConttroller:readVC title:@"阅读" imageName:@"a22.png" selectedImageName:@"a22.png"];
    //我
    LoginCollectionViewController * loginVC = [[LoginCollectionViewController alloc] init];
    [self setupChildViewConttroller:loginVC title:@"我" imageName:@"a35.png"
                  selectedImageName:@"a35.png"];

    
}

-(void)setupChildViewConttroller:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imagename selectedImageName:(NSString *)selectedimagename{


    childVC.title = title;

    LFNavigationController * NC = [[LFNavigationController alloc] initWithRootViewController:childVC];
    childVC.tabBarItem.image = [UIImage imageNamed:imagename];
    UIImage * seletedImage = [UIImage imageNamed:selectedimagename];

        childVC.tabBarItem.selectedImage = [seletedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.customTabBar addTabBarButtonWithTitle:(childVC.tabBarItem)];
    
    [self addChildViewController:NC];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

@end
