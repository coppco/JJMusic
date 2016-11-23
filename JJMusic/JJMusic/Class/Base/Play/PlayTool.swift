//
//  PlayTool.swift
//  JJMusic
//
//  Created by coco on 16/11/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import AVFoundation

/// 播放工具, 单例模式
class PlayTool {
    //MARK:  OPEN API
    /// 单例
    static var shared: PlayTool = PlayTool()
    private init() {
    }
    /// 播放音乐
    ///
    /// - parameter url: 地址, http网络音乐或者本地音乐
    func playWithURL(urlString: String) {
        guard let version = UIDevice.current.systemVersion.decimalValue else {
            MBProgressHUD.show_Error(message: "手机系统版本异常")
            return
        }
        
        //iOS 7以前或者本地音乐直接播放
        if version < 7.0 || !urlString.hasPrefix("http") {
            var url: URL!
            if urlString.hasPrefix("http") {
                url = URL(string: urlString)
            } else {
                url = URL(fileURLWithPath: urlString)
            }
            self.musicAsset = AVURLAsset(url: url)
            self.playItem = AVPlayerItem(asset: self.musicAsset)
            if self.player == nil {
                self.player = AVPlayer(playerItem: self.playItem)
            } else {
                self.player.replaceCurrentItem(with: self.playItem)
            }
        } else {
            //使用
            if self.player == nil {
                self.player = AVPlayer(playerItem: self.playItem)
            } else {
                self.player.replaceCurrentItem(with: self.playItem)
            }
        }
    }
    
    //MARK: Private API
    private var player: AVPlayer!
    private var playItem: AVPlayerItem!
    private var musicAsset: AVURLAsset!
    
}
