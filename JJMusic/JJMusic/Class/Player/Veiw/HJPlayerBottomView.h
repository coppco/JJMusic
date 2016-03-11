//
//  HJPlayerBottomView.h
//  JJMusic
//
//  Created by coco on 16/3/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPlayerBottomView : UIView
/**
 *  更新总时间和滑块的最大值
 *
 *  @param duraction 时间
 */
- (void)updateTotalWith:(CGFloat)duraction;
/**
 *  实时更新滑块和当前时间
 *
 *  @param current 时间
 */
- (void)updateCurrentWith:(CGFloat)current;
/**
 *  更新下载进度条
 *
 *  @param progress 进度条
 *  @param animated  是否动画
 */
- (void)updateProgressWith:(CGFloat)progress animated:(BOOL)animated;
@end
