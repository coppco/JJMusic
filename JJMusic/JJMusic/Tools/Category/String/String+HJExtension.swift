//
//  String+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 字符串的size
extension String {
    
    /// 计算字符串的size
    ///
    /// - parameter font: 字体大小
    /// - parameter size: 绘制的范围
    /// - model:        断句模式
    ///
    /// - returns: 返回字符串的size
    func size(font: CGFloat, size: CGSize, model: NSLineBreakMode = .byWordWrapping) -> CGSize {
        if 0 == self.characters.count || __CGSizeEqualToSize(size, CGSize.zero) {
            return CGSize.zero
        }
        var temp = font
        if font <= 0.0 {
            temp = 17.0
        }
        var attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: temp)] as [String: Any]
        if model != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = model
          attributes[NSParagraphStyleAttributeName] = paragraphStyle
        }
        return (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil).size
    }
    
    /// 计算字符串的高度
    ///
    /// - parameter font:  字符串字体大小
    /// - parameter width: 字符串的宽度
    ///
    /// - returns: 返回字符串的高度
    func height(font: CGFloat, width: CGFloat) -> CGFloat {
        if width <= 0.0 {
            return 0.0
        }
        return self.size(font: font, size: CGSize(width: width, height: CGFloat(MAXFLOAT))).height
    }
    
    
    
    /// 计算字符串的宽度
    ///
    /// - parameter font:   字体大小
    /// - parameter height: 字符串的高度
    ///
    /// - returns: 返回字符串的宽度
    func width(font: CGFloat) -> CGFloat {
        return self.size(font: font, size: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))).width
    }
}


// MARK: - 加密相关, 需要桥接<CommonCrypto/CommonHMAC.h>
enum CryptoAlgorithm {
    case md5, sha1, sha224, sha256, sha384, sha512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .md5:      result = kCCHmacAlgMD5
        case .sha1:     result = kCCHmacAlgSHA1
        case .sha224:   result = kCCHmacAlgSHA224
        case .sha256:   result = kCCHmacAlgSHA256
        case .sha384:   result = kCCHmacAlgSHA384
        case .sha512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .md5:      result = CC_MD5_DIGEST_LENGTH
        case .sha1:     result = CC_SHA1_DIGEST_LENGTH
        case .sha224:   result = CC_SHA224_DIGEST_LENGTH
        case .sha256:   result = CC_SHA256_DIGEST_LENGTH
        case .sha384:   result = CC_SHA384_DIGEST_LENGTH
        case .sha512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    /// MD5加密
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        return stringFromBytes(result, length: digestLen)
    }
    
    /// sha1加密
    var sha1: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        return stringFromBytes(result, length: digestLen)
    }
    
    
    /// sha256加密
    var sha256String: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(str!, strLen, result)
        return stringFromBytes(result, length: digestLen)
    }
    
    
    /// sha512加密
    var sha512String: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA512(str!, strLen, result)
        return stringFromBytes(result, length: digestLen)
    }
    
    fileprivate func stringFromBytes(_ bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String{
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", bytes[i])
        }
        bytes.deallocate(capacity: length)
        return String(format: hash as String)
    }
    
    
    /// 加盐加密
    ///
    /// - parameter algorithm: 加密类型
    /// - parameter key:       盐值key
    ///
    /// - returns: 返回加密后的字符串
    func hmac(_ algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result, length: digestLen)
        
        result.deallocate(capacity: digestLen)
        
        return digest
    }
    
    fileprivate func stringFromResult(_ result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}

// MARK: - 字符串处理
extension String {
    
    /// 判断字符串是否为nil或者空串
    ///
    /// - parameter string: 字符串
    ///
    /// - returns: 空串或者nil返回true
    static func isEmptyOrNil(string: String?) -> Bool {
        return string?.characters.count == 0 || string == nil
    }
    
    /// 从CharacterSet里面替换字符串
    ///
    /// - parameter specialString: 需要过滤的字符串
    /// - parameter replacement:  替换后的字符串, 默认是""
    ///
    /// - returns: 返回替换后的字符串
    func replaceStringUsingCharacterSet(specialString: String, replacement: String = "") -> String {
        return (self.components(separatedBy: CharacterSet(charactersIn: specialString)) as NSArray).componentsJoined(by: replacement)
    }
    
    /// 使用正则表达式替换字符串
    ///
    /// - parameter pattern:     正则表达式规则
    /// - parameter replacement: 替换后的字符串, 默认是""
    ///
    /// - returns: 返回过滤后的字符串
    func replaceStringUsingRegular(pattern: String, options: NSRegularExpression.Options, replacement: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            //withTemplate:  $1:保留匹配规则的开始 $2:保留匹配规则的结尾,其他字符串则替换掉.如匹配以{开始以?结尾的字符串, 决定是否保留{和?  如"$1abc"--->{abc
            let result = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: replacement)
            return result
        } catch {
            return self
        }
    }
    
    
    /// 使用正则表达式匹配字符串
    ///
    /// - parameter pattern: 正则表达式 如 "^([1-9]\\d*|0)?((\\.|,)[0-9]{0,2})?$" 保留两位有效数字的正则
    /// - parameter options: 正则表达式选项
    ///
    /// - returns: 返回匹配结果
    func matchesRegex(pattern: String, options: NSRegularExpression.Options) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
//            return regex.matches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.characters.count)).count > 0
            return regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.characters.count)) > 0
        } catch {
            return false
        }
    }
    
    
    /// 使用正则表达式列举匹配
    ///
    /// - parameter pattern: 正则表达式
    /// - parameter options: 正则表达式选项
    /// - parameter block:   闭包
    func enumerateMatches(pattern: String, options: NSRegularExpression.Options = [], using block: (NSTextCheckingResult?, NSRegularExpression.MatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Swift.Void) {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.characters.count), using: { (result, flags, pointer) in
                block(result, flags, pointer)
            })
        } catch {
        }
    }
}


// MARK: - Value
extension String {
    
    /// 小数值
    var decimalValue: Decimal? {
        return self.numberValue?.decimalValue
    }
    
    /// Double值  可能会出现数字不准确带很多小数点
    var doubleValue: Double? {
        return self.numberValue?.doubleValue
    }
    
    /// Bool值
    var boolValue: Bool? {
        return self.numberValue?.boolValue
    }
    
    /// Int值
    var intValue: Int? {
        return self.numberValue?.intValue
    }
    
    /// Float值  可能会出现数字不准确带很多小数点
    var floatValue: Float? {
        return self.numberValue?.floatValue
    }
    
    /// UInt值
    var uintValue: UInt? {
        return self.numberValue?.uintValue
    }
    
    /// Number值
    var numberValue: NSNumber? {
        return NSNumber.numberFromString(string: self)
    }
    
    /// Data值
    var dataValue: Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    /// NSRange范围
    var range: NSRange {
        return NSMakeRange(0, self.characters.count)
    }
    
    
    
}

