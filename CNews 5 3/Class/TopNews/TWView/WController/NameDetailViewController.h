//
//  NameDetailViewController.h
//  news
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *ptimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLebel;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *bodyLbel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)NSString * docid ;//接收传过来的编号

@end
