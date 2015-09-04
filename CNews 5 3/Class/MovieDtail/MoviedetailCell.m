//
//  MoviedetailCell.m
//  SeeingAndHearing
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MoviedetailCell.h"

@implementation MoviedetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setview];
    }
    return self;
}
-(void)p_setview{
    self.titleLable = [[UILabel alloc]init];
    _titleLable.frame = CGRectMake(5, 0, CGRectGetWidth(self.contentView.frame)-50, CGRectGetHeight(self.contentView.frame));
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_titleLable];
    
    self.Myimage = [[UIImageView alloc]init];
    self.Myimage.backgroundColor = [UIColor clearColor];
    _Myimage.frame = CGRectMake(CGRectGetMaxX(_titleLable.frame), CGRectGetMinY(self.titleLable.frame),CGRectGetWidth(self.contentView.frame)- CGRectGetWidth(_titleLable.frame), CGRectGetHeight(_titleLable.frame));
    [self.contentView addSubview:_Myimage];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLable.frame = CGRectMake(5, 0, CGRectGetWidth(self.contentView.frame)-50, CGRectGetHeight(self.contentView.frame));
    _Myimage.frame = CGRectMake(CGRectGetMaxX(_titleLable.frame), CGRectGetMinY(self.titleLable.frame),CGRectGetMaxX(self.contentView.frame)- CGRectGetWidth(_titleLable.frame), CGRectGetHeight(_titleLable.frame));
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
