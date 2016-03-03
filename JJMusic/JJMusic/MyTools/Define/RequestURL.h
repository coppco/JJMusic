//
//  RequestURL.h
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#ifndef RequestURL_h
#define RequestURL_h
//推荐接口
#define kMusicRecommend @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.index&version=5.5.5&from=ios&channel=appstore&operator=0"
#define CUID @{@"cuid":@"0e939898c11ad3b9b52e6fb5d50e009ad930a65b"}

//歌单接口
#define kSongList @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30&from=ios&version=5.5.4&from=ios&channel=appstore&operator=0"

//榜单接口
#define kMusicList @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json&from=ios&kflag=1&version=5.5.4&from=ios&channel=appstore&operator=0"

//歌手
#define kSinger @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=24&offset=0&area=0&sex=0&abc=&from=ios&version=5.5.4&from=ios&channel=appstore&operator=0"

//红心电台
#define kRedRadio @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.radio.getRecChannel&format=json&from=ios&page_no=0&page_size=7&cuid=0e939898c11ad3b9b52e6fb5d50e009ad930a65b&version=5.5.4&from=ios&channel=appstore&operator=0"
//乐播节目
#define kLeBo @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.lebo.getChannelTag&format=json&from=ios&page_no=0&page_size=9&version=5.5.4&from=ios&channel=appstore&operator=0"
//K歌
#define kSongMusic @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.learn.category&from=ios&version=5.5.4&from=ios&channel=appstore&operator=0"
//大家
#define kPeopleMusic @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.learn.now&from=ios&version=5.5.4&from=ios&channel=appstore&operator=0"

//歌单内容
#define kMusicListDetail(ListID) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=%@&version=5.5.5&from=ios&channel=appstore&operator=0", ListID)
#endif /* RequestURL_h */
