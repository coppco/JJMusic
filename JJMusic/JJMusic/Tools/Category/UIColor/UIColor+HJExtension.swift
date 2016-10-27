//
//  UIColor+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    /// hex字符串转Cololr
    ///
    /// - parameter hex: hex字符串,支持#、0x和0X开头的3、4、6、8位字符串如: 0x668899FF
    ///
    /// - returns: 返回一个颜色, 有错误返回一个ClearColor
    class func colorWithHexString(hex: String) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if self.hexStringToRGBAValue(hex: hex, r: &red, g: &green, b: &blue, a: &alpha) {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return UIColor.clear
    }
    
    /// RGB值(6位)转Color
    ///
    /// - parameter rgbValue: rgbValue如0x55ffaa
    ///
    /// - returns: 返回UIColor对象
    class func colorWithRGBValue(rgbValue: Int) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0xFF) / 255.0, alpha: 1)
    }
    
    /// RGBA值(8位)转Color
    ///
    /// - parameter rgbaValue: rgba值如:0x3377ffff
    ///
    /// - returns: 返回UIColor对象
//    class func colorWithRGBAValue(rgbaValue: Int) -> UIColor {
//        return UIColor(red: CGFloat((rgbaValue & 0xFF000000) >> 24) / 255.0, green: CGFloat((rgbaValue & 0xFF0000) >> 16) / 255.0, blue: CGFloat((rgbaValue & 0xFF00) >> 8) / 255.0, alpha: CGFloat(rgbaValue & 0xFF) / 255.0)
//    }
    
    
    /// 随机颜色
    ///
    /// - returns: 返回UIColor对象
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r: r, g: g, b: b)
    }
    
    /// 通过R、G、B值来初始化UIColor
    ///
    /// - parameter r: 0~255值
    /// - parameter g: 0~255值
    /// - parameter b: 0~255值
    ///
    /// - returns: 返回UIColor对象
    class func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    /// 通过R、G、B、A值来初始化UIColor
    ///
    /// - parameter r: 0~255值
    /// - parameter g: 0~255值
    /// - parameter b: 0~255值
    /// - parameter a: 0~255值
    ///
    /// - returns: 返回UIColor对象
    class func colorWithRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)
    }
    
    fileprivate class func hexStringToRGBAValue(hex: String, r: inout CGFloat, g: inout CGFloat, b: inout CGFloat, a: inout CGFloat) -> Bool {
        var temp = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) //去掉首尾空格等
        if temp.hasPrefix("#") {
            temp = temp.substring(from: temp.index(temp.startIndex, offsetBy: 1))
        } else if temp.hasPrefix("0x") || temp.hasPrefix("0X") {
            temp = temp.substring(from: temp.index(temp.startIndex, offsetBy: 2))
        }
        
        let count = temp.characters.count
        //   RGB              RGBA             RRGGBB       RRGGBBAA
        if count != 3 && count != 4 && count != 6 && count != 8 {
            print("hex\(temp) count should must be 3、4、6 or 8 ")
            return false
        }

        let scanner = Scanner(string: temp)
        var result: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&result) {
            if count == 3 {
                r = CGFloat((result & 0xF00) >> 8) / 15.0
                g = CGFloat((result & 0x0F0) >> 4) / 15.0
                b = CGFloat(result & 0x00F) / 15.0
                a = 1
            } else if count == 4 {
                r = CGFloat((result & 0xF000) >> 12) / 15.0
                g = CGFloat((result & 0x0F00) >> 8) / 15.0
                b = CGFloat((result & 0x00F0) >> 4) / 15.0
                a = CGFloat(result & 0x000F) / 15.0
            } else if count == 6 {
                r = CGFloat((result & 0xFF0000) >> 16) / 255.0
                g = CGFloat((result & 0x00FF00) >> 8) / 255.0
                b = CGFloat(result & 0x0000FF) / 255.0
                a = 1
            } else if count == 8 {
                r = CGFloat((result & 0xFF000000) >> 24) / 255.0
                g = CGFloat((result & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((result & 0x0000FF00) >> 8) / 255.0
                a = CGFloat(result & 0x000000FF) / 255.0
            }
            return true
        } else {
            print("scanner hex:\(hex) error ,can't conversion it to RGBA!")
            return false
        }
        /*
        if count < 5 {
            r = hexStringToUInt64(hex: temp.substring(with: temp.startIndex..<temp.index(temp.startIndex, offsetBy: 1)))
            g = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 1)..<temp.index(temp.startIndex, offsetBy: 2)))
            b = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 2)..<temp.index(temp.startIndex, offsetBy: 3)))
            if count == 4 {
                a = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 3)..<temp.index(temp.startIndex, offsetBy: 4)))
            } else {
                a = 1
            }
        } else {
            r = hexStringToUInt64(hex: temp.substring(with: temp.startIndex..<temp.index(temp.startIndex, offsetBy: 2)))
            g = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 2)..<temp.index(temp.startIndex, offsetBy: 4)))
            b = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 4)..<temp.index(temp.startIndex, offsetBy: 6)))
            if count == 8 {
                a = hexStringToUInt64(hex: temp.substring(with: temp.index(temp.startIndex, offsetBy: 6)..<temp.index(temp.startIndex, offsetBy: 8)))
            } else {
                a = 1
            }
        }
                 return true
        */

    }
    
    fileprivate class func hexStringToUInt64(hex: String) -> CGFloat {
//        var result: Int = 0
//        let temp = withVaList([hex]) { (pointer) -> Int32 in
//            return vsscanf(hex, "0X", pointer)
//        }
//        var temp = vsscanf(hex, "0X", getVaList([result]))
//        return CGFloat(result) / 255.0
        var result: CUnsignedLongLong = 0
        let scaner = Scanner(string: hex)
        let _ = scaner.scanHexInt64(&result)
        return CGFloat(result) / 255.0
    }
    
}
