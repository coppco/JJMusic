//
//  HomeNavigationView.swift
//  JJMusic
//
//  Created by coco on 16/10/28.
//  Copyright © 2016年 XHJ. All rights reserved.
// 首页顶部view

import UIKit

class HomeNavigationView: UIView {
    /// 单例
    static let shared: HomeNavigationView = HomeNavigationView.init()
    
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
        self.backgroundColor = UIColor.clear
        self.addSubview(moreB)
        self.addSubview(searchB)
        self.addSubview(bottomL)
        
        moreB.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.bottom.left.equalTo(self)
            make.height.equalTo(44)
            make.width.equalTo(70)
        }
        
        searchB.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(moreB)
            make.right.equalTo(self)
        }
        bottomL.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.3)
        }
    }
    
    /**更多*/
    private lazy var moreB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "bt_home_more_normal"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "bt_home_more_press"), for: UIControlState.highlighted)
        return object
    }()
    
    /**搜索*/
    private lazy var searchB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "bt_home_search1_normal"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "bt_home_search1_press"), for: UIControlState.highlighted)
        return object
    }()

    /**线*/
    private lazy var bottomL: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.colorWithRGB(r: 95, g: 73, b: 95)
        return object
    }()


}
