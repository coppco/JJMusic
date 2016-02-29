//
//  FMDBHandle.m
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "FMDBHandle.h"
static FMDatabaseQueue *my_FMDatabaseQueue = nil;
static FMDatabase *DB = nil;
@implementation FMDBHandle
+ (NSString *)getDatabaseFile {
    NSString *filePath = pathDocumentsFileName(dbName);
    return filePath;
}
+ (FMDatabaseQueue *)sharedDatabaseQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!my_FMDatabaseQueue) {
            my_FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self getDatabaseFile]];
        }
    });
    return my_FMDatabaseQueue;
}
+ (FMDatabase *)sharedFMDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!DB) {
            DB = [FMDatabase databaseWithPath:[self getDatabaseFile]];
        }
    });
    return DB;
}
@end
