//
//  AppBottomView.swift
//  JJMusic
//
//  Created by coco on 16/10/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//  App底部播放条

import UIKit

class AppBottomView: UIView {

    /// 单例
    static let shared: AppBottomView = AppBottomView.init()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    private init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    
    private func configUI() {
        self.addGestureRecognizer(self.tapGesture)
        self.addSubview(topL)
        self.addSubview(iconImageV)
        self.addSubview(songNameL)
        self.addSubview(singerL)
        self.addSubview(pauseB)
        self.addSubview(nextB)
        self.addSubview(progressV)
        
        iconImageV.snp.makeConstraints {[unowned self] (make) in
            make.height.width.equalTo(42)
            make.left.top.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
        }
        topL.snp.makeConstraints {[unowned self] (make) in
            make.right.top.left.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        songNameL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.snp.top).offset(3)
            make.height.left.right.equalTo(self.singerL)
            make.left.equalTo(self.iconImageV.snp.right).offset(5)
            make.right.equalTo(self.pauseB.snp.right).offset(-5)
        }
        
        singerL.snp.makeConstraints {[unowned self] (make) in
            make.bottom.equalTo(self.iconImageV.snp.bottom).offset(-3)
            make.top.equalTo(self.songNameL.snp.bottom)
        }
        
        nextB.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.width.equalTo(self.iconImageV)
        }
        pauseB.snp.makeConstraints {[unowned self] (make) in
            make.top.width.height.equalTo(self.nextB)
            make.right.equalTo(self.nextB.snp.left)
        }
        
        progressV.snp.makeConstraints {[unowned self] (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.iconImageV.snp.bottom)
            make.height.equalTo(2)
        }
    }
    
    /**上面的线*/
    private lazy var topL: UIView = {
        let object = UIView()
        object.backgroundColor = lightLineColor
        return object
    }()

    
    /**图片icon*/
    private lazy var iconImageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "icon_home_default"))
        object.backgroundColor = UIColor.colorWithRGB(r: 224, g: 224, b: 224)
        object.contentMode = .scaleToFill
        return object
    }()

    /**歌曲名称*/
    private lazy var songNameL: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 13)
        object.text = "Bye Bye Bye"
        object.textColor = normalTextColor
        return object
    }()
    
    /**歌手*/
    private lazy var singerL: UILabel = {
        let object = UILabel()
        object.text = "Lovestoned"
        object.font = UIFont.systemFont(ofSize: 12)
        object.textColor = lightTextColor
        return object
    }()
    
    /**暂停播放*/
    private lazy var pauseB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "btn_bofang"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "btn_bofang_dis"), for: UIControlState.highlighted)
        return object
    }()
    
    /**下一首*/
    private lazy var nextB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "btn_next"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "btn_next_dis"), for: UIControlState.highlighted)
        return object
    }()
    
    /**进度条*/
    private lazy var progressV: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.blue
        return object
    }()
    
    /// tap
    fileprivate lazy var tapGesture: UITapGestureRecognizer = {
        let object = UITapGestureRecognizer(target: self, action: #selector(AppBottomView.didTap(sender:)))

        return object
    }()

    @objc private func didTap(sender: UITapGestureRecognizer) {
        
    }

}
