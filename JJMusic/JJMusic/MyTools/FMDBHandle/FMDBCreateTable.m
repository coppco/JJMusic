//
//  FMDBCreateTable.m
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "FMDBCreateTable.h"
#import "FMDBHandle.h"

@implementation FMDBCreateTable
+ (BOOL)createFavouriteMusicTable {
    FMDatabase *db = [FMDBHandle sharedFMDatabase];
    if (![db open]) {
        return NO;
    }
    //设置缓存,提高效率
    [db setShouldCacheStatements:YES];
    BOOL success = NO;
    if (![db tableExists:FavouriteMusicTable]) {
        //除了查询其他都用update
        success = [db executeUpdate:[NSString stringWithFormat:@"create table if not exists %@ (dbId integer primary key autoincrement not null,songID text, songName text,songAuthor text, songData blob)", FavouriteMusicTable]];
    }
    return success;
}
+ (BOOL)createLastMusicTable {
    FMDatabase *db = [FMDBHandle sharedFMDatabase];
    if (![db open]) {
        return NO;
    }
    //设置缓存
    [db setShouldCacheStatements:YES];
    BOOL success = NO;
    success = [db executeUpdate:STRFORMAT(@"create table if not exists %@ (dbId integer primary key autoincrement not null, songID text, contentData blob)", LastMusicTable)];
    if (success) {
        //插入空数据
        [db executeUpdate:STRFORMAT(@"insert into %@ (songID, contentData) values(?,?)", LastMusicTable), nil, nil];
    }
    return success;
}
@end
