//
//  MyFavouriteMusicDB.h
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJSongModel.h"  //model
@interface MyFavouriteMusicDB : NSObject
//获取收藏的音乐
+(NSArray *)getAllMusic;
//添加一条数据
+ (BOOL)addOneMusic:(HJSongModel *)object;
//删除一条数据
+ (BOOL)deleteOneMusic:(HJSongModel *)object;
//更新一条数据
+ (BOOL)updateOneMusic:(HJSongModel *)object;
//删除表
+ (BOOL)dropTableData;
/**
 *  判断是否收藏过某首歌曲
 *
 *  @param songID 歌曲ID
 *
 *  @return 
 */
+ (BOOL)isFavoourited:(NSString *)songID;
/**
 *  查找SongModel
 *
 *  @param songID 歌曲ID
 *
 *  @return 
 */
+ (HJSongModel *)selectSongModelForSongID:(NSString *)songID;
@end
