//
//  HJHostorySearchDB.m
//  JJMusic
//
//  Created by coco on 16/3/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJHostorySearchDB.h"
#import "FMDBHandle.h"
#import "FMDBCreateTable.h"
@implementation HJHostorySearchDB
/**
 *  获取所有历史记录
 *
 *  @return
 */
+ (NSArray *)getAllHostorySearchResult {
    NSMutableArray *array = [NSMutableArray array];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createHostorySearchTable];
            return;
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@ order by time desc", HostorySearchTable)];
        while ([result next]) {
            NSString *title = [result stringForColumn:@"title"];
            NSString *time = [result stringForColumn:@"time"];
            [array addObject:@{@"title":title, @"time":time}];
        }
        [result close];
        [db close];
    }];
    return array;
}
/**
 *  添加一条历史记录
 *
 *  @return
 */
+ (BOOL)addOneHostorySearchResultWithTitle:(NSString *)title {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createHostorySearchTable];
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"insert into %@ (title, time) values(?,?)",HostorySearchTable), title, [HJCommonTools getTimestampWithType:(TimestampTpyeSecond)]];
    }];
    return success;
}
+ (NSDictionary *)getOneHostorySearchResultWithTitle:(NSString *)title {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createHostorySearchTable];
            return;
        }
        FMResultSet *result = [db executeQuery:STRFORMAT(@"select * from %@ where title = ?", HostorySearchTable), title];
        while ([result next]) {
            NSString *title = [result stringForColumn:@"title"];
            NSString *time = [result stringForColumn:@"time"];
            [dict setObject:time forKey:@"time"];
            [dict setObject:title forKey:@"title"];
        }
        [result close];
        [db close];
    }];
    return dict;
}
+ (BOOL)isHasHostoryWithTitle:(NSString *)title {
    if ([self getOneHostorySearchResultWithTitle:title].count == 0) {
        return NO;
    }
    return YES;
}
/**
 *  删除一条历史记录
 *
 *  @return
 */
+ (BOOL)deleteOneHostorySearchResultWithTitle:(NSString *)title {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createHostorySearchTable];
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"delete from %@ where title = ?", HostorySearchTable),title];
    }];
    return success;
}
+ (BOOL)deleteAllHostory {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createDownloadTable];
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"delete from %@", HostorySearchTable)];
    }];
    return success;
}
+ (BOOL)updateOneHostorySearchResultWithTitle:(NSString *)title {
    __block BOOL success = NO;
    FMDatabaseQueue *queue = [FMDBHandle sharedDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:YES];
        if (![db tableExists:HostorySearchTable]) {
            [FMDBCreateTable createDownloadTable];
            return;
        }
        success = [db executeUpdate:STRFORMAT(@"update %@ set time = ? where title = ?", HostorySearchTable),[HJCommonTools getTimestampWithType:(TimestampTpyeSecond)], title];
    }];
    return success;

}
@end
