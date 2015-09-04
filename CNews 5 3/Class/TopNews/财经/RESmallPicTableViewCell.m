//
//  RESmallPicTableViewCell.m
//  BanBen2
//
//  Created by lanou3g on 15/8/12.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "RESmallPicTableViewCell.h"

@implementation RESmallPicTableViewCell

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
//        _RETitle.backgroundColor=[UIColor redColor];
    _RETitle.numberOfLines=0;
    [self.contentView addSubview:_RETitle];
    
    
    
    [self p_fram];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self p_fram];
}

-(void)p_fram{
    
    _REImageView.frame=CGRectMake(5, 5, 100, CGRectGetHeight(self.contentView.frame)-10);
    self.RETitle.frame=CGRectMake(CGRectGetMaxX(_REImageView.frame)+10, 5, CGRectGetWidth(self.contentView.frame)-CGRectGetWidth(_REImageView.frame)-5-10-5, CGRectGetHeight(self.contentView.frame)-10);
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
