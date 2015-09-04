//
//  NetWorkManger.m
//  NetWorkManger_block
//
//  Created by lanou3g on 15/6/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NetWorkManger.h"

@interface  NetWorkManger ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property(nonatomic,strong)NSURLConnection *connection;

@property(nonatomic,copy)Success success;
@property(nonatomic,copy)Failed failed;

@property(nonatomic,strong)NSMutableData *data;

@end

@implementation NetWorkManger

-(void)requestWithUrlString:(NSString *)UrlString success:(void(^)(id object))success failed:(void (^)(NSError *error))fail
{
    NSURL *url = [NSURL URLWithString:UrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.success = success;
    self.failed = fail;
    [self.connection start];
}

#pragma mark  收到响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
}

#pragma mark 开始请求
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

#pragma mark 结束请求

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        self.failed(error);
        return;
    }
    self.success(object);
    
}

#pragma mark 请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR");
}








@end
