//
//  RecommendedTableViewCell.m
//  news
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "RecommendedTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation RecommendedTableViewCell

- (void)awakeFromNib {
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//model set方法
-(void)setModel:(ReadModel *)model{
//    //让label自适应高度
//    
//    //设置行数
//    self.title.numberOfLines =0;
//    
//    //设置字体
//    self.title.font=[UIFont systemFontOfSize:15.0];
//    
//    //设置宽高
//    CGSize size = CGSizeMake(100, 200000);
//    
//    //计算高度
//    CGRect rect = [self.model.title boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
//    
//    //设置title的位置和高度
//    self.title.frame=CGRectMake(150 , 20, rect.size.width, rect.size.height);
    
    
    self.title.text=model.title;
    self.source.text =model.source;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
}


- (IBAction)deletetCellBt:(id)sender {

  
    
}
@end
