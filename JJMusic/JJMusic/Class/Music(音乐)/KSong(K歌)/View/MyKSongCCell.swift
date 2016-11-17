//
//  MyKSongCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyKSongCCell: UICollectionViewCell {
    
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
        self.contentView.addSubview(leftImageV)
        
        self.imageV.snp.makeConstraints {[unowned self] (make) in
            make.top.left.bottom.equalTo(UIEdgeInsetsMake(10, itemLeftRight, 10, 0))
            make.width.equalTo(self.imageV.snp.height)
        }
        
        titleL.snp.makeConstraints {[unowned self] (make) in
            make.centerY.equalTo(self.imageV)
            make.left.equalTo(self.imageV.snp.right).offset(spacingX)
        }
        
        leftImageV.snp.makeConstraints {[unowned self] (make) in
            make.centerY.equalTo(self.imageV)
            make.right.equalTo(self.contentView.snp.right).offset(-itemLeftRight)
        }
    }
    
    /// imageV
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "bt_more_ok_normal")
        return object
    }()
    
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.text = "我的K歌"
        object.textColor = UIColor.black
        object.font = UIFont.systemFont(ofSize: 14)
        return object
    }()
    
    /// leftImage       
    fileprivate lazy var leftImageV: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "ic_home_getInTo")
        return object
    }()

}
