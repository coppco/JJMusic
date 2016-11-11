//
//  DayHotCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//  每日热点Cell

import UIKit

class DayHotCCell: UICollectionViewCell {
    
    var mix_22: Mix_22Vo? {
        didSet {
            if let icon = mix_22?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = mix_22?.title
            self.subTitleL.text = mix_22?.desc
        }
    }

    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                self.backgroundColor = UIColor.colorWithRGB(r: 234, g: 234, b: 234)
            } else {
                self.backgroundColor = UIColor.white
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
    
    private func configUI() {
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(subTitleL)
        
        imageV.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(UIEdgeInsetsMake(topBottom, itemLeftRight, topBottom, 0))
            make.width.equalTo(imageV.snp.height)
        }
        titleL.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.top)
            make.height.equalTo(subTitleL)
            make.left.equalTo(imageV.snp.right).offset(itemLeftRight * 2)
            make.right.equalTo(self.contentView.snp.right).offset(-itemLeftRight * 2)
        }
        subTitleL.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleL)
            make.bottom.equalTo(imageV.snp.bottom)
            make.top.equalTo(titleL.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 图片
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        object.image = UIImage(named: "homepage_album_default")
        return object
    }()
    
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.textAlignment = .center
        object.text = "咱们相爱吧 电视原声带"
        object.textColor = UIColor.black
        object.font = UIFont.systemFont(ofSize: 13)
        object.numberOfLines = 2
        return object
    }()
    
    /// 副标题
    fileprivate lazy var subTitleL: UILabel = {
        let object = UILabel()
        object.textAlignment = .center
        object.text = "刘惜君/明道"
        object.textColor = UIColor.gray
        object.font = UIFont.systemFont(ofSize: 12)
        object.numberOfLines = 2
        return object
    }()

}
