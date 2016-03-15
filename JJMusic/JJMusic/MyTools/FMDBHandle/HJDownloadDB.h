//
//  HJDownloadDB.h
//  JJMusic
//
//  Created by coco on 16/3/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJDownloadDB : NSObject
/**
 *  获取所有已经下载的歌曲
 *
 *  @return 返回数组,可能为nil
 */
+ (NSArray *)getAllDownloadSong;
/**
 *  添加一条下载歌曲的记录
 *
 *  @param title   歌曲标题
 *  @param song_id 歌曲id
 *  @param path    歌曲在本地的位置
 *
 *  @return 返回成功与否
 */
+ (BOOL)addOneDownloadSongWithTitle:(NSString *)title song_id:(NSString *)song_id path:(NSString *)path;
/**
 *  删除一条下载的歌曲
 *
 *  @param song_id 歌曲id
 *
 *  @return 返回成功与否
 */
+ (BOOL)deleteOneDownloadSongWithSong_id:(NSString *)song_id;
/**
 *  根据歌曲id获取一条下载过的歌曲的信息
 *
 *  @param song_id 歌曲id
 *
 *  @return 返回成功与否
 */
+ (NSDictionary *)getDownloadSongWithSong_id:(NSString *)song_id;
@end
