//
//  HJPlayerBottomView.m
//  JJMusic
//
//  Created by coco on 16/3/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerBottomView.h"
#import "HJMusicTool.h"
#import "MyFavouriteMusicDB.h"  //数据库
#define kwidth (ViewH(self) - 32) * 0.26
@interface HJPlayerBottomView ()
HJpropertyStrong(UILabel *currentL);//当前时间
HJpropertyStrong(UILabel *totalL);//总时间
HJpropertyStrong(UISlider *slider);//滑块
HJpropertyStrong(UIProgressView *progressView);//进度条
HJpropertyStrong(UIButton *previousB);//上一首
HJpropertyStrong(UIButton *playB);
HJpropertyStrong(UIButton *nextB);//下一首
HJpropertyStrong(UIButton *playTypeB);  //播放模式  随机 顺序
HJpropertyStrong(UIButton *cycleB);  //循环
HJpropertyStrong(UIButton *downloadB);//下载
HJpropertyStrong(UIButton *favoriteB); //收藏
@end

@implementation HJPlayerBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self initSubView];
    }
    return  self;
}
- (void)initSubView {
    self.playTypeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.playTypeB setBackgroundImage:IMAGE(@"player_type_sx") forState:(UIControlStateNormal)];
    [self.playTypeB setBackgroundImage:IMAGE(@"player_type_sj") forState:(UIControlStateSelected)];
    if ([userDefaultGetValue(PlayerType) boolValue]) {
        self.playTypeB.selected = YES;
    }
    
    [self.playTypeB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.playTypeB];
    
    self.cycleB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.cycleB setBackgroundImage:IMAGE(@"player_cycle_cancel") forState:(UIControlStateNormal)];
    [self.cycleB setBackgroundImage:IMAGE(@"player_cycle") forState:(UIControlStateSelected)];
    if ([userDefaultGetValue(PlayerCycle) boolValue]) {
        self.cycleB.selected = YES;
    }
    
    [self.cycleB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.cycleB];
    
    self.downloadB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.downloadB setBackgroundImage:IMAGE(@"player_download_cancel") forState:(UIControlStateNormal)];
    [self.downloadB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.downloadB];
    
    self.favoriteB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.favoriteB setBackgroundImage:IMAGE(@"player_favorite_cancel") forState:(UIControlStateNormal)];
    [self.favoriteB setBackgroundImage:IMAGE(@"player_favorite") forState:(UIControlStateSelected)];
    
    [self.favoriteB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.favoriteB];
    
    self.currentL = [[UILabel alloc] init];
    self.currentL.font = font(13);
    self.currentL.textColor = [UIColor whiteColor];
    self.currentL.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.currentL];
    
    self.totalL = [[UILabel alloc] init];
    self.totalL.font = font(13);
    self.totalL.textColor = [UIColor whiteColor];
    self.totalL.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.totalL];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progressTintColor = [UIColor grayColor];  //填充部分颜色
//    self.progressView.trackTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];   // 未填充部分颜色
//    self.progressView.transform = CGAffineTransformMakeScale(2.5, 1);
    [self addSubview:self.progressView];
    
    self.slider = [[UISlider alloc] init];
    [self.slider setThumbImage:IMAGE(@"player_slider") forState:(UIControlStateNormal)];
    self.slider.minimumTrackTintColor = ColorClear;
    self.slider.maximumTrackTintColor = ColorClear;
    [self.slider setMinimumTrackTintColor:[UIColor greenColor]];
//    [self.slider setMaximumTrackTintColor:[[UIColor clearColor] colorWithAlphaComponent:0.3]];
    //添加事件
    [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:(UIControlEventValueChanged)];  //拖动滑竿
    [self.slider addTarget:self action:@selector(sliderChangeEnd:) forControlEvents:(UIControlEventTouchUpInside)]; //松手之后
    [self.slider addTarget:self action:@selector(sliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
    [self.slider addTarget:self action:@selector(sliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
    [self addSubview:self.slider];
    
    self.previousB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.previousB setBackgroundImage:IMAGE(@"player_previous") forState:(UIControlStateNormal)];
     [self.previousB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.previousB];
    
    self.playB = [UIButton buttonWithType:(UIButtonTypeCustom)];
     [self.playB setBackgroundImage:IMAGE(@"player_pause") forState:(UIControlStateNormal)];
    [self.playB setBackgroundImage:IMAGE(@"player_play") forState:(UIControlStateSelected)];
    [self.playB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.playB];
    
    self.nextB = [UIButton buttonWithType:(UIButtonTypeCustom)];
     [self.nextB setBackgroundImage:IMAGE(@"player_next") forState:(UIControlStateNormal)];
     [self.nextB addTarget:self action:@selector(playerClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.nextB];
}
#pragma mark - button方法
- (void)playerClick:(UIButton *)button {
    if (button == self.playB) {
        //播放和暂停
        button.selected = !button.selected;
        [[HJMusicTool sharedMusicPlayer] playOrPause];
        //圆盘
        if (button.selected) {
            [getApp().playerView stopTimer];
        } else {
            [getApp().playerView updateTimer];
        }
        return;
    }
    //下一曲
    if (button == self.nextB) {
        [getApp().playerView nextSong];
        return;
    }
    //上一曲
    if (button == self.previousB) {
        [getApp().playerView previousSong];
        return;
    }
    
    //播放模式
    if (button == self.playTypeB) {
        button.selected = !button.selected;
        userDefaultSetValueKey(@(button.selected), PlayerType);
        if (button.selected) {
            [HUDTool showTextTipsHUDWithTitle:@"随机播放模式" delay:0.8];
        } else {
            [HUDTool showTextTipsHUDWithTitle:@"顺序播放模式" delay:0.8];
        }

    }
    
    //是否单曲循环
    if (button == self.cycleB) {
        button.selected = !button.selected;
        userDefaultSetValueKey(@(button.selected), PlayerCycle);
        if (button.selected) {
            [HUDTool showTextTipsHUDWithTitle:@"单曲循环" delay:0.8];
        } else {
            [HUDTool showTextTipsHUDWithTitle:@"取消单曲循环" delay:0.8];
        }
    }
    
    //下载按钮
    if (button == self.downloadB) {
        
    }
    
    //收藏按钮
    if (button == self.favoriteB) {
        if (![MyFavouriteMusicDB isFavoourited:getApp().playerView.songID]) {
            if (getApp().playerView.songID.length == 0) {
                [HUDTool showTextTipsHUDWithTitle:@"没有歌曲,收藏失败" delay:0.8];
                return;
            } else {
                [HUDTool showTextTipsHUDWithTitle:@"收藏成功" delay:0.8];
                [MyFavouriteMusicDB addOneMusic:getApp().playerView.model];
            }
        } else {
            [HUDTool showTextTipsHUDWithTitle:@"取消收藏" delay:0.8];
            [MyFavouriteMusicDB deleteOneMusic:getApp().playerView.songID];
        }
        button.selected = !button.selected;
    }
}
#pragma mark - slider方法
//拖动的时候
- (void)sliderChange:(UISlider *)slider {
    [[HJMusicTool sharedMusicPlayer] pause];
    [self updateCurrentWith:slider.value];
}
//拖动结束的时候开始播放
- (void)sliderChangeEnd:(UISlider *)slider {
    [self updateCurrentWith:slider.value];
    [[HJMusicTool sharedMusicPlayer] seekToTime:slider.value];
}
- (void)layoutSubviews {
    CGFloat kx = (ViewW(self) - 4 * kwidth) / 5;
    //播放模式  单曲循环  下载  收藏
    [self.playTypeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kx);
        make.top.equalTo(self).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(kwidth, kwidth));
    }];
    [self.cycleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kwidth, kwidth));
        make.top.equalTo(self).with.offset(8);
        make.left.equalTo(self.playTypeB.mas_right).with.offset(kx);
    }];
    [self.downloadB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kwidth, kwidth));
        make.top.equalTo(self).with.offset(8);
        make.left.equalTo(self.cycleB.mas_right).with.offset(kx);
    }];
    [self.favoriteB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kwidth, kwidth));
        make.top.equalTo(self).with.offset(8);
        make.left.equalTo(self.downloadB.mas_right).with.offset(kx);
    }];
    
    //时间  进度条和滑块
    [self.currentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self.playTypeB.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(ViewW(self) * 0.12, kwidth));
    }];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentL);
        make.left.equalTo(self.currentL.mas_right).offset(10);
        make.right.equalTo(self.totalL.mas_left).offset(-10);
        make.height.mas_equalTo(kwidth);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.slider);
        make.left.equalTo(self.currentL.mas_right).offset(10);
        make.right.equalTo(self.totalL.mas_left).offset(-10);
        make.height.mas_equalTo(2);
    }];
    [self.totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self) * 0.12, kwidth));
        make.centerY.equalTo(self.currentL);
        make.right.equalTo(self).offset(-5);
    }];
    
    //上一首  播放  下一首
    CGFloat widthPlay = (ViewH(self) - 32)* 0.48;
    CGFloat widthOther = (ViewH(self) - 32) * 0.32;
    CGFloat kxx = (ViewW(self) - widthPlay -widthOther * 2) / 4;
    [self.playB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.previousB);
        make.bottom.equalTo(self).offset(-8);
        make.size.mas_equalTo(CGSizeMake(widthPlay, widthPlay));
        make.left.equalTo(self.previousB.mas_right).offset(kxx);
    }];
    [self.previousB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kxx);
        make.centerY.equalTo(self.playB);
        make.size.mas_equalTo(CGSizeMake(widthOther, widthOther));
    }];
    [self.nextB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playB);
        make.size.mas_equalTo(CGSizeMake(widthOther, widthOther));
        make.right.equalTo(self).offset(-kxx);
    }];
}
- (void)updateTotalWith:(CGFloat)duraction {
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = duraction;
    long videoLenth = ceil(duraction);
    NSString *strtotal = nil;
    if (videoLenth < 3600) {
        strtotal =  [NSString stringWithFormat:@"%02li:%02li",lround(floor(videoLenth/60.f)),lround(floor(videoLenth/1.f))%60];
    } else {
        strtotal =  [NSString stringWithFormat:@"%02li:%02li:%02li",lround(floor(videoLenth/3600.f)),lround(floor(videoLenth%3600)/60.f),lround(floor(videoLenth/1.f))%60];
    }
    self.currentL.text = @"0:00";
    self.totalL.text = strtotal;
    
    //重置播放暂停图标等
    self.playB.selected = NO;  //播放按钮图标
    [self.progressView setProgress:0.0 animated:NO]; //进度条
    //收藏图标
    if ([MyFavouriteMusicDB isFavoourited:getApp().playerView.songID]) {
        self.favoriteB.selected = YES;
    } else  {
        self.favoriteB.selected = NO;
    }
    
}
- (void)updateCurrentWith:(CGFloat)current {
    long videoLenth = ceil(current);
    NSString *strtotal = nil;
    if (videoLenth < 3600) {
        strtotal =  [NSString stringWithFormat:@"%02li:%02li",lround(floor(videoLenth/60.f)),lround(floor(videoLenth/1.f))%60];
    } else {
        strtotal =  [NSString stringWithFormat:@"%02li:%02li:%02li",lround(floor(videoLenth/3600.f)),lround(floor(videoLenth%3600)/60.f),lround(floor(videoLenth/1.f))%60];
    }
    self.currentL.text = strtotal;
    [self.slider setValue:current animated:YES];
}
- (void)updateProgressWith:(CGFloat)progress {
    [self.progressView setProgress:progress animated:YES];
}

@end
