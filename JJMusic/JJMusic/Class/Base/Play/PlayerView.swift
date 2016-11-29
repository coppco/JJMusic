//
//  PlayerView.swift
//  JJMusic
//
//  Created by coco on 16/11/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    private init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    //MARK: Open API
    static let shared: PlayerView = PlayerView()
    
    //隐藏
    @objc func dismiss(sender: UIButton) {
        if !self.isShow { return }
        self.isShow = false
        appDelegate.window?.isUserInteractionEnabled = false
        UIView.animate(withDuration: animationDuration, animations: {
            self.y = kMainScreenHeight
        }) { (flag) in
            appDelegate.window?.isUserInteractionEnabled = true
        }
    }
    
    //显示
    func show() {
        if self.isShow { return }
        self.isShow = true
        self.isUserInteractionEnabled = false
        appDelegate.window?.isUserInteractionEnabled = false
        UIView.animate(withDuration: animationDuration, animations: {
            appDelegate.playerView.y = 0
        }) { (falg) in
            self.isUserInteractionEnabled = true
            appDelegate.window?.isUserInteractionEnabled = true
        }
    }
    //下一曲
    func nextSong() {
        
    }
    //上一曲
    func previousSong() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        PlayerTool.shared.deledate = self
        self.backgroundColor = UIColor.lightGray
        self.addSubview(backB)
        self.addSubview(topView)
        topView.addSubview(backB)
        topView.addSubview(titleL)
        topView.addSubview(singerL)
        topView.addSubview(qualityB)
        topView.addSubview(moreB)
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
        }
        backB.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsetsMake(20, 10, 0, 0))
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        self.moreB.snp.makeConstraints { (make) in
            make.centerY.equalTo(backB)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(self.snp.right).offset(-itemLeftRight)
        }
        self.titleL.snp.makeConstraints { (make) in
            make.centerY.equalTo(backB)
            make.left.equalTo(backB.snp.right).offset(10)
            make.right.equalTo(self.moreB.snp.left).offset(-10)
        }
        qualityB.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleL)
            make.top.equalTo(self.titleL.snp.bottom)
            make.bottom.equalTo(self.topView).offset(-spacingY)
            make.size.equalTo(CGSize(width: 48, height: 50))
        }
        
        self.singerL.snp.makeConstraints { (make) in
            make.centerY.equalTo(qualityB)
            make.left.equalTo(self.qualityB.snp.right)
        }
        
        self.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(self.snp.height).dividedBy(3)
        }
    }
    
    // MARK: Property
    /// 背景图片
    fileprivate lazy var backImageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    /// topView
    fileprivate lazy var topView: UIView = {
        let object = UIView()
        return object
    }()

    /// backB 返回
    fileprivate lazy var backB: UIButton = {
        let object = UIButton()
        object.setImage(UIImage(named: "player_return"), for: UIControlState.normal)
        object.addTarget(self, action: #selector(PlayerView.dismiss(sender:)), for: UIControlEvents.touchUpInside)
        return object
    }()
    
    /// moreB  更多
    fileprivate lazy var moreB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_more"), for: UIControlState.normal)
        return object
    }()

    /// qualityB 品质
    fileprivate lazy var qualityB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_quality4_414"), for: UIControlState.normal)
        return object
    }()
    /// titleL
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white
        object.font = UIFont.systemFont(ofSize: 20)
        object.text = "第一滴泪"
        return object
    }()
    /// singer
    fileprivate lazy var singerL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white.withAlphaComponent(0.7)
        object.font = UIFont.systemFont(ofSize: 15)
        object.text = "动力火车"
        return object
    }()
    
    /// scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let object = UIScrollView()
        return object
    }()
    
    /// bottomV
    fileprivate lazy var bottomV: PlayerBottomView = {
        let object = PlayerBottomView()
        return object
    }()

    ///isShow
    fileprivate lazy var isShow: Bool = false
}

extension PlayerView: PlayerToolDelegate {
    func AVPlayerCanPlay(playerItem: AVPlayerItem) {
        let duration: TimeInterval = Double(playerItem.duration.value) / Double(playerItem.duration.timescale)
        self.bottomV.updateTotalTime(duration: duration)
        
        //锁屏设置
        
    }
    
    func AVPlayerLoading(playerItem: AVPlayerItem) {
        let array = playerItem.loadedTimeRanges
        guard let timeRange = array.first?.timeRangeValue  else {
            self.bottomV.updateProgress(progress: 0.0, animation: true)
            return
        }
        let timeInterval = timeRange.start.seconds + timeRange.duration.seconds;// 计算缓冲总进度
        let totalDuration = playerItem.duration.seconds
        let progress = timeInterval / totalDuration
        self.bottomV.updateProgress(progress: progress, animation: true)
    }
    
    func AVPlayerPlaying(playerItem: AVPlayerItem) {
        let duration: TimeInterval = Double(playerItem.currentTime().value) / Double(playerItem.currentTime().timescale)
        self.bottomV.updateCurrentTime(currentTime: duration)
        
        //首页进度条
        let total: TimeInterval = Double(playerItem.duration.value) / Double(playerItem.duration.timescale)
        AppBottomView.updateProgressValue(value: Float(duration / total))
    }
    
    func AVPlayerDidEnd() {
        PlayerTool.shared.seekToTime(second: 0)
    }
}
