//
//  LiveTableViewCell.m
//  Live
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LiveTableViewCell.h"
#import "LiveModel.h"
#import "UIImageView+WebCache.h"

@implementation LiveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellToModel:(LiveModel *)model
{
    self.titleLabel.text = model.title;
    [self.ImagePicView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil options:SDWebImageDelayPlaceholder];
}


@end
