//
//  HJSearchDetailModel.h
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Song_list
@end
@protocol Album_list
@end
@protocol Artist_list
@end
@interface Song_list : JSONModel
HJpropertyCopy(NSString *content);// ,
HJpropertyCopy(NSString *type);// 1,
HJpropertyCopy(NSString *toneid);// 0,
HJpropertyCopy(NSString *info);// ,
HJpropertyCopy(NSString *all_rate);// 24,64,128,192,256,320,
HJpropertyCopy(NSString *resource_type);// 0,
HJpropertyCopy(NSString *relate_status);// 0,
HJpropertyCopy(NSString *has_mv_mobile);// 1,
HJpropertyCopy(NSString *song_id);// 115050327,
HJpropertyCopy(NSString *title);// U,
HJpropertyCopy(NSString *ting_uid);// 55178660,
HJpropertyCopy(NSString *author);// Austin Mahone,
HJpropertyCopy(NSString *album_id);// 115050325,
HJpropertyCopy(NSString *album_title);// U,
HJpropertyCopy(NSString *is_first_publish);// 0,
HJpropertyCopy(NSString *havehigh);// 2,
HJpropertyCopy(NSString *charge);// 1,
HJpropertyCopy(NSString *has_mv);// 1,
HJpropertyCopy(NSString *learn);// 0,
HJpropertyCopy(NSString *song_source);// web,
HJpropertyCopy(NSString *piao_id);// 0,
HJpropertyCopy(NSString *korean_bb_song);// 0,
HJpropertyCopy(NSString *resource_type_ext);// 0,
HJpropertyCopy(NSString *mv_provider);// 0100000000,
HJpropertyCopy(NSString *artist_id);// 19526224,
HJpropertyCopy(NSString *all_artist_id);// 19526224,
HJpropertyCopy(NSString *lrclink);// http);////musicdata.baidu.com/data2/lrc/116536044/U.lrc,
HJpropertyCopy(NSString *data_source);// 0,
HJpropertyCopy(NSString *cluster_id);// 0

@end
@interface Artist_list : JSONModel
HJpropertyCopy(NSString *artist_id);// 49081,
HJpropertyCopy(NSString *author);// <em>U</em>,
HJpropertyCopy(NSString *ting_uid);// 88009325,
HJpropertyCopy(NSString *avatar_middle);// http);////qukufile2.qianqian.com/data2/pic/102556632/102556632.jpg,
HJpropertyCopy(NSString *album_num);// 5,
HJpropertyCopy(NSString *song_num);// 43,
HJpropertyCopy(NSString *country);// 韩国,
HJpropertyCopy(NSString *artist_desc);// 한국 여성 / 솔로 가요 발라드,
HJpropertyCopy(NSString *artist_source);// web
@end
@interface Album_list : JSONModel
HJpropertyCopy(NSString *album_id);// 91065141,
HJpropertyCopy(NSString *author);// <em>U</em>,
HJpropertyCopy(NSString *hot);// 0,
HJpropertyCopy(NSString *title);// <em>U</em>LTRA★<em>U</em> -GALAXY- 感謝祭!,
HJpropertyCopy(NSString *artist_id);// 49081,
HJpropertyCopy(NSString *all_artist_id);// 49081,
HJpropertyCopy(NSString *company);// C81,
HJpropertyCopy(NSString *publishtime);// 2011-12-29,
HJpropertyCopy(NSString *album_desc);// 2nd F<em>u</em>ll Alb<em>u</em>m「<em>U</em>LTRA☆<em>U</em> GALAXY」発売記念全国の萌えロリキュンファンの皆様へ<em>U</em>より、感謝をこめて！音楽CD：<em>U</em>LTRA☆<em>U</em> GALAXY 感謝祭！ [C81.限定CD]アーテ...,
HJpropertyCopy(NSString *pic_small);// http);////qukufile2.qianqian.com/data2/pic/91072524/91072524.jpg

@end

@interface HJSearchDetailModel : JSONModel

HJpropertyCopy(NSString *query);  //关键字
HJpropertyCopy(NSString *syn_words);
HJpropertyCopy(NSString *rqt_type);
HJpropertyAssign(BOOL song_open);
HJpropertyAssign(BOOL artist_open);
HJpropertyAssign(BOOL album_open);
HJpropertyStrong(NSArray <Song_list>*song_list);
HJpropertyCopy(NSString *song_total);
HJpropertyStrong(NSArray <Artist_list>*artist_list);
HJpropertyCopy(NSString *artist_total);
HJpropertyStrong(NSArray <Album_list>*album_list);
HJpropertyCopy(NSString *album_total);

@end
