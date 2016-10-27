//
//  UITextField+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /// 占位文字颜色
    var placeHolderColor: UIColor {
        get {
            return self.value(forKeyPath: "_placeholderLabel.textColor") as! UIColor
        }
        set {
            guard let _ = self.placeholder else {  //self.placeholder不为空的时候,直接跳过 else里面的方法,  为空的时候才会进来
                self.placeholder = " "
                self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
                self.placeholder = nil
                return
            }
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    /// 选择所有文字
    func selectAllText() {
        let range = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
        self.selectedTextRange = range
    }
    
    /// 设置选中文字
    ///
    /// - parameter range: 范围
    func setSelectedRange(range: NSRange) {
        let startPosition = self.position(from: self.beginningOfDocument, offset: range.location)
        let endPosition = self.position(from: self.beginningOfDocument, offset: NSMaxRange(range))
        if let start = startPosition, let end = endPosition {
            self.selectedTextRange = self.textRange(from: start, to: end)
        }
    }
}


