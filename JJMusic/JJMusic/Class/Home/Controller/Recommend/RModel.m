//
//  RModel.m
//  JJMusic
//
//  Created by coco on 16/2/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "RModel.h"

@implementation Module



@end

@implementation Radio


@end

@implementation Focus


@end

@implementation Scene


@end

@implementation AllScene


@end

@implementation Recsong


@end

@implementation Mix_2


@end

@implementation Album


@end

@implementation Diy


@end

@implementation King


@end
/**
 *  ==========================================
 */
@implementation RModel
+ (JSONKeyMapper *)keyMapper {
    //// 这里就采用了KVC的方式来取值，它赋给average属性
    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"module":@"modules",  //key值变化
                                                       @"result.radio.result":@"radio",  //改变层级关系的
                                                       @"result.focus.result":@"focus",
                                                       @"result.recsong.result":@"recsong",
                                                       @"result.mix_2.result":@"mix_2",
                                                       @"result.album.result":@"album",
                                                       @"result.diy.result":@"diy",
                                                       @"result.king.result":@"king",
                                                       @"result.scene.result":@"scene"
                                                       }];
}
@end
