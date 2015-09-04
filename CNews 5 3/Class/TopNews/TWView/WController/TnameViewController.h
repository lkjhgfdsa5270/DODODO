//
//  TnameViewController.h
//  news
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TnameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *TnameTableView;

@property(nonatomic,strong)NSString * tid;//接收传过来的tid;
@property(nonatomic,strong)NSString *tname;//标题


@end
