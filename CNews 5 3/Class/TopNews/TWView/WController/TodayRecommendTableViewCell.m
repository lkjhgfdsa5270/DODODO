//
//  TodayRecommendTableViewCell.m
//  news
//
//  Created by lanou3g on 15/8/25.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "TodayRecommendTableViewCell.h"

@implementation TodayRecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(TodayModel *)model{
    
    self.tname.text =model.tname;
    self.subnumLabel.text=[NSString stringWithFormat:@"%@订阅",model.subnum];
    self.digestlabel.text=model.digest;
    self.titleLabel.text =model.title;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






- (void)getModel:(void(^)(TodayModel* model))block{
    
    
    
    
}




@end
