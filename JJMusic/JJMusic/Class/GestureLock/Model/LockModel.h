//
//  LockModel.h
//  JJMusic
//
//  Created by coco on 16/2/3.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockModel : NSObject
/**
 *  保存锁屏密码
 *
 *  @param password 锁屏密码
 */
+ (void)saveLockPassword:(NSString *)password;
/**
 *  获取锁屏密码
 *
 *  @return
 */
+ (NSString *)getPassword;
@end
