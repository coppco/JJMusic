//
//  RegionSearch.m
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "RegionSearch.h"
#import <FMDB.h>
#define RegionTable @"region"  //表
#define RegionDB @"region.db"  //数据库名称
@implementation RegionSearch
+ (FMDatabase *)openDB {
    //1. 获得数据库文件的路径
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:RegionDB ofType:nil];
    //2. 获得数据库
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    //3.打开数据库
    if (![dataBase open]) {
        return nil;
    }
    return dataBase;
}
+ (void)closeDataBase:(FMDatabase *)dataBase {
    [dataBase close];
}
//根据ID查找省市县
+ (RegionModel *)searchRegionByID:(NSString *)ID {
    //打开数据库
    FMDatabase *dataBase = [self openDB];
    if (!dataBase) {
        return nil;
    }
    //为数据库设置缓存，提高查询效率
    [dataBase setShouldCacheStatements:YES];
    //查询
    FMResultSet *resultSet = [dataBase executeQuery:STRFORMAT(@"select * from %@ where id = ?", RegionTable), ID];
    RegionModel *model = nil;
    if ([resultSet next]) {
        model = [[RegionModel alloc] init];
        model.ID = ID;
        model.name = [resultSet stringForColumn:@"name"];
        model.parentid = [NSString stringWithFormat:@"%d",[resultSet intForColumn:@"parentid"]];
        model.zipcode = [resultSet stringForColumn:@"zipcode"];
        model.pinyin = [resultSet stringForColumn:@"pinyin"];
        model.level =  [NSString stringWithFormat:@"%d",[resultSet intForColumn:@"level"]];
        model.sort =  [NSString stringWithFormat:@"%d",[resultSet intForColumn:@"sort"]];
    }
    [resultSet close];
    //关闭数据库
    [self closeDataBase:dataBase];
    return model;
}
//获取所有地区
+ (NSArray *)getAllTheCity {
    //1. 打开数据库
    FMDatabase *dataBase = [self openDB];
    if (!dataBase) {
        return nil;
    }
    //2. 设置缓存
    [dataBase setShouldCacheStatements:YES];
    //3. 开始查询
    FMResultSet *resultSet = [dataBase executeQuery:STRFORMAT(@"select * from %@", RegionTable)];
    NSMutableArray *allRegion = [NSMutableArray array];
    while ([resultSet next]) {
        NSString *ID = STRFORMAT(@"%d", [resultSet intForColumn:@"id"]);
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *parentid = STRFORMAT(@"%d", [resultSet intForColumn:@"parentid"]);
        NSString *pinyin = [resultSet stringForColumn:@"pinyin"];
        NSString *level = STRFORMAT(@"%d", [resultSet intForColumn:@"level"]);
        NSString *sort = STRFORMAT(@"%d", [resultSet intForColumn:@"sort"]);
        NSDictionary *dic = @{@"ID":ID, @"name":name, @"parentid":parentid,  @"pinyin":pinyin, @"level":level, @"sort":sort};
        RegionModel *regionData = [[RegionModel alloc] init];
        [regionData setValuesForKeysWithDictionary:dic];
        if ([regionData.level isEqualToString:@"3"]) {
            [allRegion addObject:regionData];
        }
    }
    [resultSet close];
    //关闭数据库
    [self closeDataBase:dataBase];
    return allRegion;
}
@end
