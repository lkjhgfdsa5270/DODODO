//
//  FunManager.m
//  网易新闻
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "FunManager.h"


@interface FunManager ()


@end


@implementation FunManager




//初始化单例
+ (instancetype)sharedInstance{
    static FunManager * funManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        funManager = [[FunManager alloc]init];
    });
    return funManager;
}

//请求网络数据(正文最外层字典)
- (void)getDataWithUrl:(NSString *)url Result:(void(^)(NSDictionary * dic))result{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
     [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        
         NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     
        dispatch_async(dispatch_get_main_queue(), ^{
          
            result(dict);
        });
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}

//请求网络数据(正文:最外层数组)
- (void)getArrayDataWithUrl:(NSString *)url Result:(void(^)(NSMutableArray * array))result{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            result(array);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}









@end
