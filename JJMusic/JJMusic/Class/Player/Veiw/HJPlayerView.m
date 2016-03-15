//
//  HJPlayerView.m
//  JJMusic
//
//  Created by coco on 16/3/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerView.h"
#import "HJPlayerBottomView.h"
#import "HJMusicTool.h"  //播放器
#import <MediaPlayer/MediaPlayer.h>  //锁屏
#import "HJLastMusicDB.h"  //数据库
#import <UIImageView+WebCache.h>
@interface HJPlayerView ()<UIScrollViewDelegate, HJMusicToolDelegate>
HJpropertyStrong(UIButton *backButton);  //隐藏按钮
HJpropertyStrong(UIImageView *backImageV);  //背景图片
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UILabel *autherL);  //歌手名字
HJpropertyStrong(UIButton *changeB);  //切换音质
HJpropertyStrong(UIScrollView *scrollView);  //滚动视图
HJpropertyStrong(UIPageControl *pageControll);//分页控制
HJpropertyStrong(HJPlayerBottomView *)bottomView;  //按钮滑块等


//scrollView添加的内容
HJpropertyStrong(UIImageView *imageV);  //第一页
HJpropertyAssign(CGPoint imageVCenter);  //中心点
HJpropertyStrong(NSTimer *timer); //定时器

HJpropertyStrong(UIView *lyricV);  //只有两行的
HJpropertyStrong(UIView *lyricVs);  //第三个歌词  填满scrollview
HJpropertyStrong(UIView *listView);//
@end

@implementation HJPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    [HJMusicTool sharedMusicPlayer].delegate = self;
    self.backImageV = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backImageV.image = [UIImage imageNamed:@"player_backgroud"];
    self.backImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImageV];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [ColorFromString(@"##FF0080") colorWithAlphaComponent:0.2];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(self.height * 0.1);
    }];
    //返回按钮
    self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.backButton setBackgroundImage:IMAGE(@"player_down") forState:(UIControlStateNormal)];
    [self.backButton addTarget:self action:@selector(selfDown:) forControlEvents:(UIControlEventTouchUpInside)];
    [topView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.left.equalTo(topView).insets(UIEdgeInsetsMake(15, 30, 0, 0));
    }];
    //标题
    self.titleL = [[UILabel alloc] init];
    self.titleL.textColor = [UIColor whiteColor];
//    self.titleL.text = @"爱你的365天";
//    [self.titleL sizeToFit];
    [topView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton).offset(-3);
        make.left.equalTo(self.backButton.mas_right).offset(10);
        make.right.equalTo(topView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    //切换音质
    self.changeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.changeB.layer.cornerRadius = 5;
    self.changeB.layer.borderWidth = 1;
    self.changeB.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.changeB setTitle:@"超高" forState:(UIControlStateNormal)];
    self.changeB.titleLabel.font = font(11);
    [self.changeB setImage:IMAGE(@"player_change") forState:(UIControlStateNormal)];
    [topView addSubview:self.changeB];
    [self.changeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.left.equalTo(self.titleL.mas_left);
        make.top.equalTo(self.titleL.mas_bottom).offset(2);
    }];
    //歌手
    self.autherL = [[UILabel alloc] init];
    self.autherL.textColor = [UIColor whiteColor];
//    self.autherL.text = @"Hans Zimmer";
//    [self.autherL sizeToFit];
    [topView addSubview:_autherL];
    [self.autherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeB);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.equalTo(self.changeB.mas_right).offset(5);
    }];
    
    self.bottomView = [[HJPlayerBottomView alloc] init];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self), ViewH(self) * 0.25));
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self);
    }];
    
    //    page
    self.pageControll = [[UIPageControl alloc] init];
    self.pageControll.numberOfPages = 4;
    [self.pageControll addTarget:self action:@selector(page:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:self.pageControll];
    [self.pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    //滚动视图
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(3);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self.pageControll.mas_top);
    }];
    //设置scrollview的范围
    self.scrollView.contentSize = CGSizeMake(ViewW(self) * 4, 0);
    
    //第一页图片
    UIView *view = [[UIView alloc] init];
    view.tag = 111;
    [_scrollView addSubview:view];
    
    self.imageV = [[UIImageView alloc] initWithImage:IMAGE(@"player_record")];
    [view addSubview:self.imageV];
    
}
//page方法
- (void)page:(UIPageControl *)page {
    [self.scrollView setContentOffset:CGPointMake(ViewW(_scrollView) * page.currentPage, 0) animated:YES];
}
//UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / ViewW(scrollView);
    _pageControll.currentPage = page;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *view = [_scrollView viewWithTag:111];
    view.frame = CGRectMake(0, 0, ViewW(_scrollView), ViewH(_scrollView));
    self.imageV.transform = CGAffineTransformIdentity;  //取消形变,不然会变形
    self.imageV.frame = CGRectMake(ViewW(view) / 2 - ViewW(view) * 0.35, ViewW(view) /2 - ViewW(view) * 0.35, ViewW(view) * 0.7, ViewW(view) * 0.7);
    self.imageVCenter = self.imageV.center;
    self.imageV.layer.cornerRadius = ViewW(_imageV) / 2;
    self.imageV.layer.borderWidth = 2;
    self.imageV.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:1].CGColor;
    self.imageV.layer.masksToBounds = YES;
}
- (void)selfDown:(UIButton *)button {
    [UIView animateWithDuration:0.4 animations:^{
        self.userInteractionEnabled = NO;
        self.Y = ViewH(self);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)updateTimer {
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
}
- (void)timer:(NSTimer *)timer {
    //让转盘开始转动
    self.imageV.transform = CGAffineTransformRotate(self.imageV.transform, 0.003);
}
#pragma mark - HJMusicPlayerDelegate
/**
 *  playerItem的状态为可以播放的时候, 更新音乐的最大时间
 *
 *  @param playerItem
 */
- (void)AVPlayerCanPlay:(AVPlayerItem *)playerItem {
    CGFloat duration = playerItem.duration.value / playerItem.duration.timescale;  //总时间
    //更改总时间label和slider的值
    [self.bottomView updateTotalWith:duration];
    [self updateTimer];
    
    //锁屏赋值
    NSMutableDictionary *Dic = [NSMutableDictionary dictionaryWithDictionary:[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo];
    //当前时间
    [Dic setObject:[NSNumber numberWithFloat:CMTimeGetSeconds(playerItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    //总时间
    [Dic setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(playerItem.duration)] forKey:MPMediaItemPropertyPlaybackDuration];
    [Dic setObject:_songModel.songinfo.title forKey:MPMediaItemPropertyTitle];
    //设置艺术家
    [Dic setObject:_songModel.songinfo.author forKey:MPMediaItemPropertyArtist];
//    if (_model.songinfo.artist_1000_1000.length != 0) {
        //设置图片
        MPMediaItemArtwork *mpMediaItemAreWork = [[MPMediaItemArtwork alloc] initWithImage:IMAGE(@"player_record")];
        [Dic setObject:mpMediaItemAreWork forKey:MPMediaItemPropertyArtwork];
//    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:Dic];
}
/**
 *  player正在播放的时候,更新进度条
 *
 *  @param playerItem
 */
- (void)AVPlayerIsPlaying:(AVPlayerItem *)playerItem {
    //更新时间
    CGFloat current = playerItem.currentTime.value/playerItem.currentTime.timescale;
    [self.bottomView updateCurrentWith:current];
    
    //由于前面给playerItem添加的观察者方法是1秒一次的,所以这个方法1秒执行一次, 间隔太长   转动不自然,还是加个定时器
}
/**
 *  playerItem的缓冲进度,更新缓冲条
 */
- (void)AVPlayerLoading:(AVPlayerItem *)playerItem {
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    CGFloat progress = timeInterval / totalDuration;
//    XHJLog(@"缓冲进度:%f", progress);
    [self.bottomView updateProgressWith:progress animated:YES];
}
/**
 *  AVPlayer结束播放
 *
 */
- (void)AVPlayerDidEnd {
    [self nextSong];
}
#pragma mark - 上一首下一首
/**
 *  下一首 
 */
- (void)nextSong {
    //单曲循环
    if ([userDefaultGetValue(PlayerCycle) boolValue]) {
        //合理使用这个方法,实现循环播放
        [[HJMusicTool sharedMusicPlayer] seekToTime:0];
        return;
    }
    [[HJMusicTool sharedMusicPlayer] stop];
    if ([userDefaultGetValue(PlayerType) boolValue]) {
        //随机
        if (self.content.count <= 0) {
            return;
        }
        NSInteger i = arc4random() % self.content.count;
        if (self.isFavoritePlayer) {
            self.songModel = self.content[i];
        }else {
            self.songID = [self.content[i] song_id];
        }
    } else {
        //顺序
        [self.content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj song_id] isEqualToString:self.songID]) {
                if (idx < self.content.count -1) {
                    if (self.isFavoritePlayer) {
                        self.songModel = self.content[idx + 1];
                    } else {
                        self.songID = [self.content[idx+1] song_id];
                    }
                } else {
                    if (self.isFavoritePlayer) {
                        self.songModel = self.content[0];
                    }else {
                        self.songID = [self.content[0] song_id];
                    }
                }
                *stop = YES;
            }
        }];
    };
}
///**
// *  上一首
// */
- (void)previousSong {
    //单曲循环
    if ([userDefaultGetValue(PlayerCycle) boolValue]) {
        //合理使用这个方法,实现循环播放
        [[HJMusicTool sharedMusicPlayer] seekToTime:0];
        return;
    }
    [[HJMusicTool sharedMusicPlayer] stop];
    if ([userDefaultGetValue(PlayerType) boolValue]) {
        //随机
        if (self.content.count <= 0) {
            return;
        }
        NSInteger i = arc4random() % self.content.count;
        if (self.isFavoritePlayer) {
            self.songModel = self.content[i];
        } else {
            self.songID = [self.content[i] song_id];
        }
    } else {
        //顺序
        [self.content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj song_id] isEqualToString:self.songID]) {
                if (idx == 0) {
                    if (self.isFavoritePlayer) {
                        self.songModel = [self.content lastObject];
                    } else {
                        self.songID = [[self.content lastObject] song_id];
                    }
                } else {
                    if (self.isFavoritePlayer) {
                        self.songModel = self.content [idx - 1];
                    } else {
                        self.songID = [self.content[idx - 1] song_id];
                    }
                }
                *stop = YES;
            }
        }];
    };
}

//setter方法
- (void)setContent:(NSArray *)content {
    if (_content != content) {
        _content = content;
        //区分类型
        NSArray *array;
        if ([content[0] isKindOfClass:[ListSongModel class]]) {
            array = [ListSongModel arrayOfDictionariesFromModels:content];
        } else if ([content[0] isKindOfClass:[HotListModel class]]  ){
            array = [HotListModel arrayOfDictionariesFromModels:content];
        } else if ([content[0] isKindOfClass:[HJSongModel class]]) {
            array = [HJSongModel arrayOfDictionariesFromModels:content];
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
        if (data) {
            //写到数据库
            [HJLastMusicDB updateContent:data];
        }
    }
}
- (void)setSongID:(NSString *)songID {
    //不相等才播放
    if (![_songID isEqualToString:songID]) {
        _songID = songID;
        [self.bottomView updateProgressWith:0 animated:NO];
        [self loadSongInfoWithSongID:songID];
    }
}
- (void)setSongModel:(HJSongModel *)songModel {
    if (![_songModel.songinfo.song_id isEqualToString:songModel.songinfo.song_id]) {
        _songModel = songModel;
        //写到数据库
        [HJLastMusicDB updateSongID:songModel.songinfo.song_id];
        
        [self playMusicWith:self.songModel];
    }
}
//获取model
- (void)loadSongInfoWithSongID:(NSString *)songid {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kMusicDetail(songid) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        HJSongModel *model = [[HJSongModel alloc] initWithDictionary:responseObject error:nil];
        if (model) {
            self.songModel = model;
        }
    } failedBlock:^(NSError *error) {
        XHJLog(@"网络请求失败");
    }];
}
#pragma mark - 播放方法
- (void)playMusicWith:(HJSongModel *)model {
    //停止
    [[HJMusicTool sharedMusicPlayer] stop];
    //重置下面的状态
    [self.bottomView resetPlayerStatus];
    //播放
    [[HJMusicTool sharedMusicPlayer] playWithURL:((SongURL *)model.url[0]).file_link model:model];
    //更改背景图片
    [self.backImageV sd_setImageWithURL:[NSURL URLWithString:model.songinfo.pic_huge.length != 0 ? model.songinfo.pic_huge : model.songinfo.pic_big.length == 0 ? model.songinfo.artist_640_1136 :model.songinfo.pic_big] placeholderImage:IMAGE(@"player_backgroud")];
    //标题和歌手
    self.titleL.text = model.songinfo.title;
    self.autherL.text = model.songinfo.author;
    //圆图
    [self imageVanimation];
}

- (void)imageVanimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.imageV.transform = CGAffineTransformMakeScale(0.6, 0.6);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.imageV.center = CGPointMake(self.imageV.center.x, -300);
        }completion:^(BOOL finished) {
            //让第一个出来以后,下次先把位置放到下面等下出来的位置,在紧接着做动画出来
            self.imageV.center = CGPointMake(self.imageV.center.x, 500);
            [UIView animateWithDuration:0.2 animations:^{
                //回到原位
                self.imageV.center = self.imageVCenter;
            }];
            //回复缩放
            self.imageV.transform = CGAffineTransformMakeScale(1, 1);
            //圆图
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:_songModel.songinfo.artist_1000_1000.length != 0 ? _songModel.songinfo.artist_1000_1000 : _songModel.songinfo.artist_500_500] placeholderImage:IMAGE(@"player_record")];
        }];
    }];
}

@end
