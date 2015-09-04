//
//  LiveTableViewCell.h
//  Live
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiveModel;

@interface LiveTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImagePicView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

-(void)setCellToModel:(LiveModel *)model;


@end
