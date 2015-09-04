//
//  TFollowListViewController.h
//  网易新闻
//
//  Created by lanou3g on 15/8/25.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFollowListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *TFollowWebView;

@property(strong,nonatomic)TModel * model;

@end
