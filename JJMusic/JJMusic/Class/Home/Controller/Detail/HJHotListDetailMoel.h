//
//  HJHotListDetailMoel.h
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  HotListModel
@end
@protocol BillBoard
@end
@interface HotListModel : JSONModel
HJpropertyCopy(NSString *artist_id);// 1483,
HJpropertyCopy(NSString *language);// 国语,
HJpropertyCopy(NSString *pic_big);// http);////qukufile2.qianqian.com/data2/pic/6342c77f9ccb1eb80e5a2143f774135e/262838084/262838084.jpg,
HJpropertyCopy(NSString *pic_small);// http);////qukufile2.qianqian.com/data2/pic/2a82b2cdb37298715a0543927d8b1cc7/262838087/262838087.jpg,
HJpropertyCopy(NSString *country);// 内地,
HJpropertyCopy(NSString *area);// 0,
HJpropertyCopy(NSString *publishtime);// 2016-02-25,
HJpropertyCopy(NSString *album_no);// 1,
HJpropertyCopy(NSString *lrclink);// http);////musicdata.baidu.com/data2/lrc/7e6ceecc0028dffa5644616befbb20a2/262837430/%E4%B9%A6%E9%A6%99%E5%B9%B4%E5%8D%8E.lrc,
//HJpropertyCopy(NSString *copy_type);// 1,
HJpropertyCopy(NSString *hot);// 630566,
HJpropertyCopy(NSString *all_artist_ting_uid);// 1557,210034941,
HJpropertyCopy(NSString *resource_type);// 0,
HJpropertyCopy(NSString *is_new);// 1,
HJpropertyCopy(NSString *rank_change);// 0,
HJpropertyCopy(NSString *rank);// 1,
HJpropertyCopy(NSString *all_artist_id);// 1483,242899765,
HJpropertyCopy(NSString *style);// 流行,
HJpropertyCopy(NSString *del_status);// 0,
HJpropertyCopy(NSString *relate_status);// 0,
HJpropertyCopy(NSString *toneid);// 0,
HJpropertyCopy(NSString *all_rate);// 64,128,256,320,flac,
HJpropertyCopy(NSString *sound_effect);// 0,
HJpropertyCopy(NSString *file_duration);// 0,
HJpropertyCopy(NSString *has_mv_mobile);// 0,
HJpropertyCopy(NSString *title);// 书香年华,
HJpropertyCopy(NSString *song_id);// 262837429,
HJpropertyCopy(NSString *author);// 许嵩,孙涛,
HJpropertyCopy(NSString *havehigh);// 2,
HJpropertyCopy(NSString *album_title);// 书香年华,
HJpropertyCopy(NSString *ting_uid);// 1557,
HJpropertyCopy(NSString *album_id);// 262837188,
HJpropertyCopy(NSString *charge);// 0,
HJpropertyCopy(NSString *mv_provider);// 0000000000,
HJpropertyCopy(NSString *is_first_publish);// 0,
HJpropertyCopy(NSString *has_mv);// 0,
HJpropertyCopy(NSString *learn);// 0,
HJpropertyCopy(NSString *song_source);// web,
HJpropertyCopy(NSString *piao_id);// 0,
HJpropertyCopy(NSString *korean_bb_song);// 0,
HJpropertyCopy(NSString *resource_type_ext);// 0,
HJpropertyCopy(NSString *artist_name);// 许嵩,孙涛
@end

@interface BillBoard : JSONModel
HJpropertyCopy(NSString *billboard_type);// 1,
HJpropertyCopy(NSString *billboard_no);// 1764,
HJpropertyCopy(NSString *update_date);// 2016-03-10,
HJpropertyCopy(NSString *havemore);// 0,
HJpropertyCopy(NSString *name);// 新歌榜,
HJpropertyCopy(NSString *comment);// 该榜单是根据百度音乐平台歌曲每日播放量自动生成的数据榜单，统计范围为近期发行的歌曲，每日更新一次,
HJpropertyCopy(NSString *pic_s640);// http);////c.hiphotos.baidu.com/ting/pic/item/f7246b600c33874495c4d089530fd9f9d62aa0c6.jpg,
HJpropertyCopy(NSString *pic_s444);// http);////d.hiphotos.baidu.com/ting/pic/item/78310a55b319ebc4845c84eb8026cffc1e17169f.jpg,
HJpropertyCopy(NSString *pic_s260);// http);////b.hiphotos.baidu.com/ting/pic/item/e850352ac65c1038cb0f3cb0b0119313b07e894b.jpg,
HJpropertyCopy(NSString *pic_s210);// http);////d.hiphotos.baidu.com/ting/pic/item/c8ea15ce36d3d5393654e23b3887e950342ab0d9.jpg,
HJpropertyCopy(NSString *web_url);// http);////music.baidu.com/top/new
@end

@interface HJHotListDetailMoel : JSONModel
HJpropertyStrong(NSArray <HotListModel>*song_list);
HJpropertyStrong(BillBoard *billboard);
HJpropertyCopy(NSString *error_code);// 22000
@end
