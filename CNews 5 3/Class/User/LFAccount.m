//
//  LFAccount.m
//  微博
//
//  Created by lanou3g on 15/8/16.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "LFAccount.h"

@implementation LFAccount

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
+(instancetype)accountWithDic:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];

}
-(instancetype)initWithDict:(NSDictionary *)dict{
    self =  [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
       // NSLog(@"44444333333333333%lld",self.remind_in);
    }
    
    return self;
   }

/**
 *  从文件中解析时调用
 *
 
 */
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.self.NameUser = [decoder decodeObjectForKey:@"NameUser"];
        
        self.self.UserImageUrl = [decoder decodeObjectForKey:@"UserImageUrl"];
    }
    return self;
}
/**
 *  将对象写入文件时调用
 
 *
 *
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.NameUser forKey:@"NameUser"];
    [encoder encodeObject:self.UserImageUrl forKey:@"UserImageUrl"];
    
}






+ (NSArray *)CollectionName
{
    return @[@"title", @"netWoring"];
}

+ (NSArray *)CollectionType
{
    return @[@"TEXT", @"TEXT"];
}

- (NSArray *)valuesOfCollection
{
    return @[_title, _netWoring];
}



@end
