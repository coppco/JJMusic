//
//  HJHostorySearchDB.h
//  JJMusic
//
//  Created by coco on 16/3/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJHostorySearchDB : NSObject
/**
 *  获取所有历史记录
 *
 *  @return
 */
+ (NSArray *)getAllHostorySearchResult;
/**
 *  添加一条历史记录
 *
 *  @return
 */
+ (BOOL)addOneHostorySearchResultWithTitle:(NSString *)title;
/**
 *  获取一条历史记录
 *
 *  @param title 搜索关键字
 *
 *  @return
 */
+ (NSDictionary *)getOneHostorySearchResultWithTitle:(NSString *)title;
/**
 *  判断数据库里面是否包含一个搜索关键字
 *
 *  @param title 搜索关键字
 *
 *  @return 
 */
+ (BOOL)isHasHostoryWithTitle:(NSString *)title;
/**
 *  删除一条历史记录
 *
 *  @return 
 */
+ (BOOL)deleteOneHostorySearchResultWithTitle:(NSString *)title;
/**
 *  更新一条搜索记录
 *
 *  @param title 搜索关键字
 *
 *  @return 
 */
+ (BOOL)updateOneHostorySearchResultWithTitle:(NSString *)title;

/**
 *  删除所有数据
 *
 *  @return 
 */
+ (BOOL)deleteAllHostory;
@end
