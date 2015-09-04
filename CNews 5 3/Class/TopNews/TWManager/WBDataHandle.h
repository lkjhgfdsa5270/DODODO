//
//  WBDataHandle.h
//  news
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadModel.h"
@interface WBDataHandle : NSObject

//接收所有的model对象
@property (nonatomic,strong)NSMutableArray *allModelArray;

//单例
+ (instancetype)defaultDataHandel;

//请求数据并把数组传过去
- (void)requestDataDidFinish:(void(^)(NSMutableArray * modelArray))block;

//根据区的个数返回model
- (ReadModel *)getModelWithIndex:(NSInteger)index;

//返回数组的个数
- (NSInteger)getArrayCount;

@end
