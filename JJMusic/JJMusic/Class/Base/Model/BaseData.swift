//
//  BaseData.swift
//  JJMusic
//
//  Created by coco on 16/11/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

class BaseData: HandyJSON {
    var errno: Int?
    var error_code: Int = 0  //错误编码
    var error_message: String?  //错误消息
    required init() {
    }
    
    func mapping(mapper: HelpingMapper) {    }
}
