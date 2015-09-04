//
//  TodayRecommendTableViewCell.h
//  news
//
//  Created by lanou3g on 15/8/25.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayModel.h"
@interface TodayRecommendTableViewCell : UITableViewCell

@property(nonatomic,strong)TodayModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *tname;

@property (strong, nonatomic) IBOutlet UILabel *subnumLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *digestlabel;


@property (strong, nonatomic) IBOutlet UIButton *Button;



@end
