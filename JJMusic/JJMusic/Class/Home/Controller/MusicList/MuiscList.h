//
//  MuiscList.h
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  ListContent

@end

@interface ListContent : JSONModel
HJpropertyCopy(NSString *title);// 给我一点温度,
HJpropertyCopy(NSString *author);// 梁博,
HJpropertyCopy(NSString *song_id);// 262435353,
HJpropertyCopy(NSString *album_id);// 262435356,
HJpropertyCopy(NSString *album_title);// 给我一点温度,
HJpropertyCopy(NSString *rank_change);// 0,
HJpropertyCopy(NSString *all_rate);// 64,128,256,320,flac
@end


@interface MuiscList : JSONModel
HJpropertyCopy(NSString *name);// 新歌榜,
HJpropertyCopy(NSString *type);// 1,
HJpropertyCopy(NSString *comment);// 说明
HJpropertyCopy(NSString *web_url);
HJpropertyCopy(NSString *pic_s192); //图片
HJpropertyCopy(NSString *pic_s444);
HJpropertyCopy(NSString *pic_s260);
HJpropertyCopy(NSString *pic_s210);
HJpropertyStrong(NSArray <ListContent>*musicList);  //嵌套另外model,  改key值
@end
