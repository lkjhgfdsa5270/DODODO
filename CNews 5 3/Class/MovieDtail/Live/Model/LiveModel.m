//
//  LiveModel.m
//  Live
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
        if ([key isEqualToString:@"description"]) {
            self.Description = value ;
        }
}

@end
