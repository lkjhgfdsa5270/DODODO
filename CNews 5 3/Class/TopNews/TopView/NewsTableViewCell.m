//
//  NewsTableViewCell.m
//  BanBen1
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutView];
    }
    
    return self;
}



-(void)layoutView{
    //图片
    self.newsImageView=[[UIImageView alloc] init];
    _newsImageView.frame=CGRectMake(5, 5, 100, CGRectGetHeight(self.contentView.frame)-10);
    [self.contentView addSubview:_newsImageView];
    //标题
    self.newsTitle=[[UILabel alloc] init];
    self.newsTitle.frame=CGRectMake(CGRectGetMaxX(_newsImageView.frame)+10, CGRectGetMinY(_newsImageView.frame), CGRectGetWidth(self.contentView.frame)-CGRectGetWidth(_newsImageView.frame)-5-10-5, 23);
//    _newsTitle.backgroundColor=[UIColor redColor];
    _newsTitle.numberOfLines=0;
    
    [self.contentView addSubview:_newsTitle];
    //简介
    self.newsIntroduction=[[UILabel alloc] init];
    _newsIntroduction.frame=CGRectMake(CGRectGetMinX(_newsTitle.frame), CGRectGetMaxY(_newsTitle.frame)+10, CGRectGetWidth(_newsTitle.frame), 40);
    _newsIntroduction.numberOfLines=0;
//        _newsIntroduction.backgroundColor=[UIColor redColor];
    _newsIntroduction.font=[UIFont fontWithName:nil size:14];
    [self.contentView addSubview:_newsIntroduction];
    
    
 
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    _newsImageView.frame=CGRectMake(5, 5, 100, CGRectGetHeight(self.contentView.frame)-10);
    
    self.newsTitle.frame=CGRectMake(CGRectGetMaxX(_newsImageView.frame)+10, CGRectGetMinY(_newsImageView.frame), CGRectGetWidth(self.contentView.frame)-CGRectGetWidth(_newsImageView.frame)-5-10-5, 23);
    self.newsIntroduction.frame=CGRectMake(CGRectGetMinX(_newsTitle.frame), CGRectGetMaxY(_newsTitle.frame)+10, CGRectGetWidth(_newsTitle.frame), 40);
}


@end
