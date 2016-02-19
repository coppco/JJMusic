//
//  KPeople.h
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KPeople : JSONModel

HJpropertyCopy(NSString *song_id);// 2126014,
HJpropertyCopy(NSString *song_title);// 水手,
HJpropertyCopy(NSString *album_title);// 私房歌,
HJpropertyCopy(NSString *artist_name);// 郑智化,
HJpropertyCopy(NSString *picture_300_300);//图片
HJpropertyCopy(NSString *play_num);// 6839047

@end
