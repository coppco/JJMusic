//
//  MusicCCell.swift
//  JJMusic
//
//  Created by coco on 16/11/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//  歌单、新碟等Cell

import UIKit

class MusicCCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageV.image = nil
        self.titleL.text = ""
        self.subTitleL.text = nil
        self.subTitleL.isHidden = true
        self.maskV.isHidden = true
    }
    
    
    
    //歌单推荐
    var div: DiyVo? {
        didSet {
            if let icon = div?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = div?.title
            self.subTitleL.isHidden = true
        }
    }
    
    //新碟上架
    var album: AlbumVo? {
        didSet {
            if let icon = album?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = album?.title
            self.subTitleL.text = album?.author
        }
    }
    // 热销专辑
    var mix_22: Mix_22Vo? {
        didSet {
            if let icon = mix_22?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = mix_22?.title
            self.subTitleL.text = mix_22?.author
        }
    }
    /// 原创音乐
    var mix_9: Mix_9Vo? {
        didSet {
            if let icon = mix_9?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = mix_9?.title
            self.subTitleL.text = mix_9?.author
        }
    }
    /// 最热MV推荐
    var mix_5: Mix_5Vo? {
        didSet {
            if let icon = mix_5?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = mix_5?.title
            self.subTitleL.text = mix_5?.author
        }
    }
    /// 乐播节目
    var radio: RadioVo? {
        didSet {
            if let icon = radio?.pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = radio?.title
            self.subTitleL.isHidden = true
        }
    }

    /// 歌单里面的Cell
    var diyInfo: DiyInfoVo? {
        didSet {
            if let icon = diyInfo?.list_pic {
                self.imageV.kf.setImage(with: URL.init(string: icon))
            }
            self.titleL.text = diyInfo?.title
            self.subTitleL.isHidden = false
            self.subTitleL.text = (diyInfo?.username == nil || diyInfo?.username?.characters.count == 0) ? "" : "By" + (diyInfo?.username)!
        }
    }
    
    /// 监听高亮
    override var isHighlighted: Bool {
        didSet {
            self.maskV.isHidden = !isHighlighted
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
        self.contentView.addSubview(playB)
        self.contentView.addSubview(maskV)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(subTitleL)
        
        imageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(self.contentView.snp.width)
        }
        playB.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(imageV)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        maskV.snp.makeConstraints { (make) in
            make.edges.equalTo(imageV)
        }
        titleL.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(imageV.snp.bottom).offset(spacingY)
        }
        subTitleL.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleL)
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
    
    /// mask
    fileprivate lazy var maskV: UIView = {
        let object = UIView()
        object.isHidden = true
        object.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return object
    }()


    /// 播放按钮
    fileprivate lazy var playB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        return object
    }()
    
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.text = "咱们相爱吧 电视原声带"
        object.textColor = UIColor.black
        object.font = UIFont.systemFont(ofSize: 13)
        object.numberOfLines = 2
        return object
    }()
    
    /// 副标题
    fileprivate lazy var subTitleL: UILabel = {
        let object = UILabel()
        object.text = "刘惜君/明道"
        object.textColor = UIColor.gray
        object.font = UIFont.systemFont(ofSize: 12)
        return object
    }()

}
