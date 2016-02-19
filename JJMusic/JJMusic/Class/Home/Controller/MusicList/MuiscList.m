//
//  MuiscList.m
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "MuiscList.h"

@implementation ListContent


@end

@implementation MuiscList
//改key   不同层级重写这个方法
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"content":@"musicList"
                                                       }];
}
@end
