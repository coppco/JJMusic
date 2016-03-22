//
//  HJSearchDetailModel.m
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSearchDetailModel.h"

@implementation Song_list
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"copy_type":@"type"}];
}
@end

@implementation Artist_list

@end

@implementation Album_list

@end

@implementation HJSearchDetailModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"result.query":@"query",
                                                       @"result.syn_words":@"syn_words",
                                                       @"result.rqt_type":@"rqt.type",
                                                       @"result.song_info.total":@"song_total",
                                                       @"result.song_info.song_list":@"song_list",
                                                       @"result.artist_info.total":@"artist_total",
                                                       @"result.artist_info.artist_list":@"artist_list",
                                                       @"result.album_info.total":@"album_total",
                                                       @"result.album_info.album_list":@"album_list"
                                                       }];
}
@end
