//
//  DataBaseHandle.m
//  SQLite3_2
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zhaoxinlei. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
static DataBaseHandle *dataBase = nil;

@implementation DataBaseHandle
+ (instancetype)shareDataBase
{
    if (dataBase == nil) {
        dataBase = [[DataBaseHandle alloc] init];
    }
    return dataBase;
}

// 根据枚举值获取路径
- (NSString *)getPathOf:(enumPaths) pathParas
{
    switch (pathParas) {
        case Document:
            return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            break;
        case Cache:
            return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
            break;
        case Temp:
            return NSTemporaryDirectory();
            break;
        default:
            return nil;
            break;
    }
}

static sqlite3 *db;

// 打开数据库
- (void)openDBWithName:(NSString *)dbName atPath:(NSString *)path
{
    if (db != nil) {
        NSLog(@"数据库已打开");
        return;
    }
    NSString *dbPath = [path stringByAppendingPathComponent:dbName];
    NSLog(@"()()()()()()()()()%@",dbPath);
    // 打开数据库
    int result = sqlite3_open(dbPath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库%@打开成功", dbName);
    }else {
        NSLog(@"数据库%@打开失败",dbName);
        perror("数据库打开失败");
    }
    
    
}



// 删
- (void)deletefromTable:(NSString *)tableName
                withKey:(NSString *)key
                  value:(NSString *)value
{
    // SQL语句
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", tableName, key, value];
    
    // 执行
    int result = sqlite3_exec(db, deleteSQL.UTF8String , NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
    
}





// 关闭数据库;
- (void)closeDB
{
    if (db == nil) {
        (@"数据已关闭");
    }
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
        perror("失败:");
    }
    db = nil;
}

// 建表
- (void)createTableWithName:(NSString *)tableName paramNames:(NSArray *)nameArray paramTypes:(NSArray *)TypeArray;
{
    if (nameArray.count != TypeArray.count) {
        NSLog(@"参数不匹配, 建表失败");
        
        return;
    }
    //SQL语句
    NSMutableString *createTableSQL = [NSMutableString stringWithFormat:@"create table if not exists %@ (sid integer primary key autoincrement not null", tableName];
    for (NSInteger i = 0; i < nameArray.count; i++) {
        [createTableSQL appendFormat:@",%@ %@", nameArray[i], TypeArray[i]];
    }
    [createTableSQL appendString:@")"];
    
    // 执行SQL语句
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加表成功");
    }else {
        NSLog(@"添加表失败");
    }
}

// 创建表 自定义primary key
- (void)createTableWithName:(NSString *)tableName paramNames:(NSArray *)nameArray paramTypes:(NSArray *)TypeArray setPrimaryKey:(BOOL) option
{
    if (nameArray.count != TypeArray.count) {
        NSLog(@"参数不匹配, 建表失败");
        return;
    }
    
    NSString *createTableSQL = nil;
    if (option) {
        // 存放参数名和类型的字符串
        NSMutableArray *strArray = [NSMutableArray array];
        for (NSInteger i = 1; i < nameArray.count; i++) {
            NSString *subStr = [NSString stringWithFormat:@"%@ %@", nameArray[i], TypeArray[i]];
            [strArray addObject:subStr];
        }
        NSString *formatStr = [strArray componentsJoinedByString:@", "];
        
        createTableSQL = [NSString stringWithFormat:@"create table if not exists %@ (%@ %@ primary key not null, %@)", tableName, nameArray[0], TypeArray[0], formatStr];
        
    } else {
        
        // 存放参数名和类型的字符串
        NSMutableArray *strArray = [NSMutableArray array];
        for (NSInteger i = 0; i < nameArray.count; i++) {
            NSString *subStr = [NSString stringWithFormat:@"%@ %@", nameArray[i], TypeArray[i]];
            [strArray addObject:subStr];
        }
        NSString *formatStr = [strArray componentsJoinedByString:@", "];
        createTableSQL =  @"123";
        createTableSQL = [NSString stringWithFormat:@"create table  %@ (%@)", tableName, formatStr];
    }
    // 执行SQL语句
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加表成功");
    }else {
        NSLog(@"添加表失败");
    }
    
    
    
}

// 插入数据任意
- (BOOL)insertIntoTable:(NSString *)tableName
              paramKeys:(NSArray *)keys
             withValues:(NSArray *)values;
{
    // SQL语句
    NSString *keyString = [keys componentsJoinedByString:@", "];
    
    
    NSString *valueString = [values componentsJoinedByString:@"', '"];
    valueString = [NSString stringWithFormat:@"'%@'", valueString];
    NSLog(@"`````````````000000000000000000%@",valueString);
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", tableName, keyString, valueString];
    NSLog(@"%@", insertSQL);
    int result = sqlite3_exec(db, insertSQL.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"5@@@@@@@@@@@@@@@@插入成功");
        return YES;
    }else{
        NSLog(@"$$$$$$$$$$$$$$$$$$插入失败");
        return NO;
    }

}


// 多条件查询
- (NSArray *)selectFromTable:(NSString *)tableName
               withQueryDict:(NSDictionary *)dict
                userProperty:(NSArray *)propertes
{
    NSMutableArray *userArray = nil;
    
    // SQL语句
    NSMutableArray *subStrArray = [NSMutableArray array];
    for (NSString *key in dict.allKeys) {
        NSString *subStr = [NSString stringWithFormat:@" %@ = '%@' ", key, dict[key]];
        [subStrArray addObject:subStr];
    }
    NSString *conditions = [subStrArray componentsJoinedByString:@"and"];
    NSString *selectSQL = [NSString stringWithFormat: @"select * from %@ where %@", tableName, conditions];
    NSLog(@"%@", selectSQL);
    
    sqlite3_stmt *stmt = nil;
    
    // 预执行
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        // 初始化数组
        userArray = [NSMutableArray array];
        
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            LFAccount *lfcount = [[LFAccount alloc] init];
            for (int i = 0; i < propertes.count; i++) {
                NSString *proString = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i)];
                [lfcount setValue: proString forKey:propertes[i]];
            }
            
            [userArray addObject:lfcount];
        }
        
        if (userArray.count ==0) {
            NSLog(@"没查到");
            // 关闭伴随指针
            sqlite3_finalize(stmt);
            return nil;
        }
        
    }else {
        NSLog(@"查找无结果");
    }
    
    // 关闭伴随指针
    sqlite3_finalize(stmt);
    
    return userArray;
    
}


// 多条件查询movie,activity, 返回数据
- (NSArray *)selectAllFromTable:(NSString *)tableName
                  withQueryDict:(NSDictionary *)dict
                  movieProperty:(NSArray *)propertes Message:(LFAccount * )message
{
    NSMutableArray *movieArray = nil;
    
    // SQL语句
    NSMutableArray *subStrArray = [NSMutableArray array];
    for (NSString *key in dict.allKeys) {
        NSString *subStr = [NSString stringWithFormat:@" %@ = '%@' ", key, dict[key]];
        [subStrArray addObject:subStr];
    }
    NSString *conditions = [subStrArray componentsJoinedByString:@"and"];
    NSString *selectSQL = [NSString stringWithFormat: @"select * from %@ where %@", tableName, conditions];
    NSLog(@"%@", selectSQL);
    // 创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    // 预执行
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        // 初始化数组
        movieArray = [NSMutableArray array];
        
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            // 第一列
            //  NSInteger sid = sqlite3_column_int(stmt, 0);
            // NSLog(@"88888888888888888888%lu",sid);
            //  [tempArr addObject:@(sid)];
            // 第二列
            NSString *userName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            [tempArr addObject:userName];
            // 其他列
         LFAccount*   detemovie = [[LFAccount alloc] init];
            for (int i = 0; i < propertes.count; i++) {
                NSString *proString = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, i+1)];
                
                [detemovie setValue:proString forKey:propertes[i]];
                
            }
            [tempArr addObject:detemovie];
            [movieArray addObject:tempArr];
        }
        
        if (movieArray.count ==0) {
            NSLog(@"没查到");
            // 关闭伴随指针
            sqlite3_finalize(stmt);
            return nil;
        }
        
    }else {
        NSLog(@"查找无结果");
    }
    
    // 关闭伴随指针
    sqlite3_finalize(stmt);
    
    return movieArray;
}

@end
