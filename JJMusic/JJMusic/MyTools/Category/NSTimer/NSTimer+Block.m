//
//  NSTimer+Block.m
//  JJMusic
//
//  Created by coco on 16/2/24.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval userInfo:(id)userInfo repeats:(BOOL)repeats callBack:(CallBackBlock)callBack {
    if (userInfo == nil || [userInfo isKindOfClass:[NSNull class]]) {
        userInfo  = @{@"callBack":[callBack copy]};
    } else {
        userInfo = @{@"userInfo":userInfo,
                                @"callBack":[callBack copy]
                     };
    }
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerRepeat:) userInfo:userInfo repeats:repeats];
}
+ (void)timerRepeat:(NSTimer *)timer {
    CallBackBlock callBack = timer.userInfo[@"callBack"];
    if (callBack) {
        callBack(timer.userInfo[@"userInfo"]);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval userInfo:(id)userInfo count:(NSInteger)count callBack:(CallBackBlock)callBack {
    if (userInfo == nil || [userInfo isKindOfClass:[NSNull class]]) {
        userInfo  = @{@"callBack":[callBack copy],
                                @"count":@(count)
                      };
    } else {
        userInfo = @{@"userInfo":userInfo,
                                @"callBack":[callBack copy],
                                @"count":@(count)
                     };
    }
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(timerCount:)
                                          userInfo:userInfo
                                           repeats:YES];
}
+ (void)timerCount:(NSTimer *)timer {
    static NSUInteger currentCount = 0;
    
    CallBackBlock callback = timer.userInfo[@"callBack"];
    NSNumber *count = timer.userInfo[@"count"];
    
    if (count.integerValue <= 0) {
        if (callback) {
            callback(timer.userInfo[@"userInfo"]);
        }
    } else {
        if (currentCount < count.integerValue) {
            currentCount++;
            if (callback) {
                callback(timer.userInfo[@"userInfo"]);
            }
        } else {
            currentCount = 0;
            [timer invalidate];  //停止
            timer = nil;
        }
    }
}
- (void)fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}
@end
