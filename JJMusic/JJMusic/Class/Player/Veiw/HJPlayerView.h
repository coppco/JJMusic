//
//  HJPlayerView.h
//  JJMusic
//
//  Created by coco on 16/3/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJListDetailModel.h"
#import "HJSongModel.h"  //model
#import "HJHotListDetailMoel.h"
@interface HJPlayerView : UIView
@property (nonatomic, strong)HJSongModel *songModel;
/**
 *  更换songID  实现播放
 */
HJpropertyCopy(NSString *songID);
/**
 *  存放歌曲ID的数组,修改后只存放song_id的字符串
 */
HJpropertyStrong(NSArray *content);
/**
 *  视图向下隐藏
 *
 *  @param button 
 */
- (void)selfDown:(UIButton *)button;
/**
 *  下一首
 */
- (void)nextSong;
/**
 *  上一首
 */
- (void)previousSong;

/**
 *  开始定时器
 */
- (void)updateTimer;
/**
 *  停止定时器
 */
- (void)stopTimer;

@end
