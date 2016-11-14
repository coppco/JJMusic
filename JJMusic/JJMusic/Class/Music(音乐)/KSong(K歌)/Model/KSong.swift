//
//  KSong.swift
//  JJMusic
//
//  Created by coco on 16/11/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

class KSongCategoryVo: BaseData {
    var items: [KSongItemVo]?
    
    override func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &items, name: "result.items")
    }
}

class KSongItemVo: HandyJSON {
    var query: String?
    var value: Int?
    var desc: String?  //KTV热歌榜
    required init() {
        
    }
}

class KSongTopImageVo: BaseData {
    var result: [KSongTopVo]?
}

class KSongTopVo: HandyJSON {
    required init() {
        
    }
    var type: String?  //learn
    var picture: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_6d358a65abf3ca38248b2bf52734b8dd.jpg
    var picture_iphone6: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_0c0aecaefd4af585ffcc9553fc234891.jpg
    var web_url: String?  //http://music.baidu.com/cms/webview/ktv_activity/20161025/
}


class KSongEveryoneVo: BaseData {
    var items: [KSongVo]?
    override func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &items, name: "result.items")
    }
}

class KSongVo: HandyJSON {
    required init() {
        
    }
    var song_id: String?   //35089128
    var song_title: String?   //爱情自有天意
    var album_title: String?   //爱情自有天意 电视原声带
    var artist_name: String?   //戚薇
    var picture_300_300: String?   //http://musicdata.baidu.com/data2/pic/246668382/246668382.jpg
    var play_num: String?   //9930
}
