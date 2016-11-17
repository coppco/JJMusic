//
//  MBProgressHUD+Extension.swift
//  Tools
//
//  Created by coco on 21/3/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

// MARK: - 显示提示信息
extension MBProgressHUD {
    @nonobjc
    /// 默认延迟时间
    fileprivate static let defaultDelay: TimeInterval = 0.8
    /// 显示错误正确等提示信息的单例
    @nonobjc
    private static let sharedMessaage: MBProgressHUD = {
        let object = MBProgressHUD(frame: UIApplication.shared.keyWindow!.bounds)
        object.contentColor = UIColor.white  //文字菊花等颜色
        object.bezelView.color = UIColor.black  //中间背景颜色
        object.label.font = UIFont.boldSystemFont(ofSize: 12)
        object.animationType = .fade
        object.removeFromSuperViewOnHide = true  //隐藏时从父视图移除
        return object
    }()

     private class func show(message: String, icon: String?, in view: UIView?, delay: TimeInterval) {
        let object = MBProgressHUD.sharedMessaage
        if object.superview != nil {
            object.removeFromSuperview()
        }
        let inView = view != nil ? view! : UIApplication.shared.keyWindow!
        //隐藏view上面的菊花转,提示信息等
        MBProgressHUD.hide(for: inView, animated: false)
        object.frame = inView.bounds
        inView.addSubview(object)
        inView.bringSubview(toFront: object)
        
        if let imageName = icon {
            object.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/\(imageName)"))
            object.mode = .customView
        } else {
            object.customView = nil
            object.mode = .text
        }
        object.label.text = message
        
        object.show(animated: true)
        object.hide(animated: true, afterDelay: delay <= 0 ? defaultDelay : delay)
    }
    
    /// 显示成功提示消息, 默认显示 √ 图片
    ///
    /// - parameter message: 提示文字
    /// - parameter view:    如果为nil, 则显示在keyWindow上面
    /// - parameter delay:   延迟消失
    class func show_Success(message: String, in view: UIView? = nil, delay: TimeInterval = defaultDelay) {
        self.show(message: message, icon: "success.png", in: view, delay: delay)
    }
    
    /// 显示成功提示消息, 默认显示 × 图片
    ///
    /// - parameter message: 提示文字
    /// - parameter view:    如果为nil, 则显示在keyWindow上面
    /// - parameter delay:   延迟消失
    class func show_Error(message: String, in view: UIView? = nil, delay: TimeInterval = defaultDelay) {
        self.show(message: message, icon: "error.png", in: view, delay: delay)
    }

    /// 显示成功提示消息, 默认显示 × 图片
    ///
    /// - parameter message: 提示文字
    /// - parameter view:    如果为nil, 则显示在keyWindow上面
    /// - parameter delay:   延迟消失
    class func show_Warning(message: String, in view: UIView? = nil, delay: TimeInterval = defaultDelay) {
        self.show(message: message, icon: "warning.png", in: view, delay: delay)
    }

    
    /// 显示提示消息
    ///
    /// - parameter message: 提示文字
    /// - parameter view:    如果为nil, 则显示在keyWindow上面
    /// - parameter delay:   延迟消失
    class func show_Message(message: String, in view: UIView?, delay: TimeInterval = defaultDelay) {
        self.show(message: message, icon: nil, in: view, delay: delay)
    }
}

// MARK: - 显示菊花转
extension MBProgressHUD {
    class func show_HUD(message: String, in view: UIView?) {
        let inView = view != nil ? view! : UIApplication.shared.keyWindow!
        //隐藏view上面的菊花转,提示信息等
        MBProgressHUD.hide(for: inView, animated: false)
        let object = MBProgressHUD.showAdded(to: inView, animated: true)
        object.contentColor = UIColor.white  //文字菊花等颜色
        object.bezelView.color = UIColor.black  //中间背景颜色
        object.label.font = UIFont.boldSystemFont(ofSize: 12)
        object.animationType = .fade
        object.removeFromSuperViewOnHide = true  //隐藏时从父视图移除
        object.label.text = message
        object.mode = .indeterminate  //
    }
}

extension UIViewController {
    @nonobjc
    static let loadingTitle: String = "玩命加载中…"
    func show_LoadingHud(message: String = UIViewController.loadingTitle) {
        MBProgressHUD.show_HUD(message: message, in: self.view)
    }
    
    func show_Message(message: String, delay: TimeInterval = MBProgressHUD.defaultDelay) {
        MBProgressHUD.show_Message(message: message, in: self.view, delay: delay)
    }
    
    func show_Success(message: String, delay: TimeInterval = MBProgressHUD.defaultDelay) {
        MBProgressHUD.show_Success(message: message, in: self.view, delay: delay)
    }
    func show_Error(message: String, delay: TimeInterval = MBProgressHUD.defaultDelay) {
        MBProgressHUD.show_Error(message: message, in: self.view, delay: delay)
    }
    func show_Warning(message: String, delay: TimeInterval = MBProgressHUD.defaultDelay) {
        MBProgressHUD.show_Warning(message: message, in: self.view, delay: delay)
    }

    
    /// 隐藏提示和菊花转
    func hideAllHud() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
