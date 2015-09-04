//
//  Model.h
//  BanBen1
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)NSString*url_3w;//Web
@property(nonatomic,copy)NSString*digest;//描述
@property(nonatomic,copy)NSString*url;//Web
@property(nonatomic,copy)NSString*title;//标题
@property(nonatomic,copy)NSString*lmodify;//图片
@property(nonatomic,strong)NSString * ptime;//更新时间
@property(nonatomic,strong)NSString * imgsrc;


@property(nonatomic,copy)NSString*content;
@property(nonatomic,copy)NSString*img;
@property(nonatomic,copy)NSString*imgs;
@property(nonatomic,copy)NSString*toUrl;


@property(nonatomic,strong)NSMutableArray *  imgextra;
+(instancetype)accountWithDic:(NSDictionary *)dict;
@end
