//
//  MyHomeCollectionHeaderView.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyHomeCollectionHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(myCollectionL)
        self.contentView.addSubview(playListB)
        self.contentView.addSubview(albumB)
        self.contentView.addSubview(singerB)
        self.contentView.addSubview(line1)
        self.contentView.addSubview(line2)
        self.contentView.addSubview(bottomL)
        
        
        myCollectionL.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.height.equalTo(24)
        }
        
        singerB.snp.makeConstraints { (make) in
            make.centerY.equalTo(myCollectionL)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.width.equalTo(40)
        }
        
        line1.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(singerB)
            make.width.equalTo(0.3)
            make.right.equalTo(singerB.snp.left)
        }
        
        albumB.snp.makeConstraints { (make) in
            make.centerY.equalTo(myCollectionL)
            make.right.equalTo(self.line1.snp.left)
            make.width.equalTo(40)
        }
        
        line2.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(singerB)
            make.width.equalTo(0.3)
            make.right.equalTo(albumB.snp.left)
        }
        
        playListB.snp.makeConstraints { (make) in
            make.centerY.equalTo(myCollectionL)
            make.right.equalTo(self.line2.snp.left)
            make.width.equalTo(40)
        }
        bottomL.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.3)
        }
    }
    
    /**我的收藏*/
    private lazy var myCollectionL: UILabel = {
        let object = UILabel()
        object.text = "我的收藏"
        object.font = UIFont.systemFont(ofSize: 13)
        object.textColor = normalTextColor
        return object
    }()
    
    /**歌单*/
    private lazy var playListB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setTitleColor(lightTextColor, for: UIControlState.normal)
        object.setTitle("歌单", for: UIControlState.normal)
        object.titleLabel?.font = .systemFont(ofSize: 13)
        return object
    }()
    
    /**专辑*/
    private lazy var albumB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setTitleColor(lightTextColor, for: UIControlState.normal)
        object.setTitle("专辑", for: UIControlState.normal)
        object.titleLabel?.font = .systemFont(ofSize: 13)
        return object
    }()
    
    /**歌手*/
    private lazy var singerB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setTitleColor(lightTextColor, for: UIControlState.normal)
        object.setTitle("歌手", for: UIControlState.normal)
        object.titleLabel?.font = .systemFont(ofSize: 13)
        return object
    }()

    /**线l*/
    private lazy var line1: UIView = {
        let object = UIView()
        object.backgroundColor = lightLineColor
        return object
    }()

    /**线2*/
    private lazy var line2: UIView = {
        let object = UIView()
        object.backgroundColor = lightLineColor
        return object
    }()
    
    /**bottomL*/
    private lazy var bottomL: UIView = {
        let object = UIView()
        object.backgroundColor = lightLineColor
        return object
    }()
}
