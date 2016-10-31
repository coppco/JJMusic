//
//  HTTPMethod.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

private let baseURL = "http://tingapi.ting.baidu.com/v1/restserver/ting?method="
private let musicVersion = "5.9.1"

struct HTTP {
    
    /// 获取App信息
    static let getAppInfo = baseURL + "baidu.ting.active.iosVersionInfo&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// 获取音乐-推荐
    static let getRecommend = baseURL + "baidu.ting.plaza.index&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// 获取音乐-歌单
    static let getPlayList = baseURL + "baidu.ting.ugcdiy.getChanneldiy&timestamp=1477896880&param=rcdr3d/KZDB6bTsgrQP10IgbPYXIg4WEJFjeL4cTVZKdsziCv7wa9WM0Bh+1ORljTYyYkCbWMM6cNOBPUgB3TtRATWCy0I4knTVGHQF8UEqiJIkFIeeXccwh24TvuZN5+t+KmjzAFtHfTbGI/9XgJyM60bNsrylsUWtGITkmRZU=&sign=27e63d584805e2c970c697101e9a996f&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// 获取音乐-榜单
    static let getList = baseURL + "baidu.ting.billboard.billCategory&format=json&from=ios&kflag=2&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// K歌曲顶部图片
    static let KSongTopImage = baseURL + "baidu.ting.active.showList&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// K歌-大家都在唱歌
    static let KSongEveryone = baseURL + "baidu.ting.learn.now&from=ios&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// K歌-我的K歌
    static let KSongMyK = baseURL + "baidu.ting.learn.category&from=ios&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
    
    /// 动态
    static let dynamic = baseURL + "baidu.ting.ugcfriend.getList&channel=(null)&cuid=appstore&from=ios&version=" + musicVersion
}
