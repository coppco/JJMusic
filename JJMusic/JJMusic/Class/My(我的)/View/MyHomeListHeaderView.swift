//
//  MyHomeListHeaderView.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyHomeListHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(playListL)
        self.contentView.addSubview(newPlayListB)
        self.contentView.addSubview(batchB)
        self.contentView.addSubview(bottomL)
        
        playListL.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.height.equalTo(24)
        }
        batchB.snp.makeConstraints { (make) in
            make.centerY.equalTo(playListL)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
        }
        newPlayListB.snp.makeConstraints { (make) in
            make.centerY.equalTo(playListL)
            make.right.equalTo(batchB.snp.left).offset(-10)
        }
        
        bottomL.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.3)
        }
    }
    
    /**歌单*/
    private lazy var playListL: UILabel = {
        let object = UILabel()
        object.text = "自建歌单"
        object.font = UIFont.systemFont(ofSize: 13)
        object.textColor = normalTextColor
        return object
    }()
    
    /**新建歌单*/
    private lazy var newPlayListB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(UIImage(named: "bt_localplaylist_add_normal"), for: UIControlState.normal)
        object.setImage(UIImage(named: "bt_localplaylist_add_press"), for: UIControlState.highlighted)
        return object
    }()

    /**批量*/
    private lazy var batchB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        
        object.setImage(UIImage(named: "bt_collectiondetails_edit_normal"), for: UIControlState.normal)
        object.setImage(UIImage(named: "bt_collectiondetails_edit_press"), for: UIControlState.highlighted)
        return object
    }()

    
    /**bottomL*/
    private lazy var bottomL: UIView = {
        let object = UIView()
        object.backgroundColor = lightLineColor
        return object
    }()


}
