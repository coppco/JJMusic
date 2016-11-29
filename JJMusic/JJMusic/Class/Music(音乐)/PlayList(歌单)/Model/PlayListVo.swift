
//
//  PlayListVo.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation


class PlayListVo: BaseData {
    var have_more: Bool?
    var nums: Int?
    var diyInfo: [DiyInfoVo]?
}
//歌单
class DiyInfoVo: HandyJSON {
    required init() {
   
    }
    var listen_num: Int?  //1979
    var username: String?  //神奇君
    var song_num: Int?  //20
    var userid: String?  //2698337910
    var list_id: String?  //363711256
    var title: String?  //光棍节又至，你还是一个人么var
    var list_pic: String?  // http://musicugc.cdn.qianqian.com/ugcdiy/pic/8f4466ec42bd61d5137c22c777fcc47e.jpgvar
    var list_pic_large: String?  //http://musicugc.cdn.qianqian.com/ugcdiy/pic/8f4466ec42bd61d5137c22c777fcc47e.jpg@w_300h_300o_1var
    var list_pic_small: String?  // http://musicugc.cdn.qianqian.com/ugcdiy/pic/8f4466ec42bd61d5137c22c777fcc47e.jpg@w_100h_100o_1var
    var list_pic_huge: String?  // http://musicugc.cdn.qianqian.com/ugcdiy/pic/8f4466ec42bd61d5137c22c777fcc47e.jpg@w_500h_500o_1var
    var list_pic_middle: String?  // http://musicugc.cdn.qianqian.com/ugcdiy/pic/8f4466ec42bd61d5137c22c777fcc47e.jpg@w_150h_150o_1var
}
