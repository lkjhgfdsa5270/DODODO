//
//  DataBaseHandle.h
//  SQLite3_2
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zhaoxinlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFAccount.h"




typedef enum paths{
    Document = 0,
    Cache,
    Temp
}enumPaths;


@interface DataBaseHandle : NSObject
@property(nonatomic,strong) NSString * userName;


+ (instancetype)shareDataBase;

// 根据枚举值获取路径
- (NSString *)getPathOf:(enumPaths) pathParas;

// 打开数据库
- (void)openDBWithName:(NSString *)dbName atPath:(NSString *)path;

// 关闭数据库;
- (void)closeDB;

// 创建表
- (void)createTableWithName:(NSString *)tableName paramNames:(NSArray *)nameArray paramTypes:(NSArray *)TypeArray;


// 创建表 自定义primary key
- (void)createTableWithName:(NSString *)tableName paramNames:(NSArray *)nameArray paramTypes:(NSArray *)TypeArray setPrimaryKey:(BOOL) option;






// 插入数据任意
- (BOOL)insertIntoTable:(NSString *)tableName
              paramKeys:(NSArray *)keys
             withValues:(NSArray *)values;


// 删除
- (void)deletefromTable:(NSString *)tableName
                withKey:(NSString *)key
                  value:(NSString *)value;

// 改
- (void)updateTable:(NSString *)tableName
         changeDict:(NSDictionary *)dict
       atPrimaryKey:(NSString *)primaryKey
    primaryKeyValue:(NSString *)keyValue;

// 全查
- (NSArray *)selectAllFromTable:(NSString *)tableName userProperty:(NSArray *)propertes;


// 条件查
- (NSArray *)selectFromTable:(NSString *)tableName withKey:(NSString *) key pairValue:(NSString *)value userProperty:(NSArray *)propertes;

// 多条件查询
- (NSArray *)selectFromTable:(NSString *)tableName
               withQueryDict:(NSDictionary *)dict
                userProperty:(NSArray *)propertes;


// 条件查询movie
- (NSArray *)selectAllFromTable:(NSString *)tableName
                  withQueryDict:(NSDictionary *)dict
                  movieProperty:(NSArray *)propertes;

// 条件查询activit
- (NSArray *)selectAllFromTable:(NSString *)tableName
                  withQueryDict:(NSDictionary *)dict
               activityProperty:(NSArray *)propertes;


- (NSArray *)selectAllFromTable:(NSString *)tableName
                  withQueryDict:(NSDictionary *)dict
                  movieProperty:(NSArray *)propertes Message:(LFAccount * )message;
@end
