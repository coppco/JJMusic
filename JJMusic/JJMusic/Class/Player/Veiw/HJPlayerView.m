//
//  HJPlayerView.m
//  JJMusic
//
//  Created by coco on 16/3/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerView.h"

@interface HJPlayerView ()
HJpropertyStrong(UIButton *backButton);  //隐藏按钮
HJpropertyStrong(UIImageView *backImageV);  //背景图片
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UILabel *auther);  //歌手名字
HJpropertyStrong(UIScrollView *scrollView);  //滚动视图
HJpropertyStrong(UIPageControl *pageControll);//分页控制
HJpropertyStrong(UILabel *currentL);//当前时间
HJpropertyStrong(UILabel *totalL);//总时间
HJpropertyStrong(UISlider *slider);//滑块
HJpropertyStrong(UIProgressView *progressView);//进度条
HJpropertyStrong(UIButton *previousB);//上一首
HJpropertyStrong(UIButton *playB);
@end

@implementation HJPlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self initSubView];
    }
    return self;
}

@end
