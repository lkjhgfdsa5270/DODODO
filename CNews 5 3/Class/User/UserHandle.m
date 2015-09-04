//
//  UserHandle.m
//  豆瓣项目
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserHandle.h"
static UserHandle * userhandle =nil;
@implementation UserHandle
+(instancetype)sharehandleUser{
    if (userhandle == nil) {
        userhandle = [[UserHandle alloc] init];
        userhandle.userHandleName = nil;
    }
    return userhandle;
}
@end
