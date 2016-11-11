//
//  MusicCHeaderView.swift
//  JJMusic
//
//  Created by coco on 16/11/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MusicCHeaderView: UICollectionReusableView {
    
    var moduleVo: ModuleVo? {
        didSet {
            if let icon = moduleVo?.picurl {
                self.iconImageV.kf.setImage(with: URL.init(string: icon), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                    self.iconImageV.image = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                })
            }
            self.moreB.setTitle(moduleVo?.title_more, for: UIControlState.normal)
            self.titleL.text = moduleVo?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    private func configUI() {
        self.addSubview(iconImageV)
        self.addSubview(titleL)
        self.addSubview(moreB)
        
        iconImageV.snp.makeConstraints { (make) in
            make.left.equalTo(itemLeftRight)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.bottom.top.equalTo(UIEdgeInsetsMake(topBottom, 0, topBottom, 0))
        }
        titleL.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageV)
            make.left.equalTo(iconImageV.snp.right).offset(10)
        }
        moreB.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageV)
            make.right.equalTo(self.snp.right).offset(-itemLeftRight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// icon
    fileprivate lazy var iconImageV: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "icon_home_XUEXI_normal")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return object
    }()
    
    /// label
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.text = "热销专辑"
        object.textColor = UIColor.black
        object.font = UIFont.systemFont(ofSize: 14)
        return object
    }()

    /// more
    fileprivate lazy var moreB: UIButton = {
        let object = UIButton()
        object.setTitle("更多", for: UIControlState.normal)
        object.setTitleColor(UIColor.gray, for: UIControlState.normal)
        object.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return object
    }()
    
    
}
