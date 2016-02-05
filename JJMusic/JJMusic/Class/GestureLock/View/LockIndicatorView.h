//
//  LockIndicatorView.h
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//  小视图指示器  田字形

#import <UIKit/UIKit.h>

@interface LockIndicatorView : UIView
//设置密码,圆形图标
- (void)setPasswordString:(NSString*)string;
//重置
- (void)reset;
@end
