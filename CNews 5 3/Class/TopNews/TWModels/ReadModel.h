//
//  ReadModel.h
//  news
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject
@property(nonatomic,strong)NSString * title;//标题
@property(nonatomic,strong)NSString * source;//来源
@property(nonatomic,strong)NSString * prompt;//推荐20条内容
@property(nonatomic,strong)NSString * digest;//摘要
@property(nonatomic,strong)NSString * img;//图片
@property(nonatomic,strong)NSString * docid;//编号

@property(nonatomic,copy)NSArray * imgnewextra;//图片数组(里面有2张图片)

@end
