//
//  EntryCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//  音乐导航Cell

import UIKit

class EntryCCell: UICollectionViewCell {
    
    var entry: EntryVo? {
        didSet {
            self.titleL.text = entry?.title
            if let icon = entry?.icon {
                self.imageV.kf.setImage(with: URL.init(string: icon), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                    self.imageV.image = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                })
            }
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(titleL)
        imageV.snp.makeConstraints { (make) in
            make.size.equalTo(self.contentView.snp.width).multipliedBy(0.5)
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView).multipliedBy(0.8)
        }
        titleL.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    /// 图片
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()

    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 13)
        object.textAlignment = .center
        return object
    }()
    
    override func tintColorDidChange() {
        self.titleL.textColor = self.tintColor
    }
}
