//
//  MyFavouriteMusicDB.m
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "MyFavouriteMusicDB.h"
#import "FMDBHandle.h"  //单例类
#import "FMDBCreateTable.h"  //创建表类

@implementation MyFavouriteMusicDB
//获取收藏的音乐
+(NSArray *)getAllMusic {
    NSMutableArray *array = [NSMutableArray array];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        //设置缓存
        [db setShouldCacheStatements:YES];
        
        //如果不存在表,则创建表
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        FMResultSet *resultSet = [db executeQuery:STRFORMAT(@"select * from %@", FavouriteMusicTable)];
        while ([resultSet next]) {
            NSString *musicN = [resultSet stringForColumn:@"musicName"];
            NSData *musicI = [resultSet dataForColumn:@"musicImage"];
            [array addObject:@[musicN, musicI]];
        }
        [resultSet close];
        [db close];
    }];
    return array;
}
//添加一条数据
+ (BOOL)addOneMusic:(id)object {
    __block BOOL success = NO;
    NSArray *array = object;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        //        dbId integer primary key autoincrement not null,musicId text, musicName text,musicUrl text, musicImage blob
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (musicId, musicName, musicUrl, musicImage) values(?,?,?,?)", FavouriteMusicTable), array[0], array[1], array[2], array[3]];
        [db close];
    }];
    return success;
}
//删除一条数据
+ (BOOL)deleteOneMusic:(id)object {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        success = [db executeUpdate:STRFORMAT(@"delete from %@ where musicId = %@", FavouriteMusicTable, object[0])];
        [db close];
    }];
    return success;
}
//更新一条数据
+ (BOOL)updateOneMusic:(id)object {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        success = [db executeUpdate:STRFORMAT(@"update %@ set musicName = '狗屎' where musicId = ?", FavouriteMusicTable), object[0]];
    }];
    return success;
}
//删除表
+ (BOOL)dropTableData {
    __block BOOL success  = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            success = YES;
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"DROP TABLE %@", FavouriteMusicTable)];
    }];
    return success;
    
}
@end
