//
//  RequestTool.m
//  Tool
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+(void)requestWithUrl:(NSString*)urlStr body:(NSString*)bodyStr backValue:(void(^)(NSData*value))bv{
    NSURL*url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    if (bodyStr.length!=0) {
        request.HTTPMethod=@"post";
        request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];//包体
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        bv(data);//回调传值
    }];
}
@end
