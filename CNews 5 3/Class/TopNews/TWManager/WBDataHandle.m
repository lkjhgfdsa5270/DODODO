//
//  WBDataHandle.m
//  news
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "WBDataHandle.h"
#import "AFNetworking.h"

@implementation WBDataHandle

#pragma mark ----单例
+ (instancetype)defaultDataHandel{
    
    static WBDataHandle * handle =nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        handle = [[WBDataHandle alloc]init];
        
    });
    
    return handle;
}

#pragma mark --- 请求数据
- (void)requestDataDidFinish:(void(^)(NSMutableArray * modelArray))block{
    
    AFHTTPRequestOperationManager *manager =[[AFHTTPRequestOperationManager alloc]init];
    
    NSString * strUrl =[kReadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //GET请求
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求数据成功
        NSData *data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //解析数据
        
        //开辟数组
        NSArray * array =[result objectForKey:@"推荐"];
        
        [self.allModelArray removeAllObjects];
        //遍历数组
        for (NSDictionary *dic in array) {
            
            ReadModel * model =[ReadModel new];
            
            [model setValuesForKeysWithDictionary:dic];
//            NSLog(@"%@",model.title);
            [self.allModelArray addObject:model];
            
//            NSLog(@"+++%@",self.allModelArray);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            //block调用 并且传值
            block(self.allModelArray);
            
        });
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       //请求数据失败
        NSLog(@"function == %s line == %d error ==%@",__FUNCTION__,__LINE__,error);
        
    }];
    
    
}


#pragma mark--根据区的个数返回model
- (ReadModel *)getModelWithIndex:(NSInteger)index
{
    return  self.allModelArray[index];
}

#pragma mrak--返回数据的个数
- (NSInteger)getArrayCount{
    
    return self.allModelArray.count;
}



//懒加载
- (NSMutableArray *)allModelArray{
    
    if (!_allModelArray) {
        
        self.allModelArray = [[NSMutableArray alloc]init];
    }
    
    return _allModelArray;
}





@end
