//
//  TnameTableViewCell.h
//  news
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TnameTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titlelabel;

@property(nonatomic,strong)TodayModel *model;



@end
