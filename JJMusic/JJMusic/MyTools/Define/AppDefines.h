//
//  AppDefines.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#ifndef AppDefines_h
#define AppDefines_h
/*===================AVPlayer相关===================*/
#define PlayerType @"AVPlayerType"  //播放模式  随机和顺序
#define PlayerCycle @"AVPlayerCycle"   //是否单曲循环
//保存最后试听信息
#define PlayerLastSongID @"AVPlayerSongID"  //最后歌曲ID
#define PlayerLastSongContent @"AVPlayerSongContent"  //最后歌单信息
/*========================首次登陆=====================*/
#define DidLoad  @"isFirstLoad"  //首次登陆
/*========================数据库=======================*/
#define dbName @"JJMusic.sqlit"      //本地数据库
#define FavouriteMusicTable    @"favouriteMusic_table"   //收藏的音乐
#define FavouriteListTable    @"favouriteList_table"   //收藏的歌单
#define LastMusicTable  @"lastMusic_table"   //最后试听音乐和歌单等
#define DownloadTable @"download_table"   //下载过的歌曲
#define HostorySearchTable @"hostorySearch_table"  //历史搜索记录
/*========================坐标=======================*/
#define begin_X 15
/*========================融云=======================*/
#define kRongYunAppKey @"pkfcgjstfb2y8"
#define kToken1 @"+l7ZioFpM2iJPXj3AuvTAxPVMLqFriQVoZ1ng8N8jlzAWe96EJxf/uWRx48Gv/oB10lZA4rTF/uGg314g8u14g=="
#define kToken2 @"ZAnlJOU2/uWJPXj3AuvTAxPVMLqFriQVoZ1ng8N8jlwgkTSPLSsOlcPZ6XtXOLRtmIk9RIDD+l2c/iC5bVjSvw=="
#endif /* AppDefines_h */
