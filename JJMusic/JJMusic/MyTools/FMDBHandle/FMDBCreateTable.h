//
//  FMDBCreateTable.h
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBCreateTable : NSObject
/**
 *  创建收藏音乐数据库表
 *
 *  @return 返回成功与否
 */
+ (BOOL)createFavouriteMusicTable;
//
/**
 *  创建最后试听数据库表
 *
 *  @return 返回成功与否
 */
+ (BOOL)createLastMusicTable;
/**
 *  创建收藏的歌单数据库
 *
 *  @return 返回成功与否
 */
+ (BOOL)createFavouriteListTable;
@end
