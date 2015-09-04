//
//  Seemodel.m
//  SeeingAndHearing
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Seemodel.h"

@implementation Seemodel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
        
    } else if ([key isEqualToString:@"playCount"]){
        self.playCount = [NSString stringWithFormat:@"%@", value];
        
    }else if([key isEqualToString:@"replyCount"]){
        self.replyCount = [NSString stringWithFormat:@"%@",value];
    }else{
        [super setValue:value forKey:key];
    }
    
}
@end

