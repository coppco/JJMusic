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
            if let icon = listVo?.pic_s444 {
                self.imageV.kf.setImage(with: URL(string: icon))
            }
            if let listSong = listVo?.content {
                for (index, item) in listSong.enumerated() {
                    if index == 0 {
                        self.firstL.text = (item.title ?? "") + "  -  " + (item.author ?? "")
                    } else if index == 1 {
                        self.secondL.text = (item.title ?? "") + "  -  " + (item.author ?? "")
                    } else if index == 2 {
                        self.thirdL.text = (item.title ?? "") + "  -  " + (item.author ?? "")
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
    
    private func configUI() {
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(firstL)
        self.contentView.addSubview(secondL)
        self.contentView.addSubview(thirdL)
        
        imageV.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(UIEdgeInsetsMake(topBottom, itemLeftRight, topBottom, 0))
            make.width.equalTo(imageV.snp.height)
        }
        
        firstL.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.top)
            make.height.equalTo(secondL)
            make.height.equalTo(thirdL)
            make.left.equalTo(imageV.snp.right).offset(itemLeftRight)
            make.right.equalTo(self.contentView.snp.right).offset(-itemLeftRight)
        }
        
        secondL.snp.makeConstraints { (make) in
            make.left.right.equalTo(firstL)
            make.top.equalTo(firstL.snp.bottom)
        }
        
        thirdL.snp.makeConstraints { (make) in
            make.top.equalTo(secondL.snp.bottom)
            make.left.right.equalTo(secondL)
            make.bottom.equalTo(imageV.snp.bottom)
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
        object.font = .systemFont(ofSize: 13)
        return object
    }()
    /// secondL
    fileprivate lazy var secondL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = .systemFont(ofSize: 13)
        return object
    }()

    /// thirdL
    fileprivate lazy var thirdL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = .systemFont(ofSize: 13)
        return object
    }()


}
