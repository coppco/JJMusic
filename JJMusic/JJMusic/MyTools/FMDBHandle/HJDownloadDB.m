//
//  HJDownloadDB.m
//  JJMusic
//
//  Created by coco on 16/3/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJDownloadDB.h"
#import "FMDBHandle.h"
#import "FMDBCreateTable.h"

@implementation HJDownloadDB
/**
 *  获取所有已经下载的歌曲
 *
 *  @return 返回数组,可能为nil
 */
+ (NSArray *)getAllDownloadSong {
    __block NSMutableArray *array = [NSMutableArray array];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:DownloadTable]) {
            [FMDBCreateTable createDownloadTable];
            return;
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@", DownloadTable)];
        while ([result next]) {
            NSString *song_title = [result stringForColumn:@"song_title"];
            NSString *song_id = [result stringForColumn:@"song_id"];
            NSString *song_author = [result stringForColumn:@"song_author"];
            NSString *song_path = [result stringForColumn:@"song_path"];
            if (song_id.length != 0 && 0 != song_path.length && 0 != song_title.length && 0 != song_author.length) {
                NSDictionary *dic = @{@"song_title":song_title, @"song_id":song_id, @"song_path":song_path, @"song_author":song_author};
                [array addObject:dic];
            }
        }
        [result close];
        [db close];
    }];
    return array;
}
/**
 *  添加一条下载歌曲的记录
 *
 *  @param title   歌曲标题
 *  @param song_id 歌曲id
 *  @param path    歌曲在本地的位置
 *
 *  @return 返回成功与否
 */
+ (BOOL)addOneDownloadSongWithTitle:(NSString * _Nonnull)title song_id:(NSString * _Nonnull)songid author:(NSString * _Nonnull)author path:(NSString * _Nonnull)path {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:DownloadTable]) {
            [FMDBCreateTable createDownloadTable];
        }
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (song_title,song_id, song_author ,song_path) values(?,?,?,?)",DownloadTable), title, songid, author,path];
    }];
    return success;
}
/**
 *  删除一条下载的歌曲
 *
 *  @param song_id 歌曲id
 *
 *  @return 返回成功与否
 */
+ (BOOL)deleteOneDownloadSongWithSong_id:(NSString * _Nonnull)song_id {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:DownloadTable]) {
            [FMDBCreateTable createDownloadTable];
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"delete from %@ where song_id = %@", DownloadTable, song_id)];
    }];
    return success;
}
/**
 *  根据歌曲id获取一条下载过的歌曲的信息
 *
 *  @param song_id 歌曲id
 *
 *  @return 返回成功与否
 */
+ (NSDictionary *)getDownloadSongWithSong_id:(NSString * _Nonnull)song_id {
    __block NSMutableDictionary *dict;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:DownloadTable]) {
            [FMDBCreateTable createDownloadTable];
            return;
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@ where song_id = %@", DownloadTable, song_id)];
        if ([result next]) {
            NSString *song_title = [result stringForColumn:@"song_title"];
            NSString *song_id = [result stringForColumn:@"song_id"];
            NSString *song_author = [result stringForColumn:@"song_author"];
            NSString *song_path = [result stringForColumn:@"song_path"];
            if (0 != song_id.length && 0 != song_path.length && 0 != song_title.length && 0 != song_author.length) {
                dict = @{@"song_title":song_title, @"song_id":song_id, @"song_path":song_path, @"song_author":song_author}.mutableCopy;
            }
        }
        [result close];
        [db close];
    }];
    return dict;
}
+ (BOOL)isDownloadedWithSong_id:(NSString * _Nonnull)song_id {
    if ([self getDownloadSongWithSong_id:song_id]) {
        return YES;
    }
    return NO;
}
@end
