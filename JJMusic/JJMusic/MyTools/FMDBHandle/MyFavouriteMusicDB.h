//
//  MyFavouriteMusicDB.h
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFavouriteMusicDB : NSObject
//获取收藏的音乐
+(NSArray *)getAllMusic;
//添加一条数据
+ (BOOL)addOneMusic:(id)object;
//删除一条数据
+ (BOOL)deleteOneMusic:(id)object;
//更新一条数据
+ (BOOL)updateOneMusic:(id)object;
//删除表
+ (BOOL)dropTableData;
@end
