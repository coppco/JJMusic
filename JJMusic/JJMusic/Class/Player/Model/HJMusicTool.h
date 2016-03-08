//
//  HJMusicPlayer.h
//  JJMusic
//
//  Created by coco on 16/2/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//   播放器单例类

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol HJMusicToolDelegate <NSObject>
@required
/**
 *  playerItem的状态为可以播放的时候, 更新音乐的最大时间
 *
 *  @param playerItem
 */
- (void)AVPlayerCanPlay:(AVPlayerItem *)playerItem;
/**
 *  player正在播放的时候,更新滑块和当前时间
 *
 *  @param playerItem
 */
- (void)AVPlayerIsPlaying:(AVPlayerItem *)playerItem;
/**
 *  playerItem的缓冲进度,更新缓冲条
 */
- (void)AVPlayerLoading:(AVPlayerItem *)playerItem;
/**
 *  player结束播放
 */
- (void)AVPlayerDidEnd;
@end

@interface HJMusicTool : NSObject
HJpropertyStrong(id delegate);  //代理
/**
 *  获取播放器,单例类
 *
 *  @return 返回一个播放器
 */
+ (HJMusicTool*)sharedMusicPlayer;
/**
 *  播放url
 *
 *  @param url 音乐地址
 */
- (void)playWithURL:(NSString *)url;
/**
 *  暂停或者播放
 */
- (void)playOrPause;
/**
 *  停止
 */
- (void)stop;
/**
 *  暂停
 */
- (void)pause;
/**
 *  播放器快进
 *
 *  @param second 秒数
 */
- (void)seekToTime:(CGFloat)second;
@end
