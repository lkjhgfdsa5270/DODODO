//
//  TFunOnePictureTableViewCell.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TFunOnePictureTableViewCell.h"

@implementation TFunOnePictureTableViewCell


- (void)setModel:(TModel *)model{
    
    self.titleLabel.text = model.title;
    self.digestLabel.text = model.digest;
    

        [self.TFunOnePicImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];


}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
