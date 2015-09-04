//
//  TFunThreePicTableViewCell.h
//  网易新闻
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFunThreePicTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *TFunThreePicTitle;

@property (strong, nonatomic) IBOutlet UIImageView *ThreePicImgView1;

@property (strong, nonatomic) IBOutlet UIImageView *ThreePicImgView2;

@property (strong, nonatomic) IBOutlet UIImageView *ThreePicImgView3;


@property(strong,nonatomic)TModel * model;

@end
