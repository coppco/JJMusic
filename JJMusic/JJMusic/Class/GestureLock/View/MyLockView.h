//
//  MyLockView.h
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//  田字形手势锁

#import <UIKit/UIKit.h>
#import "LockItemView.h"

@interface MyLockView : UIView
HJpropertyCopy(void (^checkPassword)(NSString *string));  //检查密码block
- (void)showErrorCircles:(NSString*)string; // 设置错误的密码以高亮
- (void)clearStatus; // 重置
@end
