//
//  RequestTool.h
//  Tool
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^backValue)(NSData*value);
@interface RequestTool : NSObject

//+(void)requestWithUrl:(NSString*)urlStr body:(NSString*)bodyStr backValue:(backValue)bv;

+(void)requestWithUrl:(NSString*)urlStr body:(NSString*)bodyStr backValue:(void(^)(NSData*value))bv;

@end
