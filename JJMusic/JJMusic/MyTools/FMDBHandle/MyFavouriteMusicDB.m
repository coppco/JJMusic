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
            NSData *musicI = [resultSet dataForColumn:@"songData"];
            HJSongModel *model = [[HJSongModel alloc] initWithData:musicI error:nil];
            if (model) {
                [array addObject:model];
            }
        }
        [resultSet close];
        [db close];
    }];
    return array;
}
//添加一条数据
+ (BOOL)addOneMusic:(HJSongModel *)object {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        //       dbId integer primary key autoincrement not null,songId text, songName text,songAuthor text, songData blob
        NSData *data = [object toJSONData];
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (songID, songName, songAuthor, songData) values(?,?,?,?)", FavouriteMusicTable), object.songinfo.song_id, object.songinfo.title, object.songinfo.author, data];
        [db close];
    }];
    return success;
}
//删除一条数据
+ (BOOL)deleteOneMusic:(HJSongModel *)object {
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
        success = [db executeUpdate:STRFORMAT(@"delete from %@ where songID = %@", FavouriteMusicTable, object.songinfo.song_id)];
        [db close];
    }];
    return success;
}
//更新一条数据
+ (BOOL)updateOneMusic:(HJSongModel *)object {
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
        NSData *data = [object toJSONData];
        success = [db executeUpdate:STRFORMAT(@"update %@ set songName = %@, songAuthor = %@, songData = %@ where songID = ?", FavouriteMusicTable, object.songinfo.title, object.songinfo.author, data), object.songinfo.song_id];
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
//判断是否收藏过某首歌曲
+ (BOOL)isFavoourited:(NSString *)songID {
    if ([self selectSongModelForSongID:songID]) {
        return YES;
    } else {
        return NO;
    }
}
+ (HJSongModel *)selectSongModelForSongID:(NSString *)songID {
    __block HJSongModel *model = nil;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteMusicTable]) {
            [FMDBCreateTable createFavouriteMusicTable];
        }
        FMResultSet *resultSet = [db executeQuery:STRFORMAT(@"select * from %@ where songID = ?", FavouriteMusicTable), songID];
        while ([resultSet next]) {
            NSData *musicI = [resultSet dataForColumn:@"songData"];
            model = [[HJSongModel alloc] initWithData:musicI error:nil];
             XHJLog(@"%@", model.songinfo.song_id);
        }
        [resultSet close];
        [db close];
    }];
   
    return model;
}
@end
