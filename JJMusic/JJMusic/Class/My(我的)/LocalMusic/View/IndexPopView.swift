//
//  IndexPopView.swift
//  JJMusic
//
//  Created by coco on 16/11/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
class IndexPopView: UIView {
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    private init() {
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        configUI()
    }
    
    private func configUI() {
        self.addSubview(self.titelL)
    }
    
    fileprivate static let shared: IndexPopView = {
        let object = IndexPopView(frame: CGRect.zero)
        return object
    }()
    
    class func show(title: String, in view: UIView) {
        if self.isShow == true {
            self.cancelPreviousPerformRequests(withTarget: self, selector: #selector(IndexPopView.hide), object: nil)
        }
        self.shared.titelL.text = title
        self.shared.titelL.width = kMainScreenWidth - 60  //最大宽
        self.shared.titelL.sizeToFit()
        if self.shared.titelL.size.width < 40 {
            self.shared.titelL.size.width = 40
        }
        self.shared.size = CGSize(width: self.shared.titelL.size.width + 30, height: self.shared.titelL.size.height + 30)
        self.shared.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.shared.titelL.center = CGPoint(x: self.shared.size.width / 2, y: self.shared.size.height / 2)
        if self.shared.superview != view {
            self.shared.reloadInputViews()
            view.addSubview(self.shared)
        }
        self.shared.alpha = 1
        self.isShow = true
        self.perform(#selector(IndexPopView.hide), with: nil, afterDelay: 1)
        
    }
    
    class func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.shared.alpha = 0
        }) { (flag) in
            if flag {
                self.isShow = false
                self.shared.removeFromSuperview()
            }
        }
    }
    
    /// Swift3.0开始,以前的方法变为变量了
    override class var layerClass: Swift.AnyClass {
        return CAShapeLayer.self
    }
    
    private var titelL: UILabel = {
        let object = UILabel()
        object.textColor = UIColor.white
        object.textAlignment = .center
        object.font = UIFont.boldSystemFont(ofSize: 18)
        return object
    }()
    
    private static var isShow: Bool = false
    
    override func tintColorDidChange() {
        (self.layer as! CAShapeLayer).fillColor = self.tintColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (self.layer as! CAShapeLayer).path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: self.width / 2, height: self.height / 2)).cgPath
    }
}
