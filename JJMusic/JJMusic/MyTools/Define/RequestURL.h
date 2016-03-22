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

//歌单接口 获取全部订单
#define kSongList(currentPage) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=%d&page_size=30&from=ios&version=5.5.4&from=ios&channel=appstore&operator=0", currentPage)
//音乐专题
#define kSongListSpecial \
@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.getOfficialDiyList&format=json&ver=2&type=2&pn=0&rn=30&version=5.5.5&from=ios&channel=appstore&operator=0"

//其他带参数接口
#define kSongListParameter(currentPage, parameter) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.search&page_no=%d&page_size=30&query=%@&from=ios&version=5.5.5&from=ios&channel=appstore&operator=0", currentPage, parameter)

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

//歌曲信息
#define kMusicDetail(songID) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=%@&songid=%@&nw=2&l2p=209.9&lpb=128000&ext=MP3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=%@&version=5.5.5&from=ios&channel=appstore&operator=0", [HJCommonTools getTimestampWithType:(TimestampTpyeSecond)], songID, @"%2FeISuiA6HFC3uTDn7Vp%2FTnmLK8Ut6xD2TukXuJI%2F48s%3D")

//榜单内容
#define kMusicHotDetail(type) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=%@&format=json&offset=0&size=100&from=ios&fields=title,song_id,author,resource_type,havehigh,is_new,has_mv_mobile,album_title,ting_uid,album_id,charge,all_rate,mv_provider&version=5.5.5&from=ios&channel=appstore&operator=0", type)

//歌手详情
//单曲
#define kSingerSingleDetail(artist_id,count) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getSongList&format=json&tinguid=%@&artistid=(null)&limits=50&order=2&offset=%@&version=5.5.5&from=ios&channel=appstore&operator=0", artist_id, count)
//专辑
#define kSingerAlbumDetail(artist_id) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getAlbumList&format=json&tinguid=%@&artistid=(null)&order=1&limits=30&offset=0&version=5.5.5&from=ios&channel=appstore&operator=0", artist_id)
//MV
#define kSingerMVDetail(artist_id) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getArtistMVList&id=%@&page=0&size=30&usetinguid=1&version=5.5.5&from=ios&channel=appstore&operator=0", artist_id)

//查找歌手
#define kSingerSearch(count, area, sex, abc) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=%@&area=%@&sex=%@&abc=%@&from=ios&version=5.5.5&from=ios&channel=appstore&operator=0", count, area, sex, abc)

//搜索 大致搜索
#define kSearch(key) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.search.catalogSug&query=%@&format=json&from=ios&version=5.5.5&from=ios&channel=appstore&operator=0",key)

//具体搜索
#define kSearchDetail(key) \
STRFORMAT(@"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.search.merge&query=%@&page_size=50&page_no=1&type=-1&format=json&from=ios&version=5.5.5&from=ios&channel=appstore&operator=0",key)
//搜索推荐关键字
#define kSearchRecommand \
@"http://tingapi.ting.baidu.com/v1/restserver/ting?&songid=877578&method=baidu.ting.search.hot&page_num=20&version=5.5.5&from=ios&channel=appstore&operator=0"
#endif /* RequestURL_h */
