//
//  SubContentTableViewCell.m
//  news
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "SubContentTableViewCell.h"

@implementation SubContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(TodayModel *)model{
    self.tname.text =model.tname;
    self.subNumber.text=[NSString stringWithFormat:@"%@订阅",model.subnum];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
