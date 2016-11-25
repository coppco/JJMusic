//
//  PlayerTool.swift
//  JJMusic
//
//  Created by coco on 16/11/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import AVFoundation

@objc protocol PlayerToolDelegate {
    /// 播放器可以播放, 更新音乐的最大时间
    func AVPlayerCanPlay(playerItem: AVPlayerItem)
    /// 播放器正在播放, 更新滑块时间和进度
    func AVPlayerPlaying(playerItem: AVPlayerItem)
    /// 播放器缓冲进度, 更新缓冲进度条
    func AVPlayerLoading(playerItem: AVPlayerItem)
    /// 播放器结束播放
    func AVPlayerDidEnd()
}

/// 播放工具, 单例模式
class PlayerTool: NSObject {
    //MARK:  OPEN API
    /// 单例
    static var shared: PlayerTool = PlayerTool()
    private override init() {
    }
    /// 播放音乐
    ///
    /// - parameter url: 地址, http网络音乐或者本地音乐
    func playWithURL(urlString: String) {
        guard let version = UIDevice.current.systemVersion.decimalValue else {
            MBProgressHUD.show_Error(message: "手机系统版本异常")
            return
        }
        if urlString.characters.count == 0 {
            return 
        }
        
        if self.player != nil {
            self.player.pause()
            self.clearnPlayer()
        }
        
        //iOS 9以前或者本地音乐直接播放
        if urlString.hasPrefix("ipod") {
            self.playItem = AVPlayerItem(url: URL(string: urlString)!)
            if self.player == nil {
                self.player = AVPlayer(playerItem: self.playItem)
            } else {
                self.player.replaceCurrentItem(with: self.playItem)
            }
        } else if version < 11.0 || !urlString.hasPrefix("http") {
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
            //使用下载器下载音乐
            if self.player == nil {
                self.player = AVPlayer(playerItem: self.playItem)
            } else {
                self.player.replaceCurrentItem(with: self.playItem)
            }
        }
        
        //添加观察者
        self.playItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        self.playItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        
        //通知播放完成
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerTool.endPlay(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    //MARK: Private API
    fileprivate var player: AVPlayer!
    fileprivate var playItem: AVPlayerItem!
    fileprivate var musicAsset: AVURLAsset!
    weak var deledate: PlayerToolDelegate?
    fileprivate var playerObserver: Any?
    /// 是否在播放
    fileprivate var isPlaying: Bool {
        if self.player != nil {
            return self.player.rate == 1.0 && self.player.error == nil
        }
        return false
    }
    /// 是否在暂停
    fileprivate var isPause: Bool {
        if self.player != nil {
            return self.player.rate == 0.0 && self.player.error == nil
        }
        return false
    }
    
    /// 重新设置播放器
    fileprivate func clearnPlayer() {
        if self.playItem == nil {
            return
        }
        NotificationCenter.default.removeObserver(self)
        self.playItem.removeObserver(self, forKeyPath: "status")
        self.playItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
        if self.playerObserver != nil {
            self.player.removeTimeObserver(self.playerObserver)
            self.playerObserver = nil
        }
        self.playItem = nil
    }
    /// 停止
    func stop() {
        if self.player != nil {
            self.player.pause()
            self.clearnPlayer()
        }
    }
    /// 暂停
    func pause() {
        if self.player != nil {
            self.player.pause()
        }
    }
    /// 播放或者暂停
    func playOrPause() {
        if self.playItem == nil || self.player == nil {
            return
        }
        if self.isPause && !self.isPlaying {
            self.player.play()
        }else if self.isPlaying && !self.isPause {
            self.player.pause()
        }
    }
    /// 快进
    func seekToTime(second: CGFloat) {
        if self.player == nil || self.playItem == nil {
            return
        }
        self.player.pause()
        self.player.seek(to: CMTime.init(seconds: Double(second), preferredTimescale: CMTimeScale(NSEC_PER_SEC))) {[weak self] (flag) in
            self?.player.play()
        }
    }
}

extension PlayerTool {
    //播放完成
    @objc fileprivate func endPlay(notification: Notification) {
        self.deledate?.AVPlayerDidEnd()
    }
    //观察者方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let playerItem = object as? AVPlayerItem {
            if keyPath == "status" {  //播放状态
                if playerItem.status == .readyToPlay {
                    self.canPlay(item: playerItem)
                } else {  //未知或失败
                    
                }
            } else if keyPath == "loadedTimeRanges"{ //播放器下载进度
                self.deledate?.AVPlayerLoading(playerItem: playerItem)
            }
        }
    }
    
    // 可以播放
    fileprivate func canPlay(item: AVPlayerItem) {
        //代理更新总时间等
        self.deledate?.AVPlayerCanPlay(playerItem: item)
        //申请后台播放
        self.player.play()
        //监听avplayer  更新进度等
        self.playerObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: DispatchQueue.main) {[weak self] (time) in
            self?.deledate?.AVPlayerPlaying(playerItem: (self?.playItem)!)
        }
    }
}
