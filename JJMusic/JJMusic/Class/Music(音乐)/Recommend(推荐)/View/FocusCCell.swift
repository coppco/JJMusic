//
//  FocusCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//  焦点图Cell

import UIKit

class FocusCCell: UICollectionViewCell {
    
    var focusArray: [FocusVo]? {
        didSet {
            if let array = focusArray {
                var address = [String]()
                for item in array {
                    if let icon = item.randpic_iphone6 {
                        address.append(icon)
                    }
                }
                if address.count != 0 {
                    self.focusView.pictureArray = address
                }
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.addSubview(focusView)
        focusView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    /// 轮播图
    fileprivate lazy var focusView: HJWheelView = {
        let object = HJWheelView(pictureArray: ["homepage_focus_default"], isLoop: true, duration: 3, didSelectItem: { (collection, index) in
            
        })
        return object
    }()

}
