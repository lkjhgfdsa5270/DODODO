//
//  TJokePicTableViewCell.m
//  网易新闻
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TJokePicTableViewCell.h"

@implementation TJokePicTableViewCell

- (void)setJokeModel:(JokeModel *)jokeModel{
    
    
    
    
     CGFloat height = [self getTextLabelHeight:jokeModel.digest];
    
    CGRect frame = self.jokeDigestLabel.frame;
    frame.size.height = height;
    self.jokeDigestLabel.frame = frame;
    
    
    
    self.jokeTitleLabel.text = jokeModel.title;
    self.jokeDigestLabel.text = jokeModel.digest;
    self.jokeUpLabel.text = [NSString stringWithFormat:@"%ld",(long)jokeModel.upTimes];
    self.jokeDownLabel.text = [NSString stringWithFormat:@"%ld",(long)jokeModel.downTimes];
    
}

//计算文本内容大小
- (CGFloat)getTextLabelHeight:(NSString *)text{
    
   // CGSize size = self.jokeDigestLabel.frame.size;
    
    CGSize size = CGSizeMake([[UIScreen mainScreen]bounds].size.width-20, 22222);
    
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height;
    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
