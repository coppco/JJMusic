//
//  TopImageCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class TopImageCCell: UICollectionViewCell {
    
    var item: KSongTopVo? {
        didSet {
            if let icon = item?.picture_iphone6 {
                self.imageV.kf.setImage(with: URL(string: icon))
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
