//
//  AppDelegate.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJPlayerView.h"  //播放视图
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly)UIButton *playerB;  //  home键
@property (nonatomic, strong, readonly)HJPlayerView *playerView;  //播放界面
- (void)playerViewAppear:(UIButton *)button;   //点击button方法
@end

