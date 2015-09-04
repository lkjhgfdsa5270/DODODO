//
//  PELabelTableViewCell.m
//  BanBen2
//
//  Created by lanou3g on 15/8/3.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "PELabelTableViewCell.h"

@implementation PELabelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutView];
    }
    
    return self;
}

-(void)layoutView{
    //标题
    self.PElabelTitle=[[UILabel alloc] init];
//    _PElabelTitle.backgroundColor=[UIColor redColor];
    _PElabelTitle.numberOfLines=0;
    [self.contentView addSubview:_PElabelTitle];
    
    [self p_fram];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self p_fram];
}

-(void)p_fram{
    
    self.PElabelTitle.frame=CGRectMake(5,5, CGRectGetWidth(self.contentView.frame)-10, CGRectGetHeight(self.contentView.frame)-10);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
