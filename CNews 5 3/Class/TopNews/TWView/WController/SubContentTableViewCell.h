//
//  SubContentTableViewCell.h
//  news
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubContentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tname;
@property (strong, nonatomic) IBOutlet UILabel *subNumber;
@property(strong,nonatomic)TodayModel *model;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@end
