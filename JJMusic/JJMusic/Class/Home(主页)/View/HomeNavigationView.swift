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
    
    var didSelectedButton: ((Int) -> Void)?
    
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
        self.addSubview(scrollView)
        
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
        
        createButton()
    }
    
    private func createButton() {
        if self.titlesArray.count == 0 {
            return
        }
        var count = self.titlesArray.count
        if count > 3 {
            count = 3
        }
        let width = (kMainScreenWidth - 2 * 80 ) / CGFloat(count)
        for (index, item) in self.titlesArray.enumerated() {
            let button = UIButton(type: UIButtonType.custom)
            button.setTitle(item, for: UIControlState.normal)
            button.setTitleColor(UIColor.gray, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(HomeNavigationView.buttonHasClicked(sender:)), for: UIControlEvents.touchUpInside)
            button.tag = 7770 + index
            scrollView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.bottom.top.equalTo(width * CGFloat(index))
                make.width.equalTo(width)
                make.bottom.equalTo(self.snp.bottom)
                make.bottom.equalTo(scrollView.snp.bottom)
                make.top.equalTo(self.snp.top).offset(20)
                if index == self.titlesArray.count - 1 {
                    make.right.equalTo(scrollView.snp.right)
                }
                if index == 0 {
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                    self.selectedB = button
                    make.left.equalTo(scrollView.snp.left)
                }
            })
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(80)
            make.right.equalTo(self.snp.right).offset(-80)
        }
    }
    
    @objc private func buttonHasClicked(sender: UIButton) {
        if selectedB == sender {
            return
        }
        selectedB?.setTitleColor(UIColor.gray, for: UIControlState.normal)
        sender.setTitleColor(UIColor.white, for: UIControlState.normal)
        selectedB = sender
        if let closure = self.didSelectedButton {
            closure(sender.tag - 7770)
        }
    }
    
    /// selectedB
    fileprivate var selectedB: UIButton?
    
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

    /// 标题
    fileprivate lazy var titlesArray: [String] = {
        return ["我的", "主页", "动态"]
    }()
    
    ///
    fileprivate lazy var scrollView: UIScrollView = {
        let object = UIScrollView()
        return object
    }()
}
