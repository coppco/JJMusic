//
//  LockViewController.h
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//手势类型
typedef enum {
    LockViewTypeCheck,  //检查手势密码
    LockViewTypeCreate,  //创建手势密码
    LockViewTypeModify,  //修改手势密码
    LockViewTypeClean,  //清除手势密码
}LockViewType;
@interface LockViewController : UIViewController
//类型
HJpropertyAssign(LockViewType type);
/**
 *  以某种方式打开
 *
 *  @param type  手势的类型
 *
 *  @return
 */
- (instancetype)initWithType:(LockViewType)type;
@end
