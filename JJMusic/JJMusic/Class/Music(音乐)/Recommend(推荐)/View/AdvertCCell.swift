//
//  AdvertCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//  广告(小)cell

import UIKit

class AdvertCCell: UICollectionViewCell {
    
    var mod_27: Mod_27Vo? {
        didSet {
            if let icon = mod_27?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            } else {
                //TODO: 默认图片
                self.imageV.image = nil
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
        imageV.snp.makeConstraints {[unowned self] (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    
    /// imageV
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()

}
