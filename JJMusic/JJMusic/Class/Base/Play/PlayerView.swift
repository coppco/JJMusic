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
    
    static let shared: PlayerView = PlayerView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        PlayerTool.shared.deledate = self
        self.backgroundColor = UIColor.lightGray
        self.addSubview(backB)
        backB.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsetsMake(20, 10, 0, 0))
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.addSubview(bottomV)
        bottomV.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(self.snp.height).dividedBy(3)
        }
    }
    
    //MARK: Func
    @objc fileprivate func didClickedButton(sender: UIButton) {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: animationDuration, animations: { 
            self.y = kMainScreenHeight
            }) { (flag) in
                self.isUserInteractionEnabled = true
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

    /// backB  //返回
    fileprivate lazy var backB: UIButton = {
        let object = UIButton()
        object.setImage(UIImage(named: "player_return"), for: UIControlState.normal)
        object.addTarget(self, action: #selector(PlayerView.didClickedButton(sender:)), for: UIControlEvents.touchUpInside)
        return object
    }()
    
    /// moreB  更多
    fileprivate lazy var moreB: UIButton = {
        let object = UIButton()
        return object
    }()

    /// qualityB 品质
    fileprivate lazy var qualityB: UIButton = {
        let object = UIButton()
        return object
    }()
    /// titleL
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
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
    }
    
    func AVPlayerDidEnd() {
        PlayerTool.shared.seekToTime(second: 0)
    }
}
