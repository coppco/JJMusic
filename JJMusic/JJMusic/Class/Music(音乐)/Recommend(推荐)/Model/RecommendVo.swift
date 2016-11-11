//
//  RecommendVo.swift
//  JJMusic
//
//  Created by coco on 16/11/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

class RecommendVo: BaseData {
    required init() {
        
    }
   var focus: [FocusVo]?   //焦点图
    var entry: [EntryVo]?   //音乐导航
    var mix_2: [Mix_22Vo]? //每日热点
    var diy: [DiyVo]?   //歌单推荐
    var album: [AlbumVo]?   //新碟上架
   var mix_22: [Mix_22Vo]?   //热销专辑
    var mod_27: [Mod_27Vo]?   //商城固定入口
    var scene: AllSence?   //场景电台
    var recsong: [RecsongVo]?   //今日推荐歌曲
    var mix_9: [Mix_9Vo]?    //原创音乐
   var mix_5:  [Mix_5Vo]?  //最热MV推荐
   var radio: [RadioVo]?   //乐播节目
    var mod_7: [Mod_7Vo]?    //专栏

    var module: [ModuleVo]?
    
    //继承的类, 需要父类空实现这个方法,否则取不到
    public override func mapping(mapper: HelpingMapper) {
        //改变key
        mapper.specify(property: &focus, name: "result.focus.result")
        mapper.specify(property: &entry, name: "result.entry.result")
        mapper.specify(property: &mix_9, name: "result.mix_9.result")
        mapper.specify(property: &mix_22, name: "result.mix_22.result")
        mapper.specify(property: &mix_2, name: "result.mix_2.result")
        mapper.specify(property: &mod_7, name: "result.mod_7.result")
        mapper.specify(property: &mix_5, name: "result.mix_5.result")
        mapper.specify(property: &recsong, name: "result.recsong.result")
        mapper.specify(property: &radio, name: "result.radio.result")
        mapper.specify(property: &album, name: "result.album.result")
        mapper.specify(property: &mod_27, name: "result.mod_27.result")
        mapper.specify(property: &album, name: "result.album.result")
        mapper.specify(property: &diy, name: "result.diy.result")
        //改变key值
        mapper.specify(property: &scene, name: "result.scene.result")
    }
}

class ModuleVo: HandyJSON {
    var link_url: String?
    var pos: Int?   //7  位置
    var title : String?
    var key: String?  // focus
    var picurl: String?  //图片地址
    var title_more: String?  //更多
    var style: Int?  //样式
    var jump: String?
    required init()  {}
}

/// 焦点图
class FocusVo: HandyJSON {
   var randpic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_1478599191f68b96379606a96464c35f0cec64fc0d.jpg
   var code: String?  //http://music.baidu.com/cms/webview/topic_activity/mobile-tmp-v58/
   var mo_type: Int?    // 4
   var type: Int?    // 6
   var is_publish: String?  //111100
   var randpic_iphone6: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_1478599191f68b96379606a96464c35f0cec64fc0d.jpg
   var randpic_desc: String?  //一周音乐热54
    required init() {
        
    }
}

/// 原创音乐
class Mix_9Vo: HandyJSON {
   var desc: String?  //
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_147849912588f3d14d0fd83e8a774ecdb43d5bf5a1.jpg
   var type_id: String?  //354347960
   var type:Int?    // 0
   var title: String?  //冬日暖心歌
   var tip_type: Int?   // 0
   var author: String?  //
    required init() {
        
    }
}

/// 热销专辑
class Mix_22Vo: HandyJSON {
   var desc: String?  //陈奕迅
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_14785344587a85d36a0b97d10134b46828be11add4.jpg
   var type_id: String?  //275722791
   var type:Int?    // 2
   var title: String?  //让我留在你身边
   var tip_type:Int?    // 0
   var author: String?  //陈奕迅
    required init() {
        
    }
}


/// 音乐导航
class EntryVo: HandyJSON {
   var day: String?  //
   var title: String?  //歌手
   var icon: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_1473481741f98ba11546240fa2e83a408520941529.jpg
   var jump: String?  //2
    required init() {
        
    }
}

/// 专栏
class Mod_7Vo: HandyJSON {
   var desc: String?  //一周音乐热vol.54 网罗一周乐坛动态
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_1478599475f83ca4487888a2a2bb17e1efbb79e53f.jpg
   var type_id: String?  //http://music.baidu.com/cms/webview/topic_activity/mobile-tmp-v58/
   var type: Int?   // 4
   var title: String?  //听《Ego-Holic恋我癖》 看蔡依林一本正经地诠释自恋
   var tip_type: Int?   // 0
   var author: String?  //
    required init() {
        
    }
}

/// 最热MV推荐
class Mix_5Vo: HandyJSON {
    required init() {
        
    }
   var desc: String?  //黄龄
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_147857662149735032f83cb9336925378295c2c653.jpg
   var type_id: String?  //276600418
   var type: Int?    // 5
   var title: String?  //我们都不应该孤单
   var tip_type: Int?    // 0
   var author: String?  //黄龄
}

/// 今日推荐歌曲
class RecsongVo: HandyJSON {
   var resource_type_ext: String?  //0
   var learn: String?  //0
   var del_status: String?  //0
   var korean_bb_song: String?  //0
   var versions: String?  //
   var title: String?  //Melt The Snow
   var bitrate_fee: String?  //{\0\:    //\129|-1\\1\:    //\-1|-1\}
   var song_id: String?  //389105
   var has_mv_mobile: String?  //1
   var pic_premium: String?  //http://musicdata.baidu.com/data2/pic/115456822/115456822.jpg
   var author: String?  //Shayne Ward
    required init() {
        
    }
}
/// 乐播节目
class RadioVo: HandyJSON {
    required init() {
        
    }
   var desc: String?  //都市情感
   var itemid: String?  //13336164
   var title: String?  //《半梦半醒》：到底夜夜是谁在梦里说 愿这一生不必再醒（主播：辰熙澤）
   var album_id: String?  //12545344
   var type: String?  //lebo
   var channelid: String?  //11373553
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_04d2a5477c566f41d2299ab7d5a0e915.jpg
}

/// 新碟上架
class AlbumVo: HandyJSON {
    required init() {
        
    }
   var desc: String?  //江若琳
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_1478590829c7d956ba00b77dd572357e7db739b0bf.jpg
   var type_id: String?  //276598596
   var type: Int?    // 2
   var title: String?  //星星之火
   var tip_type: Int?   // 0
   var author: String?  //江若琳
}
/// 商城固定入口
class Mod_27Vo: HandyJSON {
    required init() {
        
    }
   var desc: String?  //
   var pic: String?  //http://business.cdn.qianqian.com/qianqian/pic/bos_client_14745353609f61ad83b6d05321e2aae437b86d6404.jpg
   var type_id: String?  //http://music.baidu.com/mall?from=ios_music_homeHot
   var type: Int?  // 4
   var title: String?  //商城
   var tip_type: Int?   // 0
   var author: String?  //
}

/// 场景电台
class AllSence: HandyJSON {
    var action: [SceneVo]?
    var emotion: [SceneVo]?
    var operation: [SceneVo]?
    var other: [SceneVo]?
    required init() {    }
}
class SceneVo: HandyJSON {
    required init() {
        
    }
   var icon_ios: String?  //http://b.hiphotos.baidu.com/ting/pic/item/a5c27d1ed21b0ef4d176a9aedbc451da80cb3ea7.jpg
   var scene_name: String?  //放松
   var bgpic_android: String?  //
   var icon_android: String?  //http://a.hiphotos.baidu.com/ting/pic/item/0b7b02087bf40ad1e3996ee0502c11dfa9ecceb0.jpg
   var scene_model: String?  //1
   var scene_desc: String?  //
   var bgpic_ios: String?  //
   var scene_id: String?  //8
}

/// 歌单推荐
class DiyVo: HandyJSON {
    required init() {
        
    }
   var position: Int?   // 1
   var tag: String?  //影视原声流行快乐
   var songidlist: String?   // [ ]
   var pic: String?  //http://musicugc.cdn.qianqian.com/ugcdiy/pic/a0d8a28660975e8ea079145bdb0f7c67.jpg
   var title: String?  //好听到停不下来的广告歌曲
   var collectnum: Int?    // 17
   var type: String?  //gedan
   var listenum: Int?    // 6224
   var listid: String?  //363685857
}
