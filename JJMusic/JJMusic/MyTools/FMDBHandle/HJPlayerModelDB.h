//
//  HJPlayerModelDB.h
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//  把请求的播放器model放在数据库中

#import <Foundation/Foundation.h>
#import "HJSongModel.h"  //
@interface HJPlayerModelDB : NSObject
/**
 *  添加一个model
 *
 *  @param model 模型
 *
 *  @return
 */
+ (BOOL)addOneModel:(HJSongModel *)model;
/**
 *  从数据库根据song_id查找模型
 *
 *  @param song_id 歌曲id
 *
 *  @return
 */
+ (HJSongModel *)getOneModelWithSong_id:(NSString *)song_id;
/**
 *  判断数据库有没有这个song_i对应的model
 *
 *  @param song_id 歌曲id
 *
 *  @return 
 */
+ (BOOL)ishasAddWithSong_id:(NSString *)song_id;
@end
