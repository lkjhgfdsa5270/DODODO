//
//  TModel.h
//  网易新闻
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TModel : NSObject

@property(nonatomic,strong)NSString * title;//标题

@property(nonatomic,strong)NSString * imgsrc;//首页图片url

@property(nonatomic,strong)NSString * digest;//首页(详情页面)详情

@property(nonatomic,strong)NSString * url_3w;//详情页面图集

@property(nonatomic,strong)NSString * url;//详情页面报道url

@property(nonatomic,strong)NSString * ptime;//详情页面时间

@property(nonatomic,strong)NSArray * imgextra;//图片数量

@property(nonatomic,strong)NSArray * ads;//第二张图片

@property(nonatomic,strong)NSString * skipID;//


@end
