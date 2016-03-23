//
//  HJPlayerModelDB.m
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerModelDB.h"
#import "FMDBHandle.h"
#import "FMDBCreateTable.h"

@implementation HJPlayerModelDB
+ (BOOL)addOneModel:(HJSongModel *)model {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:AVPlayerModelTable]) {
            [FMDBCreateTable createAVPlayerModelTable];
        }
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (song_id, model_data) values(?,?)", AVPlayerModelTable), model.songinfo.song_id, [model toJSONData]];
    }];
    return success;
}
+ (HJSongModel *)getOneModelWithSong_id:(NSString *)song_id {
    __block HJSongModel *model = nil;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:AVPlayerModelTable]) {
            [FMDBCreateTable createAVPlayerModelTable];
            return;
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@ where song_id = %@", AVPlayerModelTable, song_id)];
        while ([result next]) {
            NSData *model_data = [result dataForColumn:@"model_data"];
            model = [[HJSongModel alloc] initWithData:model_data error:nil];
        }
    }];
    return model;
}
+ (BOOL)ishasAddWithSong_id:(NSString *)song_id {
    if ([self getOneModelWithSong_id:song_id] != nil) {
        return YES;
    }
    return NO;
}
@end
