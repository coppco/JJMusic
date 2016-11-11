//
//  TopBottomButton.swift
//  JJMusic
//
//  Created by coco on 16/11/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class TopBottomButton: UIButton {
    
    internal var radio: CGFloat = 1.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    internal var labelWidth: CGFloat = 1.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    init () {
        super.init(frame: CGRect.zero)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 0  //间隔
        let width = self.frame.size.width
        let height = self.frame.size.height
        let minValue = min(height * 0.8, width) * radio - padding
        self.imageView?.frame = CGRect(x: (width - minValue) / 2, y: 0, width: minValue, height: minValue)
        self.imageView?.layer.cornerRadius = minValue / 2
        self.titleLabel?.frame = CGRect(x: width * (1 - labelWidth) / 2, y: 0.8 * height + padding, width: width * labelWidth, height: height * 0.2 - padding)
    }
    deinit {
        print(self.classForCoder, "释放了")
    }
}
