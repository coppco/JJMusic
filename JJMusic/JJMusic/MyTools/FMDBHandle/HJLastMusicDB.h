//
//  HJLastMusicDB.h
//  JJMusic
//
//  Created by coco on 16/3/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//  最后试听数据库

#import <Foundation/Foundation.h>

@interface HJLastMusicDB : NSObject
/**
 *  更新最后播放歌曲信息
 *
 *  @param songID 歌曲id
 *
 *  @return 返回成功与否
 */
+ (BOOL)updateSongID:(NSString *)songID;
/**
 *  更新最后歌单信息
 *
 *  @param contentData 歌单信息数据
 *
 *  @return 返回成功与否
 */
+ (BOOL)updateContent:(NSData *)contentData;

/**
 *  获取最后歌曲信息
 *
 *  @return 返回数组
 */
+ (NSArray *)getLastMusic;
@end
