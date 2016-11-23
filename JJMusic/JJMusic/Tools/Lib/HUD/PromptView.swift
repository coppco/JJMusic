//
//  PromptView.swift
//  PromptView
//
//  Created by coco on 16/11/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//  在window上面显示提示view, 不影响操作

import UIKit


/// 提示view
class PromptView: UIView {
    fileprivate static let shared: PromptView = {
        let object = PromptView()
        object.addSubview(object.imageV)
        object.addSubview(object.titleL)
        object.backgroundColor = UIColor(red: 0x17 / 255.0, green: 0x17 / 255.0, blue: 0x17 / 255.0, alpha: 0.8)
        object.layer.cornerRadius = 4
        object.layer.masksToBounds = true
        return object
    }()
    /// 显示提示框, 但是可以进行UI操作
    ///
    /// - parameter imageName: 图片
    /// - parameter message:   消息
    class func show(imageName: String? = nil, message: String) {
        if PromptView.isShow == true {
            return
        }
        let object = self.shared
        object.titleL.text = message
        object.titleL.width = kMainScreenWidth - 60  //最大宽
        object.titleL.sizeToFit()
        if let icon = imageName {
            object.imageV.image = UIImage(named: icon)
        } else {
            object.imageV.image = nil
        }
        object.imageV.width = kMainScreenWidth - 60  //最大宽
        object.imageV.sizeToFit()
        
        object.width = max(object.imageV.width, object.titleL.width) + 40
        object.height = object.imageV.height + object.titleL.height + 30
        
        object.x = (kMainScreenWidth - object.width) / 2
        object.y = (kMainScreenHeight - object.height) / 2
        
        object.titleL.centerX = object.width / 2
        object.imageV.centerX = object.width / 2
        if object.imageV.size.equalTo(CGSize.zero) {
            object.titleL.y = 15
        } else {
            object.imageV.y = 10
            object.titleL.y = object.imageV.maxY + 10
        }
        UIApplication.shared.keyWindow!.addSubview(object)
        object.alpha = 0
        object.isHidden = false
        PromptView.isShow = true
        
        UIView.animate(withDuration: 0.25, animations: {
            object.alpha = 1
            }) { (flag) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    UIView.animate(withDuration: 0.25, animations: {
                        object.alpha = 0
                        }, completion: { (flag) in
                            PromptView.isShow = false
                            object.isHidden = true
                            object.removeFromSuperview()
                    })
                })
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    private convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private init(a: Int) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// imageV
    fileprivate lazy var imageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    /// titleL
    fileprivate lazy var titleL: UILabel = {
        let object = UILabel()
        object.font = UIFont.boldSystemFont(ofSize: 13)
        object.textAlignment = .center
        object.numberOfLines = 0
        object.textColor = UIColor.white
        return object
    }()
    
    /// isShow 是否已经显示
    fileprivate static var isShow = false
}
