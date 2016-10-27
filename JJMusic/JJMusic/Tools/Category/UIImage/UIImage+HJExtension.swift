//
//  UIImage+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    /// 从颜色生成图片
    ///
    /// - parameter color: 颜色
    ///
    /// - returns: 返回可选图片
    class func imageFromColor(color: UIColor) -> UIImage? {
        return self.imageFromColorWithSize(color: color, size: CGSize(width: 1, height: 1))
    }
    
    /// 根据颜色和大小生成图片
    ///
    /// - parameter color: 颜色
    /// - parameter size:  大小
    ///
    /// - returns: 返回可选图片
    class func imageFromColorWithSize(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// 压缩图片
    ///
    /// - parameter size: 压缩后大小
    ///
    /// - returns: 返回新的图片
    func imageScaleToSize(size: CGSize) -> UIImage? {
        if let imageRef = self.cgImage {
            let originSize = CGSize(width: (imageRef.width), height: (imageRef.height)) //原始大小
            if originSize.equalTo(size) {
                return self
            }
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            UIGraphicsGetCurrentContext()!.interpolationQuality = CGInterpolationQuality.high
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return self
    }
    
    
    /// 等比例压缩图片
    ///
    /// - parameter ratio: 比例 0~1
    ///
    /// - returns: 返回新的图片
    func hj_scaleWithRatio(_ ratio: Double) -> UIImage? {
        if ratio >= 1 || ratio <= 0 {
            return self
        }
        if let imageRef = self.cgImage {
            let size = CGSize(width: ratio * Double(imageRef.width), height: ratio * Double(imageRef.height))
            return self.imageScaleToSize(size: size)
        }
        return self
    }
    
    
    /// 长图片截取上面一部分
    ///
    /// - parameter smallSize: 截取的大小
    ///
    /// - returns: 返回新的图片
    func hj_getSmallPictureForLongPicture(smallSize: CGSize) -> UIImage {
        guard let imageRef = self.cgImage else {
            return self
        }
        let originSize = CGSize(width: imageRef.width, height: imageRef.height) //原始大小
        if smallSize.equalTo(originSize) {
            return self
        }
        var size = smallSize
        if originSize.width != smallSize.width {
            size = CGSize(width: originSize.width, height: originSize.width * smallSize.height / smallSize.width)
        }
        let smallBounds = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let newRef = imageRef.cropping(to: smallBounds)
        UIGraphicsBeginImageContext(smallBounds.size)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(newRef!, in: CGRect(origin: CGPoint(x: 0, y: 0), size: smallSize)    )
        let smallImage = UIImage(cgImage: newRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
}
