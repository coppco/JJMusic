//
//  MyHomeIconHeaderView.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyHomeIconHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.addSubview(iconImageV)
        self.contentView.addSubview(nameL)
        self.contentView.addSubview(detailL)
        
        iconImageV.snp.makeConstraints {[unowned self] (make) in
            make.size.equalTo(CGSize(width: 32, height: 32))
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.left.equalTo(self.contentView.snp.left).offset(15)
        }
        
        nameL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.iconImageV.snp.top)
            make.height.equalTo(self.detailL.snp.height)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.left.equalTo(self.iconImageV.snp.right).offset(10)
        }
        
        detailL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.nameL.snp.bottom)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.left.equalTo(self.iconImageV.snp.right).offset(10)
            make.bottom.equalTo(self.iconImageV.snp.bottom)
        }
    }
    
    /**头像*/
    private lazy var iconImageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "bt_home_login_normal"), highlightedImage: UIImage(named: "bt_home_login_press"))
        return object
    }()

    /**名称*/
    private lazy var nameL: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 13)
        object.textColor = UIColor.white
        object.text = "立即登录"
        return object
    }()
    
    /**详情*/
    private lazy var detailL: UILabel = {
        let object = UILabel()
        object.font = UIFont.systemFont(ofSize: 13)
        object.textColor = UIColor.white
        object.text = "收藏的音乐永不消失"
        return object
    }()
}
