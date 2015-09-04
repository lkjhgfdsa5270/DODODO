//
//  RecommendedTableViewCell.h
//  news
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedTableViewCell : UITableViewCell
@property (nonatomic,strong)ReadModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *source;

@property (strong, nonatomic) IBOutlet UILabel *title;
- (IBAction)deletetCellBt:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deleteCellBt;

@end
