//
//  MyHomeTCell.swift
//  JJMusic
//
//  Created by coco on 16/10/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyHomeTCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageV.snp.removeConstraints()
        self.titleL.snp.removeConstraints()
        self.totalL.snp.removeConstraints()
        self.arrowImageV.snp.removeConstraints()
        self.bottomL.snp.removeConstraints()
    }
    
    var cellData: My_Home_Cell_Data? {
        didSet {
            self.titleL.text = cellData?.title
            self.totalL.text = cellData?.subTitle
            if let icon = cellData?.iconName {
                self.iconImageV.image = UIImage(named: icon)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            }
            if let arrow = cellData?.rightIcomName {
                self.arrowImageV.image = UIImage(named: arrow)
            }
            iconImageV.snp.makeConstraints {[unowned self] (make) in
                make.top.equalTo(self.contentView.snp.top).offset(10)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.height.equalTo(48)
            }
            
            titleL.snp.makeConstraints {[unowned self] (make) in
                make.top.equalTo(self.iconImageV)
                make.left.height.width.equalTo(self.totalL)
                make.left.equalTo(self.iconImageV.snp.right).offset(20)
                make.right.equalTo(self.arrowImageV.snp.left).offset(-10)
            }
            totalL.snp.makeConstraints {[unowned self] (make) in
                make.top.equalTo(self.titleL.snp.bottom)
                make.bottom.equalTo(self.iconImageV.snp.bottom)
            }
            
            arrowImageV.snp.makeConstraints {[unowned self] (make) in
                make.centerY.equalTo(self.iconImageV)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
                make.width.equalTo(40)
                make.height.equalTo(self.iconImageV)
            }
            
            bottomL.snp.makeConstraints {[unowned self] (make) in
                make.left.right.bottom.equalTo(self.contentView)
                make.height.equalTo(0.3)
            }

        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
    
    private func configUI() {
        self.contentView.addSubview(iconImageV)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(totalL)
        self.contentView.addSubview(arrowImageV)
        self.contentView.addSubview(bottomL)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.totalL.textColor = normalTextColor
            if let arrow = self.cellData?.rightHightIconName {
                self.arrowImageV.image = UIImage(named: arrow)
            }
            if let icon = self.cellData?.iconHightName {
                self.iconImageV.image = UIImage(named: icon)
            }
            self.backgroundColor = UIColor.colorWithRGB(r: 234, g: 234, b: 234)
        } else {
            self.totalL.textColor = lightTextColor
            if let arrow = self.cellData?.rightIcomName {
                self.arrowImageV.image = UIImage(named: arrow)
            }
            if let icon = self.cellData?.iconName {
                self.iconImageV.image = UIImage(named: icon)
            }
            self.backgroundColor = UIColor.white
        }
    }
    
    /**图标*/
    private lazy var iconImageV: UIImageView = {
        let object = UIImageView(image: #imageLiteral(resourceName: "ic_mymusic_guss"))
        return object
    }()
    
    /**本地音乐*/
    private lazy var titleL: UILabel = {
        let object = UILabel()
        object.textColor = normalTextColor
        object.font = UIFont.systemFont(ofSize: 13)
        object.text = "本地音乐"
        return object
    }()
    
    /**歌曲数量*/
    private lazy var totalL: UILabel = {
        let object = UILabel()
        object.textColor = lightTextColor
        object.font = UIFont.systemFont(ofSize: 12)
        object.text = "共249首歌曲"
        return object
    }()

    /**arrow*/
    private lazy var arrowImageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "icon_home_guess_play_normal"))
        object.contentMode = .center
        return object
    }()
    
    private lazy var bottomL: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.colorWithRGB(r: 239, g: 239, b: 239)
        return object
    }()
    
    //渲染颜色变化的时候, 设置图片的背景颜色
    override func tintColorDidChange() {
        self.iconImageV.backgroundColor = self.tintColor
    }
}
