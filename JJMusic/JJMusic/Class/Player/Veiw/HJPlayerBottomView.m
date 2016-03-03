//
//  HJPlayerBottomView.m
//  JJMusic
//
//  Created by coco on 16/3/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerBottomView.h"
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
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return  self;
}
- (void)initSubView {
    self.playTypeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.playTypeB setBackgroundImage:IMAGE(@"player_type_sx") forState:(UIControlStateNormal)];
    [self addSubview:self.playTypeB];
    
    self.cycleB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.cycleB setBackgroundImage:IMAGE(@"player_cycle_cancel") forState:(UIControlStateNormal)];
    [self addSubview:self.cycleB];
    
    self.downloadB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.downloadB setBackgroundImage:IMAGE(@"player_download_cancel") forState:(UIControlStateNormal)];
    [self addSubview:self.downloadB];
    
    self.favoriteB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.favoriteB setBackgroundImage:IMAGE(@"player_favorite_cancel") forState:(UIControlStateNormal)];
    [self addSubview:self.favoriteB];
    
    self.currentL = [[UILabel alloc] init];
    self.currentL.font = font(13);
    self.currentL.text = @"01:43";
    [self.currentL sizeToFit];
    [self addSubview:self.currentL];
    
    self.totalL = [[UILabel alloc] init];
    self.totalL.font = font(13);
    self.totalL.text = @"04:52";
    [self addSubview:self.totalL];
    [self.totalL sizeToFit];
    self.slider = [[UISlider alloc] init];
    [self addSubview:self.slider];

//    self.progressView = [[UIProgressView alloc] init];
//    [self addSubview:self.progressView];
    
    self.previousB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.previousB setBackgroundImage:IMAGE(@"player_previous") forState:(UIControlStateNormal)];
    [self addSubview:self.previousB];
    
    self.playB = [UIButton buttonWithType:(UIButtonTypeCustom)];
     [self.playB setBackgroundImage:IMAGE(@"player_play") forState:(UIControlStateNormal)];
    [self addSubview:self.playB];
    
    self.nextB = [UIButton buttonWithType:(UIButtonTypeCustom)];
     [self.nextB setBackgroundImage:IMAGE(@"player_next") forState:(UIControlStateNormal)];
    [self addSubview:self.nextB];
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
        make.size.mas_equalTo(CGSizeMake(ViewW(self.currentL), kwidth));
    }];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentL);
        make.left.equalTo(self.currentL.mas_right).offset(10);
        make.right.equalTo(self.totalL.mas_left).offset(-10);
        make.height.mas_equalTo(kwidth);
    }];
    [self.totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self.totalL), kwidth));
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
@end
