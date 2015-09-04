//
//  RETableViewCell.m
//  BanBen2
//
//  Created by lanou3g on 15/8/4.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "RETableViewCell.h"

@implementation RETableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutView];
    }
    
    return self;
}

-(void)layoutView{
    //图片
    self.REImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:_REImageView];
    
    //标题
    self.RETitle=[[UILabel alloc] init];
//    _RETitle.backgroundColor=[UIColor redColor];
    _RETitle.numberOfLines=0;
    _RETitle.font=[UIFont fontWithName:nil size:16];
    [self.contentView addSubview:_RETitle];
    
    
    [self p_fram];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self p_fram];
}

-(void)p_fram{
    
    _REImageView.frame=CGRectMake(5, 5, CGRectGetWidth(self.contentView.frame)-10, ImageH-30);
    self.RETitle.frame=CGRectMake(CGRectGetMinX(_REImageView.frame), CGRectGetMaxY(_REImageView.frame)+30, CGRectGetWidth(_REImageView.frame), CGRectGetHeight(self.contentView.frame)-15-ImageH);
    
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
}

@end
