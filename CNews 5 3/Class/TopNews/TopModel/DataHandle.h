//
//  DataHandle.h
//  BanBen2
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDCycleScrollView.h"

@interface DataHandle : NSObject <SDCycleScrollViewDelegate>
@property(nonatomic,assign)id<SDCycleScrollViewDelegate>delegate;

+(instancetype)shardataHandle;
-(void)requestUrl:(NSString *)url requestDataDidfinish:(void(^)(NSMutableArray * dataArry))result;
- (void)getDataWithUrl:(NSString *)url Result:(void(^)(NSMutableArray * array))result;

-(void)requestUrl:(NSString *)url requestDataDidfinishJson:(void (^)(NSMutableArray * array))result;
//无网络时刷新提示
-(void)tipboxNetwork;
//-(void)timerFireMethod:(NSTimer*)theTimer;
//- (void)p_removeAlertView:(UIAlertView *)alertView;
//轮播图
-(void)Carouselfigure:(UITableView*)tableView delegate:(id)delegate ModelImage:(NSString *)modelImage ModelName:(NSString *)modelname ModelI1mage:(NSString *)model1Image Model1Name:(NSString *)model1name
          Model2Image:(NSString *)model2Image Model2Name:(NSString *)model2name Height:(CGFloat)height;

//体育
-(void)requestUrl:(NSString *)url requestDataDidfinishSport:(void (^)(NSMutableArray * array))result;
/**
 *
 //打开数据库
 -(void)opendDb;
 //关闭数据库
 -(void)closeDB;
 //建表
 -(void)createTable;
 //删除表
 -(void)dropTable;
 //增
 //-(void)insertWithStudent:(ModelSQ*)aModelSQ;
 
 //删
 //-(void)deleteStudent:(ModelSQ*)aModelSQ;
 
 //改
 //-(void)update;
 
 //查
 //1.全查
 -(NSArray*)selectall;
 
 //2.条件查
 -(NSArray*)selectWithTitle:(NSString*)sex;
 
 
 
 

 */
@end
