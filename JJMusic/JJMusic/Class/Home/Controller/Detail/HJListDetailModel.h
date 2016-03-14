//
//  HJListDetailModel.h
//  JJMusic
//
//  Created by coco on 16/3/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ListSongModel
@end

@interface ListSongModel : JSONModel
HJpropertyCopy(NSString *title);// 他比我更适合,
HJpropertyCopy(NSString *song_id);// 262872214,
HJpropertyCopy(NSString *author);// 胡夏,
HJpropertyCopy(NSString *album_id);// 262872037,
HJpropertyCopy(NSString *album_title);// 他比我更适合,
HJpropertyCopy(NSString *relate_status);// 0,
HJpropertyCopy(NSString <Optional>*is_charge);// 0,
HJpropertyCopy(NSString *all_rate);// 64,128,256,320,flac,
HJpropertyCopy(NSString <Optional>*high_rate);// 320,
HJpropertyCopy(NSString *all_artist_id);// 1999,
//HJpropertyCopy(NSString *copy_type);// 1,
HJpropertyCopy(NSString *has_mv);// 0,
HJpropertyCopy(NSString *toneid);// 0,
HJpropertyCopy(NSString *resource_type);// 0,
HJpropertyCopy(NSString <Optional>*is_ksong);// 0,
HJpropertyCopy(NSString *has_mv_mobile);// 0,
HJpropertyCopy(NSString *ting_uid);// 10622,
HJpropertyCopy(NSString *is_first_publish);// 0,
HJpropertyCopy(NSString *havehigh);// 2,
HJpropertyCopy(NSString *charge);// 0,
HJpropertyCopy(NSString *learn);// 0,
HJpropertyCopy(NSString *song_source);// web,
HJpropertyCopy(NSString *piao_id);// 0,
HJpropertyCopy(NSString *korean_bb_song);// 0,
HJpropertyCopy(NSString *resource_type_ext);// 0,
HJpropertyCopy(NSString *mv_provider);// 0000000000,
HJpropertyCopy(NSString <Optional>*share);//
@end

@interface HJListDetailModel : JSONModel
HJpropertyCopy(NSString *error_code);// 22000,
HJpropertyCopy(NSString *listid);// 6370,
HJpropertyCopy(NSString *title);// 每首歌都是一剂重磅催泪弹,
HJpropertyCopy(NSString *pic_300);//
HJpropertyCopy(NSString *pic_500);//
HJpropertyCopy(NSString *pic_w700);//
HJpropertyCopy(NSString *width);// 375,
HJpropertyCopy(NSString *height);// 375,
HJpropertyCopy(NSString *listenum);// 10075,
HJpropertyCopy(NSString *collectnum);// 368,
HJpropertyCopy(NSString *tag);//
HJpropertyCopy(NSString *desc);//
HJpropertyCopy(NSString *url);//
HJpropertyStrong(NSArray <ListSongModel> *content);  //嵌套
@end
