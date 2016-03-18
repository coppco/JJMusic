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
+ (BOOL)deleteFMDatabase {
    BOOL success = NO;
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:[self getDatabaseFile]]) {
        [DB close];
        NSError *error = nil;
        success = [file removeItemAtPath:[self getDatabaseFile] error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }
    return success;
}
@end
