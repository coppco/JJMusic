//
//  HJSongModel.h
//  JJMusic
//
//  Created by coco on 16/2/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SongURL
@end
@protocol SongInfo
@end
//音乐播放地址
@interface SongURL : JSONModel
HJpropertyCopy(NSString *show_link);// 播放地址
HJpropertyCopy(NSString *down_type);// 0,
HJpropertyCopy(NSString *original);// 0,
HJpropertyCopy(NSString *free);// 1,
HJpropertyCopy(NSString *replay_gain);// 0.000000,
HJpropertyCopy(NSString *song_file_id);// 238616814   id
HJpropertyCopy(NSString *file_size);// 1702624,  大小
HJpropertyCopy(NSString *file_extension);// mp3 格式
HJpropertyCopy(NSString *file_duration);// 212
HJpropertyCopy(NSString *can_see);// 1,
HJpropertyCopy(NSString *can_load);// true,
HJpropertyCopy(NSString *preload);// 40,
HJpropertyCopy(NSString *file_bitrate);// 64 码率kbps
HJpropertyCopy(NSString *file_link);// 播放地址
HJpropertyCopy(NSString *is_udition_url);// 0,
HJpropertyCopy(NSString *hash);// 哈希值
@end

@interface SongInfo : JSONModel
HJpropertyCopy(NSString *resource_type_ext);// 0,
HJpropertyCopy(NSString *pic_huge);// ,
HJpropertyCopy(NSString *resource_type);// 0,
HJpropertyCopy(NSString *del_status);// 0,
HJpropertyCopy(NSString *album_1000_1000);// ,
HJpropertyCopy(NSString *pic_singer);// ,
HJpropertyCopy(NSString *album_500_500);// 图片地址
HJpropertyCopy(NSString *havehigh);// 2,
HJpropertyCopy(NSString *piao_id);// 0,
HJpropertyCopy(NSString *song_source);// web,
HJpropertyCopy(NSString *korean_bb_song);// 0,
HJpropertyCopy(NSString *compose);// ,
HJpropertyCopy(NSString *toneid);// 0,
HJpropertyCopy(NSString *area);// 0,
HJpropertyCopy(NSString *original_rate);// ,
HJpropertyCopy(NSString *bitrate);// 码率的几个值,逗号隔开
HJpropertyCopy(NSString *artist_500_500);// 地址
HJpropertyCopy(NSString *multiterminal_copytype);// ,
HJpropertyCopy(NSString *has_mv);// 0,
HJpropertyCopy(NSString *file_duration);// 0,
HJpropertyCopy(NSString *album_title);// 宝贝麦西西
HJpropertyCopy(NSString *sound_effect);// 0,
HJpropertyCopy(NSString *title);// 宝贝麦西西
HJpropertyCopy(NSString *high_rate);// 320,
HJpropertyCopy(NSString *pic_radio);// 地址
HJpropertyCopy(NSString *is_first_publish);// 0,
HJpropertyCopy(NSString *hot);// 17020 热度
HJpropertyCopy(NSString *language);// 国语,
HJpropertyCopy(NSString *lrclink);//歌词
HJpropertyCopy(NSString *distribution);//
HJpropertyCopy(NSString *relate_status);// 0,
HJpropertyCopy(NSString *learn);// 0,
HJpropertyCopy(NSString *play_type);// 0,
HJpropertyCopy(NSString *pic_big);// 大图
HJpropertyCopy(NSString *pic_premium);//
HJpropertyCopy(NSString *artist_480_800);//
HJpropertyCopy(NSString *aliasname);// ,
HJpropertyCopy(NSString *country);// 内地,
HJpropertyCopy(NSString *artist_id);// 413,
HJpropertyCopy(NSString *album_id);// 238616688,
HJpropertyCopy(NSString *original);// 0,
HJpropertyCopy(NSString *compress_status);// 0,
HJpropertyCopy(NSString *versions);// ,
HJpropertyCopy(NSString *expire);// 36000,
HJpropertyCopy(NSString *ting_uid);// 1255,
HJpropertyCopy(NSString *artist_1000_1000);//
HJpropertyCopy(NSString *all_artist_id);// 413,1708,
HJpropertyCopy(NSString *artist_640_1136);//
HJpropertyCopy(NSString *publishtime);// 2015-03-09,
HJpropertyCopy(NSString *charge);// 0,
//HJpropertyCopy(NSString *copy_type);// 0,  //不能以copy开头
HJpropertyCopy(NSString *songwriting);// ,
HJpropertyCopy(NSString *share_url);// http);////music.baidu.com/song/238616686,
HJpropertyCopy(NSString *author);// 香香,张津涤,
HJpropertyCopy(NSString *has_mv_mobile);// 0,
HJpropertyCopy(NSString *all_rate);// 24,64,128,192,256,320,flac,
HJpropertyCopy(NSString *pic_small);//
HJpropertyCopy(NSString *album_no);// 1,
HJpropertyCopy(NSString *song_id);// 238616686,
HJpropertyCopy(NSString *is_charge);// 0
@end

@interface HJSongModel : JSONModel
HJpropertyStrong(NSArray<SongURL> *url);
HJpropertyStrong(SongInfo *songinfo);
@end
