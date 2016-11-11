//
//  ListVo.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

class ListArray: BaseData {
    var content: [ListVo]?
}

class ListVo: HandyJSON {
    required init() {
        
    }
    var name: String?  //新歌榜
    var typevar : Int?
    var countvar : Int?
    var comment: String?  //该榜单是根据百度音乐平台歌曲每日播放量自动生成的数据榜单，统计范围为近期发行的歌曲，每日更新一次
    var web_url: String?  //
    var pic_s192: String?  //http://b.hiphotos.baidu.com/ting/pic/item/9922720e0cf3d7caf39ebc10f11fbe096b63a968.jpg
    var pic_s444: String?  //http://d.hiphotos.baidu.com/ting/pic/item/78310a55b319ebc4845c84eb8026cffc1e17169f.jpg
    var pic_s260: String?  //http://b.hiphotos.baidu.com/ting/pic/item/e850352ac65c1038cb0f3cb0b0119313b07e894b.jpg
    var pic_s210: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_c49310115801d43d42a98fdc357f6057.jpg
    var content: [ListSongVo]?
}

class ListSongVo: HandyJSON {
    required init() {
        
    }
    var title: String?  //我要你
    var author: String?  //任素汐
    var song_id: String?  //274912664
    var album_id: String?  //274912674
    var album_title: String?  //我要你
    var rank_change: String?  //0
    var all_rate: String?  //64 128 256 320 flac
}
