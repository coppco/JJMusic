//
//  HJLastMusicDB.m
//  JJMusic
//
//  Created by coco on 16/3/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJLastMusicDB.h"
#import "FMDBHandle.h"
#import "FMDBCreateTable.h"
@implementation HJLastMusicDB
///**
// *  删除所有数据
// */
//+ (BOOL)deleteAllData {
//    __block BOOL success = NO;
//    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
//    [queue inDatabase:^(FMDatabase *db) {
//        if (![db open]) {
//            return;
//        }
//        [db setShouldCacheStatements:YES];
//        if (![db tableExists:LastMusicTable]) {
//            [FMDBCreateTable createLastMusicTable];
//        }
//        success = [db executeUpdate:STRFORMAT(@"delete from %@", LastMusicTable)];
//    }];
//    return success;
//}
////插入新数据
//+ (BOOL)insertLastMusic:(NSString *)songID listData:(NSData *)listData {
//    __block BOOL success = NO;
//    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
//    [queue inDatabase:^(FMDatabase *db) {
//        if (![db open]) {
//            return ;
//        }
//        [db setShouldCacheStatements:YES];
//        if (![db tableExists:LastMusicTable]) {
//            [FMDBCreateTable createLastMusicTable];
//            [db executeUpdate:STRFORMAT(@"insert into %@ (songID, contentData) values(?,?)", LastMusicTable), songID, listData];
//        }
//        //再添加
//        success = [db executeUpdate:STRFORMAT(@"insert into %@ (songID, contentData) values(?,?)", LastMusicTable), songID, listData];
//    }];
//    return success;
//}
+ (BOOL)updateSongID:(NSString *)songID {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];\
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:LastMusicTable]) {
            [FMDBCreateTable createLastMusicTable];
        }
        success = [db executeUpdate:STRFORMAT(@"update %@ set songID = %@", LastMusicTable, songID)];
    }];
    return success;
}
+ (BOOL)updateContent:(NSData *)contentData {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:LastMusicTable]) {
            [FMDBCreateTable createLastMusicTable];
        }
        success = [db executeUpdate:STRFORMAT(@"update %@ set contentData = ?", LastMusicTable), contentData];
    }];
    return success;
}
//获取最后播放歌曲信息
+ (NSArray *)getLastMusic {
    __block NSMutableArray *array = [NSMutableArray array];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:LastMusicTable]) {
            [FMDBCreateTable createLastMusicTable];
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@", LastMusicTable)];
        if ([result next]) {
            NSString *songID = [result stringForColumn:@"songID"];
            NSData *data = [result dataForColumn:@"contentData"];
            if (songID.length != 0) {
                [array addObject:songID];
            }
            if (data) {
                [array addObject:data];
            }
        }
        [result close];
        [db close];
    }];
    return array;
}
@end
