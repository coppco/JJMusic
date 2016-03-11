//
//  HJMusicPlayer.m
//  JJMusic
//
//  Created by coco on 16/2/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJMusicTool.h"
#import "TBloaderURLConnection.h"  //下载类

@interface HJMusicTool ()
HJpropertyStrong(AVPlayer *player);  //播放器
HJpropertyStrong(AVPlayerItem *playerItem);
HJpropertyStrong(AVURLAsset *musicAsset);
HJpropertyStrong(id playbackTimeObserver);
HJpropertyAssign(BOOL isPause); //暂停
HJpropertyAssign(BOOL isPlaying);   //是否正在播放
HJpropertyStrong(TBloaderURLConnection *downloader);
@end

@implementation HJMusicTool
static HJMusicTool *musicTool = nil;
//单例
+ (HJMusicTool *)sharedMusicPlayer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (musicTool == nil) {
            musicTool = [[HJMusicTool alloc] init];
        }
    });
    return musicTool;
}
- (void)playWithURL:(NSString *)url model:(id)model{
    _model = model;
    XHJLog(@"%@", model);
    [self.player pause]; //暂停
    [self cleanPlayer];  //清空播放器监听属性
    self.isPause = NO;
    self.isPlaying = NO;
    
    //本地文件或者iOS7.0前直接播放
    if (__IOS_VERSION < 7.0 || ![url hasPrefix:@"http"]) {
        self.musicAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
        self.playerItem = [AVPlayerItem playerItemWithAsset:_musicAsset];
    } else {
        //ios7以上采用resourceLoader给播放器补充数据,需要把http换成streaming(流)
        
        self.downloader = [[TBloaderURLConnection alloc] init];
        NSURL *playURL = [self.downloader getSchemeWithURL:[NSURL URLWithString:url] scheme:@"streaming"];

            self.musicAsset = [AVURLAsset URLAssetWithURL:playURL options:nil];
            //这里设置多线程
            [self.musicAsset.resourceLoader setDelegate:self.downloader queue:dispatch_get_global_queue(0, 0)];
//        }
//        if (self.playerItem == nil) {
            self.playerItem = [AVPlayerItem playerItemWithAsset:_musicAsset];
//        }
    }
//    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
//    } else {
//        //在主线程替换
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
//        });
//    }
    //添加观察者
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //添加通知  播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endOfPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)endOfPlay:(NSNotification *)action {
    if (_delegate && [_delegate respondsToSelector:@selector(AVPlayerDidEnd)]) {
        [_delegate AVPlayerDidEnd];
    }
}
//清空播放器监听属性
- (void)cleanPlayer {
    if (!self.playerItem) {
        return;
    }
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status"];//预播放状态
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];//缓冲进度
    if (self.playbackTimeObserver) {
        [self.player removeTimeObserver:self.playbackTimeObserver];
        self.playbackTimeObserver = nil;
    }

    self.playerItem = nil;
}
//观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            [self canPlay:playerItem];// 给播放器添加计时器
        } else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
            [self stop];
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        if (_delegate && [_delegate respondsToSelector:@selector(AVPlayerLoading:)]) {
            [_delegate AVPlayerLoading:playerItem];
        }
    }
}
- (void)canPlay:(AVPlayerItem *)playerItem {
    if (_delegate && [_delegate respondsToSelector:@selector(AVPlayerCanPlay:)]) {
        [_delegate AVPlayerCanPlay:playerItem];
    }
    [_player play];  //开始播放
    WeakSelf(weak);
    //AVPlayer添加观察者,更新
    _playbackTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (_delegate && [_delegate respondsToSelector:@selector(AVPlayerIsPlaying:)]) {
            [weak.delegate AVPlayerIsPlaying:weak.playerItem];
        }
    }];
}
/**
 *  暂停或者播放
 */
- (void)playOrPause {
    if (!_playerItem) {
        return;
    }
    if (self.isPause && !self.isPlaying) {
        [_player play];
    }else if (self.isPlaying && !self.isPause) {
        [_player pause];
    }
}
/**
 *  停止
 */
- (void)stop {
    [_player pause];
    [self cleanPlayer];
}
/**
 *  暂停
 */
- (void)pause {
    [_player pause];
}
/**播放器快进*/
- (void)seekToTime:(CGFloat)second {
    if (!_playerItem) {
        return;
    }
    [_player pause];
    [_player seekToTime:CMTimeMakeWithSeconds(second, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        [_player play];
    }];
}
#pragma mark - getter方法
//rate ==1.0，表示正在播放；rate == 0.0，暂停；rate == -1.0，播放失败为了严谨，可以这样判断播放器状态
- (BOOL)isPause {
    if (_player.rate == 0.0 && _player.error == nil) {
        return YES;
    }
    return NO;
}
- (BOOL)isPlaying {
    if (_player.rate == 1.0 && _player.error == nil) {
        return YES;
    }
    return NO;
}


@end
