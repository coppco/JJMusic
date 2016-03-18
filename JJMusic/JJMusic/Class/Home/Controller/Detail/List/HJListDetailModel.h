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
HJpropertyCopy(NSString <Optional>*title);// 他比我更适合,
HJpropertyCopy(NSString <Optional>*song_id);// 262872214,
HJpropertyCopy(NSString <Optional>*author);// 胡夏,
HJpropertyCopy(NSString <Optional>*album_id);// 262872037,
HJpropertyCopy(NSString <Optional>*album_title);// 他比我更适合,
HJpropertyCopy(NSString <Optional>*relate_status);// 0,
HJpropertyCopy(NSString <Optional>*is_charge);// 0,
HJpropertyCopy(NSString <Optional>*all_rate);// 64,128,256,320,flac,
HJpropertyCopy(NSString <Optional>*high_rate);// 320,
HJpropertyCopy(NSString <Optional>*all_artist_id);// 1999,
//HJpropertyCopy(NSString *copy_type);// 1,
HJpropertyCopy(NSString <Optional>*has_mv);// 0,
HJpropertyCopy(NSString <Optional>*toneid);// 0,
HJpropertyCopy(NSString <Optional>*resource_type);// 0,
HJpropertyCopy(NSString <Optional>*is_ksong);// 0,
HJpropertyCopy(NSString <Optional>*has_mv_mobile);// 0,
HJpropertyCopy(NSString <Optional>*ting_uid);// 10622,
HJpropertyCopy(NSString <Optional>*is_first_publish);// 0,
HJpropertyCopy(NSString <Optional>*havehigh);// 2,
HJpropertyCopy(NSString <Optional>*charge);// 0,
HJpropertyCopy(NSString <Optional>*learn);// 0,
HJpropertyCopy(NSString <Optional>*song_source);// web,
HJpropertyCopy(NSString <Optional>*piao_id);// 0,
HJpropertyCopy(NSString <Optional>*korean_bb_song);// 0,
HJpropertyCopy(NSString <Optional>*resource_type_ext);// 0,
HJpropertyCopy(NSString <Optional>*mv_provider);// 0000000000,
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
