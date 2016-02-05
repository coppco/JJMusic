//
//  LockModel.m
//  JJMusic
//
//  Created by coco on 16/2/3.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "LockModel.h"

@implementation LockModel
+ (void)saveLockPassword:(NSString *)password {
    userDefaultSetValueKey(password, @"Lock");
}
+ (NSString *)getPassword {
    NSString *password = userDefaultGetValue(@"Lock");
    if (password.length != 0) {
        return password;
    }
    return nil;
}
@end
