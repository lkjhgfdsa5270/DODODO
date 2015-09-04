//
//  JokeModel.h
//  网易新闻
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject

@property(nonatomic,strong)NSString * title;//标题

@property(nonatomic,strong)NSString * digest;//正文

@property(nonatomic,assign)NSInteger  downTimes;//踩

@property(nonatomic,assign)NSInteger  upTimes;//点赞

@property(nonatomic,strong)NSString * img;//首页图片url


@end
