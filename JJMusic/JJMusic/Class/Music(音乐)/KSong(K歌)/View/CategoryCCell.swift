//
//  CategoryCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class CategoryCCell: UICollectionViewCell {
    
    var item: KSongItemVo? {
        didSet {
            if let desc = item?.desc {
                self.titleL.text = desc
                if let icon = CategoryCCell.iconArray[desc] {
                    self.imageV.image = UIImage(named: icon)
                }
            }
        }
    }

    
    /// iconArray
    fileprivate static var iconArray: [String: String] = {
        var object = [String: String]()
        object.updateValue("img_k_ktv", forKey: "KTV热歌榜")
        object.updateValue("img_k_chinese", forKey: "华语金曲")
        object.updateValue("img_k_occident", forKey: "欧美经典")
        object.updateValue("img_k_man", forKey: "男歌手")
        object.updateValue("img_k_woman", forKey: "女歌手")
        object.updateValue("img_k_band", forKey: "乐队组合")
        return object
    }()

    
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
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(titleL)
        imageV.snp.makeConstraints {[unowned self] (make) in
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(self.contentView.snp.width).multipliedBy(0.6)
            make.top.equalTo(self.contentView.snp.top).offset(spacingY)
            make.height.equalTo(self.imageV.snp.width)
        }
        titleL.snp.makeConstraints {[unowned self] (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.imageV.snp.bottom).offset(spacingY)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-spacingY)
        }
    }
    
    /// 图片
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "homepage_album_defaultr")
        return object
    }()
    
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 14)
        object.textColor = UIColor.black
        object.textAlignment = .center
        return object
    }()
}
