//
//  TodayModel.h
//  news
//
//  Created by lanou3g on 15/8/25.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayModel : NSObject

@property(nonatomic,strong)NSString *docid;//编号
@property(nonatomic,strong)NSString *title;//主题
@property(nonatomic,strong)NSString *digest;//摘要
@property(nonatomic,strong)NSString *subnum;//订阅人数
@property(nonatomic,strong)NSString *tid;//id

@property(nonatomic,strong)NSString *tname;//名字
@property(nonatomic,strong)NSString *imgsrc;//图片

@property(nonatomic,strong)NSString * ptime;//日期
@property(nonatomic,strong)NSString * source;//新闻来源
@property(nonatomic,strong)NSString * body;//新闻内容



@end
