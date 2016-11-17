//
//  RecsongCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//  今日推荐歌曲、专栏Cell

import UIKit

class RecsongCCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageV.image = nil
        self.titleL.text = nil
        self.subTitleL.text = nil
    }
    
    var mod_7: Mod_7Vo? {
        didSet {
            if let icon = mod_7?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = mod_7?.title
            self.subTitleL.text = mod_7?.desc
            self.leftB.setImage(UIImage.init(named: "ic_home_getInTo"), for: UIControlState.normal)
            self.leftB.isUserInteractionEnabled = false
        }
    }
    
    var recsong: RecsongVo? {
        didSet {
            if let icon = recsong?.pic_premium {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = recsong?.title
            self.subTitleL.text = recsong?.author
            self.leftB.setImage(UIImage.init(named: "ic_home_more_normal"), for: UIControlState.normal)
            self.leftB.setImage(UIImage.init(named: "ic_home_more_press"), for: UIControlState.highlighted)
            self.leftB.isUserInteractionEnabled = true
        }
    }
    
    // K歌
    var kSongVo: KSongVo? {
        didSet {
            self.backgroundColor = UIColor.white
            if let icon = kSongVo?.picture_300_300 {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = (kSongVo?.song_title ?? "") + " - " + (kSongVo?.artist_name ?? "")
            self.subTitleL.text = (kSongVo?.play_num ?? "0") + "人唱过"
            self.leftB.setImage(UIImage.init(named: "bt_k_k_normail"), for: UIControlState.normal)
            self.leftB.setImage(UIImage.init(named: "bt_k_k_press"), for: UIControlState.highlighted)
            self.leftB.isUserInteractionEnabled = true
        }
    }
    
    /// 监听高亮
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.contentView.addSubview(imageV)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(subTitleL)
        self.contentView.addSubview(leftB)
        
        imageV.snp.makeConstraints {[unowned self] (make) in
            make.left.top.bottom.equalTo(UIEdgeInsetsMake(5, itemLeftRight, 5, 0))
            make.height.equalTo(self.imageV.snp.width)
        }
        leftB.snp.makeConstraints {[unowned self] (make) in
            make.centerY.equalTo(self.imageV)
            make.right.equalTo(self.contentView.snp.right).offset(-itemLeftRight)
            make.size.equalTo(self.imageV.snp.size).multipliedBy(0.8)
        }
        titleL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.imageV.snp.top)
            make.height.equalTo(self.subTitleL.snp.height)
            make.left.equalTo(self.imageV.snp.right).offset(spacingX)
            make.right.equalTo(self.leftB.snp.left).offset(-spacingX)
        }
        subTitleL.snp.makeConstraints {[unowned self] (make) in
            make.bottom.equalTo(self.imageV.snp.bottom)
            make.top.equalTo(self.titleL.snp.bottom)
            make.left.right.equalTo(self.titleL)
        }
    }
    
    
    /// imageV
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.black
        object.font = UIFont.systemFont(ofSize: 13)
        return object
    }()
    
    /// 副标题
    fileprivate lazy var subTitleL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.gray
        object.font = UIFont.systemFont(ofSize: 12)
        return object
    }()
    
    /// leftButton
    fileprivate lazy var leftB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        return object
    }()

}
