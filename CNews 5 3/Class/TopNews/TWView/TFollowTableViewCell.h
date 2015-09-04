//
//  TFollowTableViewCell.h
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFollowTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *TFunOnePicImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (strong, nonatomic) IBOutlet UILabel *digestLabel;



@property(strong,nonatomic)TModel * model;

@end
