//
//  LockItemView.h
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
/**
 *  手势锁的田字形9个圆环对象
      参照:https://github.com/nsdictionary/CoreLock
 */

#import <UIKit/UIKit.h>
/** 实心圆大小比例 */
#define CoreLockArcWHR  0.3f

/** 选中圆大小的线宽 */
#define CoreLockArcLineW  1.0f
/*
 *  外环线条颜色：默认
 */
#define CoreLockCircleLineNormalColor ColorFromRGBA(0,0,0,1)

/*
 *  外环线条颜色：选中
 */
#define CoreLockCircleLineSelectedColor ColorFromRGBA(34,178,246,1)

/*
 *  实心圆
 */
#define CoreLockCircleLineSelectedCircleColor ColorFromRGBA(34,178,246,1)
//方向,按照顺时针方法, 其实还少了四种方向
typedef NS_ENUM(NSInteger, LockItemDirection) {
    LockItemDirectionUp = 1,   //上
    LockItemDirectionRightUp,  //右上
    LockItemDirectionRight,  //右
    LockItemDirectionRightDown,  //右下
    LockItemDirectionDown,  //下
    LockItemDirectionLeftDown,  //左下
    LockItemDirectionLeft,  //左
    LockItemDirectionLeftUp,  //左上
};
@interface LockItemView : UIView
/**
 *  是否选中
 */
HJpropertyAssign(BOOL selected);
/**
 *  方向
 */
HJpropertyAssign(LockItemDirection direction);
/**
 *  是否错误
 */
HJpropertyAssign(BOOL wrong);
@end
