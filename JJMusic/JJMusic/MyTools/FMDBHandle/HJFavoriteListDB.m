//
//  HJFavoriteListDB.m
//  JJMusic
//
//  Created by coco on 16/3/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJFavoriteListDB.h"
#import "FMDBCreateTable.h"
#import "FMDBHandle.h"
@implementation HJFavoriteListDB
/**
 *  获取所有收藏的歌单
 *
 *  @return 返回数组,可以为nil
 */
+ (NSArray *)getAllList {
    NSMutableArray *array = [NSMutableArray array];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteListTable]) {
            [FMDBCreateTable createFavouriteListTable];
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@", FavouriteListTable)];
        while ([result next]) {
            NSData *data = [result dataForColumn:@"list_data"];
            
            HJListDetailModel *model = [[HJListDetailModel alloc] initWithData:data error:nil];
            if (model) {
                [array addObject:model];
            }
        }
        [result close];
        [db close];
    }];
    return array;
}
/**
 *  添加收藏一个歌单
 *
 *  @param model 歌单model
 *
 *  @return 返回成功与否
 */
+ (BOOL)addOneList:(HJListDetailModel *)model {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteListTable]) {
            [FMDBCreateTable createFavouriteListTable];
        }
        NSData *data = [model toJSONData];
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (list_id, list_data) values(?,?)", FavouriteListTable), model.listid, data];
    }];
    return success;
}
/**
 *  删除一个歌单
 *
 *  @param list_id 歌单id
 *
 *  @return 返回成功与否
 */
+ (BOOL)deleteOneList:(NSString *)list_id {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteListTable]) {
            [FMDBCreateTable createFavouriteListTable];
        }
        success = [db executeUpdate:STRFORMAT(@"delete from %@ where list_id = ?", FavouriteListTable), list_id];
    }];
    return success;
}
/**
 *  从数据库根据歌单id查询返回一个model
 *
 *  @param list_id 歌单id
 *
 *  @return 返回查询后的model
 */
+ (HJListDetailModel *)selectModelForList_id:(NSString *)list_id {
    __block HJListDetailModel *model = nil;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteListTable]) {
            [FMDBCreateTable createFavouriteListTable];
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@ where list_id = %@", FavouriteListTable, list_id)];
        while ([result next]) {
            NSData *data = [result dataForColumn:@"list_data"];
            model = [[HJListDetailModel alloc] initWithData:data error:nil];
        }
        [result close];
        [db close];
    }];
    return model;
}
/**
 *  判断是否收藏了某个歌单
 *
 *  @param list_id 歌单id
 *
 *  @return 返回YES or NO
 */
+ (BOOL)isFavorite:(NSString *)list_id {
    if ([self selectModelForList_id:list_id] == nil) {
        return NO;
    }
    return YES;
}
/**
 *  删除表
 *
 *  @return 返回成功与否
 */
+ (BOOL)dropTableData {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:FavouriteListTable]) {
            success = YES;
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"DROP TABLE %@", FavouriteListTable)];
    }];
    return success;
}
@end
