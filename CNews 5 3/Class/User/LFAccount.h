//
//  LFAccount.h
//  微博
//
//  Created by lanou3g on 15/8/16.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFAccount : NSObject<NSCoding>
//若果数字大就用 long long

@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * netWoring;
@property(nonatomic,strong)NSString * NameUser;
@property(nonatomic,strong)NSString * UserImageUrl;


+(instancetype)accountWithDic:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)CollectionName;
+ (NSArray *)CollectionType;
- (NSArray *)valuesOfCollection;
@end
