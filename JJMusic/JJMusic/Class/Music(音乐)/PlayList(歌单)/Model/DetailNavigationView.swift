//
//  DetailNavigationView.swift
//  JJMusic
//
//  Created by M_coppco on 2016/11/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class DetailNavigationView: UIView {
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
        self.addSubview(backB)
        
        backB.snp.makeConstraints {[unowned self] (make) in
            make.bottom.left.equalTo(self)
            make.top.equalTo(self.snp.top).offset(20)
            make.width.equalTo(40)
        }
    
        moreB.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(self.snp.top).offset(20)
            make.width.equalTo(36)
        }
    }
    /**更多*/
    private lazy var moreB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "player_more"), for: UIControlState.normal)
        object.addTarget(self, action: #selector(DetailNavigationView.didClickedButton(sender:)), for: UIControlEvents.touchUpInside)
        return object
    }()
    
    /**返回*/
    private lazy var backB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(#imageLiteral(resourceName: "ic_recommend_back_normal"), for: UIControlState.normal)
        object.setImage(#imageLiteral(resourceName: "ic_recommend_back_press"), for: UIControlState.highlighted)
        object.addTarget(self, action: #selector(DetailNavigationView.didClickedButton(sender:)), for: UIControlEvents.touchUpInside)
        return object
    }()
    
    @objc private func didClickedButton(sender: UIButton) {
        if sender == self.backB {
            _ = self.viewController?.navigationController?.popViewController(animated: true)
        } else {
        }
    }
    /**线*/
    private lazy var bottomL: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.colorWithRGB(r: 95, g: 73, b: 95)
        return object
    }()
    
    ///titleL
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white
        object.font = UIFont.systemFont(ofSize: 20)
        return object
    }()
}

