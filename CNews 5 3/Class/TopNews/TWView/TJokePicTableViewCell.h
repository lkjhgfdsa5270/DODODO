//
//  TJokePicTableViewCell.h
//  网易新闻
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJokePicTableViewCell : UITableViewCell

@property(nonatomic,strong)JokeModel * jokeModel;


@property (strong, nonatomic) IBOutlet UILabel *jokeTitleLabel;//标题

@property (strong, nonatomic) IBOutlet UILabel *jokeDigestLabel;//正文




@property (strong, nonatomic) IBOutlet UILabel *jokeUpLabel;//点赞

@property (strong, nonatomic) IBOutlet UILabel *jokeDownLabel;//踩


- (CGFloat)getTextLabelHeight:(NSString *)text;//计算文本内容大小

@end
