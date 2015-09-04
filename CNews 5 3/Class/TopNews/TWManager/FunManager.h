//
//  FunManager.h
//  网易新闻
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface FunManager : NSObject

+ (instancetype)sharedInstance;//单例

//请求网络数据(正文:最外层字典)
- (void)getDataWithUrl:(NSString *)url Result:(void(^)(NSDictionary * dic))result;


//请求网络数据(正文:最外层数组)
- (void)getArrayDataWithUrl:(NSString *)url Result:(void(^)(NSMutableArray * array))result;








@end
