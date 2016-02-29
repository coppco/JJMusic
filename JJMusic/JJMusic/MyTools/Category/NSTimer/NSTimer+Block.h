//
//  NSTimer+Block.h
//  JJMusic
//
//  Created by coco on 16/2/24.
//  Copyright © 2016年 XHJ. All rights reserved.
//    NSTimer的block扩展

#import <Foundation/Foundation.h>

@interface NSTimer (Block)
/**
 *  无参数无返回值block
 */
typedef void (^CallBackBlock)(id userInfo);
/**
 *  创建Timer---Block版本,  是否重复
 *
 *  @param interval 每隔interval秒就会回调一次callBack
 *  @param userInfo 传递数据
 *  @param repeats  是否重复
 *  @param callBack 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval userInfo:(id)userInfo repeats:(BOOL)repeats callBack:(CallBackBlock)callBack;
/**
 *  创建Timer---Block版本,  重复一定次数
 *
 *  @param interval 每隔interval秒就会回调一次callBack
 *  @param userInfo 传递数据
 *  @param count   重复次数
 *  @param callBack 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval userInfo:(id)userInfo count:(NSInteger)count callBack:(CallBackBlock)callBack;
/**
 *  开始启动定时器
 */
- (void)fireTimer;

/**
 *  暂停定时器
 */
- (void)unfireTimer;
/**
 [timer setFireDate:[NSDate date]]; //继续。
 [timer setFireDate:[NSDate distantPast]];//开启
 [timer setFireDate:[NSDate distantFuture]];//暂停
 */
@end
