//
//  MySubscriptionTableViewCell.h
//  news
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySubscriptionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *bigImgView;

@property (strong, nonatomic) IBOutlet UIImageView *secondImgView;

@property (strong, nonatomic) IBOutlet UIImageView *thirdImgView;

@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

- (IBAction)deleteButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic,strong)ReadModel * model;

@end
