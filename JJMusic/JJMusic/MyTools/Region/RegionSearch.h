//
//  RegionSearch.h
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionModel.h"
@interface RegionSearch : NSObject
#pragma mark - 根据ID查找省市县
/**
 *  根据ID查找省市县
 *
 *  @param ID id
 *
 *  @return
 */
+ (RegionModel *)searchRegionByID:(NSString *)ID;
/**
 *  获取所有城市数组,里面存放RegionModel
 *
 *  @return
 */
+ (NSArray *)getAllTheCity;
@end
