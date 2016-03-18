//
//  HJPickView.h
//  JJMusic
//
//  Created by coco on 16/3/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPickView : UIView
/**
 *  初始化方法
 *
 *  @param frame  frame大小
 *  @param cancel 取消的block
 *  @param done   确实的block
 *  @param dict   需要显示的内容
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame cancel:(void(^)(void))cancel done:(void (^)(NSString *title))done dict:(NSDictionary *)dict;
/**
 *  在父视图显示
 *
 *  @param view 父视图
 */
- (void)showInView:(UIView *)view;
@end
