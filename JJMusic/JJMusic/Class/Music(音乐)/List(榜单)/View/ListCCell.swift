//
//  ListCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ListCCell: UICollectionViewCell {
    
    var listVo: ListVo? {
        didSet {
            if let icon = listVo?.pic_s192 {
                self.imageV.kf.setImage(with: URL(string: icon))
            }
            if let listSong = listVo?.content {
                for (index, item) in listSong.enumerated() {
                    if index == 0 {
                        self.firstL.text = (item.title ?? "") + " - " + (item.author ?? "")
                    } else if index == 1 {
                        self.secondL.text = (item.title ?? "") + " - " + (item.author ?? "")
                    } else if index == 2 {
                        self.thirdL.text = (item.title ?? "") + " - " + (item.author ?? "")
                    } else {
                        break
                    }
                }
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
    
    
    /// 监听高亮
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                self.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
            } else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(firstL)
        self.contentView.addSubview(secondL)
        self.contentView.addSubview(thirdL)
        
        imageV.snp.makeConstraints {[unowned self] (make) in
            make.top.bottom.left.equalTo(UIEdgeInsetsMake(topBottom, itemLeftRight, topBottom, 0))
            make.width.equalTo(self.imageV.snp.height)
        }
        
        firstL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.imageV.snp.top)
            make.height.equalTo(self.secondL)
            make.height.equalTo(self.thirdL)
            make.left.equalTo(self.imageV.snp.right).offset(itemLeftRight)
            make.right.equalTo(self.contentView.snp.right).offset(-itemLeftRight)
        }
        
        secondL.snp.makeConstraints {[unowned self] (make) in
            make.left.right.equalTo(self.firstL)
            make.top.equalTo(self.firstL.snp.bottom)
        }
        
        thirdL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.secondL.snp.bottom)
            make.left.right.equalTo(self.secondL)
            make.bottom.equalTo(self.imageV.snp.bottom)
        }
        
    }
    
    /// imageV
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    /// firstL
    fileprivate lazy var firstL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    /// secondL
    fileprivate lazy var secondL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = .systemFont(ofSize: 12)
        return object
    }()

    /// thirdL
    fileprivate lazy var thirdL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = .systemFont(ofSize: 12)
        return object
    }()


}
