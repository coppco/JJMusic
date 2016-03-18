//
//  FMDBHandle.h
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface FMDBHandle : NSObject
/**
 *  多线程操作数据库,来保证线程安全
 *
 *  @return
 */
+ (FMDatabaseQueue *)sharedDatabaseQueue;
/**
 *  获取一个数据库
 *
 *  @return 
 */
+ (FMDatabase *)sharedFMDatabase;
/**
 *  删除数据库
 *
 *  @return 
 */
+ (BOOL)deleteFMDatabase;
@end
