//
//  HJSearchModel.h
//  JJMusic
//
//  Created by coco on 16/3/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HJSearchSong
@end

@protocol HJSearchAlbum
@end

@protocol HJSearchArtist
@end

@interface HJSearchSong : JSONModel
HJpropertyCopy(NSString *bitrate_fee);// {\0\);//\0|0\,\1\);//\0|0\},
HJpropertyCopy(NSString *yyr_artist);// 0,
HJpropertyCopy(NSString *songname);// 半壶纱,
HJpropertyCopy(NSString *artistname);// 刘珂矣,
HJpropertyCopy(NSString *control);// 0000000000,
HJpropertyCopy(NSString *songid);// 121353608,
HJpropertyCopy(NSString *has_mv);// 0,
HJpropertyCopy(NSString *encrypted_songid);// 020773bb5880956e22975L
@end

@interface HJSearchAlbum : JSONModel
HJpropertyCopy(NSString *albumname);// 半壶纱,
HJpropertyCopy(NSString *artistpic);// http);////qukufile2.qianqian.com/data2/pic/68394f5ca9f2333a200b85e3bad5dea5/260983587/260983587.jpg,
HJpropertyCopy(NSString *albumid);// 121353611,
HJpropertyCopy(NSString *artistname);// 刘珂矣
@end

@interface HJSearchArtist : JSONModel
HJpropertyCopy(NSString *yyr_artist);// 0,
HJpropertyCopy(NSString *artistid);// 132632388,
HJpropertyCopy(NSString *artistpic);// http);////qukufile2.qianqian.com/data2/pic/a35312d6d90eeb8b32088596b114915c/263044464/263044464.jpg,
HJpropertyCopy(NSString *artistname);// 刘珂矣
@end


@interface HJSearchModel : JSONModel
HJpropertyStrong(NSArray <HJSearchSong> *song);
HJpropertyStrong(NSArray <HJSearchAlbum> *album);
HJpropertyStrong(NSArray <HJSearchArtist>*artist);
#pragma mark - JsonModel.m  672行   所有都改为Optional
HJpropertyCopy(NSString <Optional>*order);// artist,song,album,
HJpropertyCopy(NSString *error_code);// 22000,

@end
