//
//  NetWorkManger.h
//  NetWorkManger_block
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id object);
typedef void(^Failed)(NSError *error);

@interface NetWorkManger : NSObject

-(void)requestWithUrlString:(NSString *)UrlString success:(void(^)(id object))success failed:(void (^)(NSError *error))fail;

@end
