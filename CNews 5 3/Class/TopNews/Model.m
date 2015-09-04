//
//  Model.m
//  BanBen1
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "Model.h"

@implementation Model

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
+(instancetype)accountWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
    
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    self =  [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

@end
