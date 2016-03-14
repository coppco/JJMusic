//
//  HJFavoriteListDB.h
//  JJMusic
//
//  Created by coco on 16/3/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//  收藏的歌单

#import <Foundation/Foundation.h>
#import "HJListDetailModel.h"
@interface HJFavoriteListDB : NSObject
/**
 *  获取所有收藏的歌单
 *
 *  @return 返回数组,可以为nil
 */
+ (NSArray *)getAllList;
/**
 *  添加收藏一个歌单
 *
 *  @param model 歌单model
 *
 *  @return 返回成功与否
 */
+ (BOOL)addOneList:(HJListDetailModel *)model;
/**
 *  删除一个歌单
 *
 *  @param list_id 歌单id
 *
 *  @return 返回成功与否
 */
+ (BOOL)deleteOneList:(NSString *)list_id;
/**
 *  从数据库根据歌单id查询返回一个model
 *
 *  @param list_id 歌单id
 *
 *  @return 返回查询后的model
 */
+ (HJListDetailModel *)selectModelForList_id:(NSString *)list_id;
/**
 *  判断是否收藏了某个歌单
 *
 *  @param list_id 歌单id
 *
 *  @return 返回YES or NO
 */
+ (BOOL)isFavorite:(NSString *)list_id;
/**
 *  删除表
 *
 *  @return 返回成功与否
 */
+ (BOOL)dropTableData;
@end
