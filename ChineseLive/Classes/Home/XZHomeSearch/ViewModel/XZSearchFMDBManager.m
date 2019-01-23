//
//  XZSearchFMDBManager.m
//  TeamC
//
//  Created by sha xianding on 2017/11/24.
//  Copyright © 2017年 沙先鼎. All rights reserved.
//

#import "XZSearchFMDBManager.h"
#import <FMDB/FMDB.h>
#define TABLE_NAME  @"SearchDataDB"
@interface XZSearchFMDBManager ()
@property (nonatomic ,strong) FMDatabase *db;

@end
@implementation XZSearchFMDBManager
static XZSearchFMDBManager *manager = nil;
+(instancetype)shareXZSearchFMDB{
   
    static dispatch_once_t onceToken;
    
     
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        //创建数据库
        [manager creaSqliteDBData];
    });
    return manager;
}

-(void)creaSqliteDBData{
    /*
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [paths stringByAppendingString:@"activContent.sqlite"];
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"activContent" ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath toPath:filePath error:&error];
    }
    */
    //新建数据库并打开
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"activContent.sqlite"];
//    NSLog(@"%@", path);
    FMDatabase *db = nil;
    if (!self.db) {
          db = [FMDatabase databaseWithPath:path];
    }
   
    self.db = db;
    BOOL success = [db open];
    if (success) {
        //数据库创建成功
        NSLog(@"数据库打开成功");
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(rowid INTEGER PRIMARY KEY AUTOINCREMENT,keyWord text,currentTime text)",TABLE_NAME];
        
        BOOL successT = [db executeUpdate:sqlStr];
        if (successT) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
    }else{
        
        NSLog(@"打开数据库失败");
    }
    
}

/**
 *以搜索数据模型插入数据库
 * @param searchModel 搜索数据模型
 */
-(void)insterSearchModel:(XZSearchModel *)searchModel{
    
    if (![self.db open]) {
        NSLog(@"打开数据库失败");
        return;
    }
    
//    NSString *insterSql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(keyWord,currentTime) VALUES (?,?);",TABLE_NAME, searchModel.keyWord, searchModel.currentTime];
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into %@ (keyWord,currentTime) values (?,?)",TABLE_NAME];
    
    BOOL result = [self.db executeUpdate:insertSQL,searchModel.keyWord,searchModel.currentTime];
    if (result) {
        NSLog(@"插入成功");
    }else{
        
        NSLog(@"插入数据失败");
    }
    
    [self.db close];
    
    
   
   
}
/**
 *  根据关键字删除搜索数据模型
 *
 *  @param keyWord 搜索关键字
 */
-(void)deleteSearchModelByKeyWord:(NSString *)keyWord{
    
    if (![self.db open]) {
        NSLog(@"打开数据库失败");
        return;
    }
    NSLog(@"打开数据库成功");
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE keyWord = '%@'",TABLE_NAME,keyWord];
    
    if ([self.db executeUpdate:deleteSQL]) {
        NSLog(@"删除成功");
    }else{
        
        NSLog(@"删除数据失败");
    }
    [self.db close];
}
/**
 *删除全部数据
 *
 */
-(void)deleteAllSearchModel{
    
    if (![self.db open]) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from %@ where 1>0",TABLE_NAME];
    if ([self.db executeUpdate:deleteSQL]) {
        NSLog(@"删除全部数据成功");
    }else{
        
        NSLog(@"删除全部数据失败");
    }
    [self.db close];
}
/**
 *
 * 获取数据库里的全部数据
 *
 * @return 搜索数据的集合
 */
-(NSMutableArray *)selecAllSearchModel{
    
    if (![self.db open]) {
        NSLog(@"打开数据库失败");
        
        return nil;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@",TABLE_NAME];
    FMResultSet *resultSet = [self.db executeQuery:selectSQL];
    while ([resultSet next]){
        
         NSLog(@"查询数据成功");
        NSString *keyWord = [resultSet objectForColumn:@"keyWord"];
        NSString *currentTime = [resultSet objectForColumn:@"currentTime"];
        XZSearchModel *model = [XZSearchModel creatSearchModel:keyWord currentTime:currentTime];
        [arr addObject:model];
    }
    
    [self.db close];
    return arr;
    
}

@end
