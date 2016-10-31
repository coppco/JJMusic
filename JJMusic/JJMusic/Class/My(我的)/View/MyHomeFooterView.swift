//
//  MyHomeFooterView.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyHomeFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configUI() {
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(tipsL)
        
        tipsL.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView).offset(20)
            make.height.equalTo(20)
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
        }
        
        imageV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 14))
            make.centerY.equalTo(tipsL)
            make.right.equalTo(tipsL.snp.left).offset(-5)
        }
    }
    
    /**图片*/
    private lazy var imageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "icon_cloud"))
        return object
    }()
    
    /**tips*/
    private lazy var tipsL: UILabel = {
        let object = UILabel()
        object.text = "立即登录,让音乐跟着走"
        object.font = .systemFont(ofSize: 13)
        object.textColor = UIColor.colorWithRGB(r: 144, g: 172, b: 199)
        return object
    }()
}
