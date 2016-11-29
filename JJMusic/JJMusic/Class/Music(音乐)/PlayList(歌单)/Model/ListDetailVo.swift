//
//  ListDetailVo.swift
//  JJMusic
//
//  Created by M_coppco on 2016/11/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

class ListDetailVo: BaseData {
   var listid: String?    //363896149  歌单id
   var title: String?    //这个歌单可以带你环游世界
   var pic_300: String?    //http://musicugc.cdn.qianqian.com/ugcdiy/pic/148dcf03a48b06ab64ac7779eb990300.jpg
   var pic_500: String?    //http://musicugc.cdn.qianqian.com/ugcdiy/pic/148dcf03a48b06ab64ac7779eb990300.jpg
   var pic_w700: String?    //http://musicugc.cdn.qianqian.com/ugcdiy/pic/148dcf03a48b06ab64ac7779eb990300.jpg
   var width: String?    //300
   var height: String?    //300
   var listenum: String?    //1177  听众人数
   var collectnum: String?    //4
   var tag: String?    //欧美,世界音乐,纯音乐
   var desc: String?
   var url: String?    //http://music.baidu.com/songlist/363896149
   var content: [SongVo]?
    
}

class SongVo: HandyJSON {
    required init() {
        
    }
   var title: String?    //Summertime  标题
   var song_id: String?    //7928616   id
   var author: String?    //Ella Fitzgerald,Louis Armstrong  作者
   var album_id: String?    //7928191
   var album_title: String?    //Ella Fitzgerald - Gold
   var relate_status: String?    //0
   var is_charge: String?    //1
   var all_rate: String?    //24,64,128,192,256,320
   var high_rate: String?    //320
   var all_artist_id: String?    //34844,40273
   var copy_type: String?    //1
   var has_mv: Bool?
   var toneid: String?    //0
   var resource_type: String?    //0
   var is_ksong: String?    //0
   var resource_type_ext: String?    //0
   var versions: String?    //
   var bitrate_fee: String?    //{\"0\":\"0|0\\"1\":\"0|0\"}
    var has_mv_mobile: Bool?
   var ting_uid: String?    //9378
    var is_first_publish: Bool?
    var havehigh: Int?  //2
   var charge: Bool?
   var learn: Bool?
   var song_source: String?    //web
   var piao_id: String?    //0
   var korean_bb_song: String?    //0
   var mv_provider: String?    //0000000000
   var share: String?    //http://music.baidu.com/song/7928616"
}
