//
//  SingerModel.h
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SingerModel : JSONModel
HJpropertyStrong(NSString *ting_uid);// 81381913,
HJpropertyStrong(NSString *name);// TFBOYS,
HJpropertyStrong(NSString *firstchar);// T,
HJpropertyStrong(NSString *gender);// 2,
HJpropertyStrong(NSString *area);// 0,
HJpropertyStrong(NSString *country);// 中国,
HJpropertyStrong(NSString *avatar_big);
HJpropertyStrong(NSString *avatar_middle);
HJpropertyStrong(NSString *avatar_small);
HJpropertyStrong(NSString *avatar_mini);
HJpropertyStrong(NSString *albums_total);// 20,
HJpropertyStrong(NSString *songs_total);// 49,
HJpropertyStrong(NSString *artist_id);// 86767985,
HJpropertyStrong(NSString *piao_id);// 0
@end
