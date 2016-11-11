//
//  UIView+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Property属性
extension UIView {
    /// x值
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /// y值
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    /// 宽
    var width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// 高
    var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    /// 大小
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    /// 坐标点
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    /// 中心点x
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    /// 中心点y
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    
    /// x轴中点
    var midX: CGFloat {
        return self.frame.origin.x + self.frame.size.width / 2
    }
    
    /// 最大x值
    var maxX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    
    /// y轴中点
    var midY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height / 2
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    
    /// 最大y值
    var maxY: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    /// 当前view所在的控制器
    var viewController: UIViewController? {
        get {
            var view: UIView? = self
            while view != nil {
                let responder = view?.next
                if responder?.isKind(of: UIViewController.classForCoder()) == true {
                    return responder as? UIViewController
                }
                view = view?.superview
            }
            return nil
        }
    }
    
}


// MARK: - Function函数
extension UIView {
    
    /// 视图快照
    ///
    /// - returns: 返回可选图片
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    /// 设置视图layer的半径, 边框颜色和宽度
    ///
    /// - parameter cornerRadius: 半径
    /// - parameter borderColor:  边框颜色
    /// - parameter borderWidth:  边框宽度
    func setLayerCornerRadius(cornerRadius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil) {
        self.layer.cornerRadius = cornerRadius
        if let color = borderColor {
            self.layer.borderColor = color.cgColor
        }
        if let width = borderWidth {
            self.layer.borderWidth = width
        }
        self.layer.masksToBounds = true
    }
    
    /// 设置视图layer的阴影
    ///
    /// - parameter color:  阴影颜色
    /// - parameter radius: 阴影半径
    /// - parameter offset: 阴影偏移量
    func setLayerShadow(color: UIColor, radius: CGFloat?, offset: CGSize?) {
        self.layer.shadowColor = color.cgColor
        if let shadowRadius = radius {
            self.layer.shadowRadius = shadowRadius
        }
        if let shadowOffset = offset {
            self.layer.shadowOffset = shadowOffset
        }
        self.layer.shadowOpacity = 1
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    /**只有设置了autoLayout的才可以*/
    func hj_autoLayoutSize(width: CGFloat) -> CGSize {
            let widthFenceConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: width)
            self.addConstraint(widthFenceConstraint)
            let size = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.removeConstraint(widthFenceConstraint)
            return size
    }
}

// MARK: - Animation动画
extension UIView {
    enum AnimationType {
        case big, small
    }
    
    /// 摇动
    ///
    /// - parameter duration: 动画持续时间
    func animation_shaked(duration: TimeInterval = 0.8) {
        let layer = self.layer
        let point = layer.position
        let left = CGPoint(x: point.x - 10, y: point.y)
        let right = CGPoint(x: point.x + 10, y: point.y)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = left
        animation.toValue = right
        animation.autoreverses = true //平滑结束
        animation.duration = duration
        animation.repeatCount = 3
        animation.isRemovedOnCompletion = true
        layer.add(animation, forKey: nil)
    }
    
    /// 放大或者缩小一个视图
    ///
    /// - parameter animationType: 放大或者缩小
    /// - parameter isRotate:      是否旋转
    func animation_zoomed(animationType: AnimationType, isRotate: Bool = false, duration: TimeInterval = 0.5) {
        if isRotate {
            self.transform = self.transform.rotated(by: CGFloat(M_1_PI))
        }
        //缩放
        let scale = CABasicAnimation(keyPath: "transform.scale")
        if animationType == .big {
            scale.fromValue = NSNumber(value: 1.0)
            scale.toValue = NSNumber(value: 2.0)
        } else if animationType == .small {
            scale.fromValue = NSNumber(value: 1.0)
            scale.toValue = NSNumber(value: 0.0)
        }
        //透明度
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = NSNumber(value: 1.0)
        opacity.toValue = NSNumber(value: 0.0)
        //组动画
        let group = CAAnimationGroup()
        group.animations = [scale, opacity]
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    }
}
