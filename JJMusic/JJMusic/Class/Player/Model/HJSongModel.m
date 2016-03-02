//
//  HJSongModel.m
//  JJMusic
//
//  Created by coco on 16/2/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSongModel.h"

@implementation SongURL

@end

@implementation SongInfo

@end

@implementation HJSongModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"songurl.url":@"url"}];
}
@end
