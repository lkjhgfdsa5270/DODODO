//
//  PETableViewCell.m
//  BanBen2
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "PETableViewCell.h"

@implementation PETableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutView];
    }
    
    return self;
}

-(void)layoutView{
    //图片
    self.PEImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:_PEImageView];
    //标题
    self.PETitle=[[UILabel alloc] init];
//    _PETitle.backgroundColor=[UIColor redColor];
    _PETitle.numberOfLines=0;
    [self.contentView addSubview:_PETitle];
    

    
    [self p_fram];
   }

-(void)layoutSubviews{
    [super layoutSubviews];

    [self p_fram];
}

-(void)p_fram{
    
    _PEImageView.frame=CGRectMake(5, 5, 100, CGRectGetHeight(self.contentView.frame)-10);
    self.PETitle.frame=CGRectMake(CGRectGetMaxX(_PEImageView.frame)+10, 5, CGRectGetWidth(self.contentView.frame)-CGRectGetWidth(_PEImageView.frame)-5-10-5, CGRectGetHeight(self.contentView.frame)-10);
    
}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
