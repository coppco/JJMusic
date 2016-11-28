//
//  PlayerBottomView.swift
//  JJMusic
//
//  Created by coco on 16/11/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let spacingH = 10
private let spacingV = 5

class PlayerBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = UIColor.randomColor()
        self.addSubview(downloadB)
        self.addSubview(infomationB)
        self.addSubview(favoriteB)
        self.addSubview(shareB)
        self.addSubview(mvB)
        self.addSubview(currentTimeL)
        self.addSubview(progressV)
        self.addSubview(sliderV)
        self.addSubview(totalTimeL)
        self.addSubview(cycleB)
        self.addSubview(previousB)
        self.addSubview(playB)
        self.addSubview(nextB)
        self.addSubview(playListB)
        
        //中间的文本进度条等
        self.sliderV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.9)
            make.left.equalTo(self.currentTimeL.snp.right).offset(spacingH)
            make.right.equalTo(self.totalTimeL.snp.left).offset(-spacingH)
        }
        
        self.progressV.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.sliderV).offset(0.5)
            make.left.right.equalTo(self.sliderV)
            make.height.equalTo(2)
        }
        
        self.currentTimeL.snp.makeConstraints { (make) in
            make.left.equalTo(itemLeftRight)
            make.centerY.equalTo(self.progressV)
        }
        self.totalTimeL.snp.makeConstraints { (make) in
            make.right.equalTo(-itemLeftRight)
            make.centerY.equalTo(self.progressV)
        }
        
        //顶部五个按钮
        self.favoriteB.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.1)
            make.centerY.equalTo(self.progressV).multipliedBy(0.5)
        }
        
        self.infomationB.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.favoriteB)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.67)
        }
        
        self.downloadB.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.favoriteB)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.33)
        }
        
        self.shareB.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.favoriteB)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.33)
        }
        
        self.mvB.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.favoriteB)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.67)
        }
        
        //下面播放的几个按钮
        self.playB.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.15)
            make.centerY.equalTo(self.progressV).multipliedBy(1.65)
        }
        
        self.previousB.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.playB)
            make.size.equalTo(self.playB.snp.size)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.56)
        }
        
        self.cycleB.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.playB)
            make.size.equalTo(self.playB.snp.size)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.22)
        }
        self.nextB.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.playB)
            make.size.equalTo(self.playB.snp.size)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.44)
        }
        self.playListB.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.playB)
            make.size.equalTo(self.playB.snp.size)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.78)
        }
    }
    
    //MARK: Property
    /// downloadB
    fileprivate lazy var downloadB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_download"), for: UIControlState.normal)
        return object
    }()
    
    /// infomationB
    fileprivate lazy var infomationB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_comment"), for: UIControlState.normal)
        return object
    }()
    
    /// favoriteB
    fileprivate lazy var favoriteB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_love1"), for: UIControlState.normal)
        return object
    }()
    
    /// shareB
    fileprivate lazy var shareB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_share"), for: UIControlState.normal)
        return object
    }()

    /// mvB
    fileprivate lazy var mvB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_mv"), for: UIControlState.normal)
        return object
    }()

    /// currentTimeL
    fileprivate lazy var currentTimeL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white
        object.font = UIFont.systemFont(ofSize: 13)
        object.text = "00:00"
        object.textAlignment = .center
        return object
    }()
    
    /// progressV
    fileprivate lazy var progressV: UIProgressView = {
        let object = UIProgressView()
        object.progressTintColor = UIColor.gray  //填充部分颜色
        object.trackTintColor = UIColor.lightText  //未填充部分颜色
        return object
    }()

    /// sliderV
    fileprivate lazy var sliderV: UISlider = {
        let object = UISlider()
        object.setThumbImage(#imageLiteral(resourceName: "player_slider").imageScaleToSize(size: CGSize(width: 20, height: 20)), for: UIControlState.normal)
        object.maximumTrackTintColor = UIColor.clear
        object.minimumTrackTintColor = self.tintColor
        return object
    }()
    
    /// totalTimeL
    fileprivate lazy var totalTimeL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white
        object.font = UIFont.systemFont(ofSize: 13)
        object.textAlignment = .center
        object.text = "00:00"
        return object
    }()
    
    /// cycleB
    fileprivate lazy var cycleB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_Repeat3"), for: UIControlState.normal)
        return object
    }()

    /// previousB
    fileprivate lazy var previousB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_prevsong"), for: UIControlState.normal)
        return object
    }()
    
    /// playB
    fileprivate lazy var playB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_play"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "player_pause"), for: UIControlState.selected)
        return object
    }()
    
    /// nextB
    fileprivate lazy var nextB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_nextsong"), for: UIControlState.normal)
        return object
    }()
    
    /// playListB
    fileprivate lazy var playListB: UIButton = {
        let object = UIButton()
        object.setImage(#imageLiteral(resourceName: "player_list"), for: UIControlState.normal)
        return object
    }()
}

// MARK: - Open API
extension PlayerBottomView {
    
    /// 更新总时间和滑块最大值
    func updateTotalTime(duration: TimeInterval) {
        self.sliderV.minimumValue = 0
        self.sliderV.maximumValue = Float(duration)
        self.currentTimeL.text = "00:00"
        if duration < 3600 {
            self.totalTimeL.text = String(format: "%02li:%02li", lround(floor(duration / 60.0)),lround(floor(duration / 1.0)) % 60)
        } else {
            self.totalTimeL.text = String(format: "%02li:%02li", lround(floor(duration / 3600.0)),lround(floor(duration / 60.0)))
        }
    }
    /// 更新当前时间和滑块
    func updateCurrentTime(currentTime: TimeInterval) {
        if currentTime < 3600 {
            self.currentTimeL.text = String(format: "%02li:%02li", lround(floor(currentTime / 60.0)),lround(floor(currentTime / 1.0)) % 60)
        } else {
            self.currentTimeL.text = String(format: "%02li:%02li", lround(floor(currentTime / 3600.0)),lround(floor(currentTime / 60.0)))
        }
        self.sliderV.setValue(Float(currentTime), animated: true)
    }
    
    /// 更新进度条
    func updateProgress(progress: Double, animation: Bool) {
        self.progressV.setProgress(Float(progress), animated: animation)
    }
    
    /// 重置播放器
    func resetPlayerStatus() {
    }
}
