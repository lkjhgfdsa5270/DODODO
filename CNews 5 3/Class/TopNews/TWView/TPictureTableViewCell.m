//
//  TPictureTableViewCell.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TPictureTableViewCell.h"



@implementation TPictureTableViewCell


- (void)setPicModel:(PicModel *)picModel{
    
    

        [self.picImgView sd_setImageWithURL:[NSURL URLWithString:picModel.cover]];
   
        
 
   
}






- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
