//
//  NewsPicTableViewCell.m
//  BanBen1
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "NewsPicTableViewCell.h"

@implementation NewsPicTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutView];
    }
    
    return self;
}



-(void)layoutView{
    //标题
    self.newsPicTitle=[[UILabel alloc] init];
//    _newsPicTitle.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:_newsPicTitle];
    //图片
    self.newsPicImageView1=[[UIImageView alloc] init];
    [self.contentView addSubview:_newsPicImageView1];
    
    self.newsPicImageView2=[[UIImageView alloc] init];
    [self.contentView addSubview:_newsPicImageView2];

    self.newsPicImageView3=[[UIImageView alloc] init];
    [self.contentView addSubview:_newsPicImageView3];
    
    [self p_fram];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self p_fram];
    
}
-(void)p_fram{
    _newsPicTitle.frame=CGRectMake(5, 5, CGRectGetWidth(self.frame)-5-5, 17);
    _newsPicImageView1.frame=CGRectMake(CGRectGetMinX(_newsPicTitle.frame), CGRectGetMaxY(_newsPicTitle.frame)+5, (CGRectGetWidth(self.frame)-5-10-10-5)/3, CGRectGetHeight(self.contentView.frame)-5-CGRectGetHeight(_newsPicTitle.frame)-5-5);
    _newsPicImageView2.frame=CGRectMake(CGRectGetMaxX(_newsPicImageView1.frame)+10, CGRectGetMinY(_newsPicImageView1.frame), CGRectGetWidth(_newsPicImageView1.frame), CGRectGetHeight(_newsPicImageView1.frame));
    _newsPicImageView3.frame=CGRectMake(CGRectGetMaxX(_newsPicImageView2.frame)+10, CGRectGetMinY(_newsPicImageView2.frame), CGRectGetWidth(_newsPicImageView2.frame), CGRectGetHeight(_newsPicImageView2.frame));
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
