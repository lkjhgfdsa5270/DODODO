//
//  TFollowListTableViewCell.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TFollowListTableViewCell.h"

@implementation TFollowListTableViewCell


- (void)setModel:(TModel *)model{
    
    self.TFunThreePicTitle.text = model.title;
    
    
    
    
    NSArray * array = model.imgextra;
    
    NSMutableArray * strArray = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        NSString * str = dic[@"imgsrc"];
        [strArray addObject:str];
    }
    

        [self.ThreePicImgView1 sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
           [self.ThreePicImgView2 sd_setImageWithURL:[NSURL URLWithString:strArray[0]]];
    [self.ThreePicImgView3 sd_setImageWithURL:[NSURL URLWithString:strArray[1]]];
        
  
    
 
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
