//
//  TnameTableViewCell.m
//  news
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "TnameTableViewCell.h"

@implementation TnameTableViewCell

-(void)setModel:(TodayModel *)model{
    
    self.titlelabel.text =model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
