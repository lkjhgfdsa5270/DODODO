//
//  NewsLoopTableViewCell.m
//  BanBen1
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "NewsLoopTableViewCell.h"

@implementation NewsLoopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutView];
    }
    return self;
}
//布局 cell
-(void)layoutView{
    //轮播图图片
    self.newsLoopImageView=[[UIImageView alloc] init];
    _newsLoopImageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
   // self.contentView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_newsLoopImageView];
    
    //轮播图文字
//    self.newsLoopTitle=[[UILabel alloc] init];
//    _newsLoopTitle.frame=CGRectMake(CGRectGetMaxX(_newsLoopImageView.frame), CGRectGetMaxY(_newsLoopImageView.frame)-30, 200, 17);
//    _newsLoopTitle.backgroundColor=[UIColor redColor];
//    _newsLoopTitle.text=@"轮播图在哪里";
//    _newsLoopTitle.font=[UIFont fontWithName:nil size:17];
//    _newsLoopTitle.textAlignment=NSTextAlignmentCenter;
//    [_newsLoopImageView addSubview:_newsLoopTitle];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _newsLoopImageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
