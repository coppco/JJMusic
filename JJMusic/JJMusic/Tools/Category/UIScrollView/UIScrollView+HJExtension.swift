//
//  UIScrollView+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    /// 滚到顶部
    ///
    /// - parameter animated: 动画
    func scrollToTop(animated: Bool = true) {
        var point = self.contentOffset
        point.y = 0 - self.contentInset.top
        self.setContentOffset(point, animated: animated)
    }
    
    /// 滚到底部
    ///
    /// - parameter animated: 动画
    func scrollToBottom(animated: Bool = true) {
        var point = self.contentOffset
        point.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        self.setContentOffset(point, animated: animated)
    }
    
    /// 滚到最左边
    ///
    /// - parameter animated: 动画
    func scrollToLeft(animated: Bool = true) {
        var point = self.contentOffset
        point.x = 0 - self.contentInset.left
        self.setContentOffset(point, animated: animated)
    }
    
    /// 滚动最右边
    ///
    /// - parameter animated: 动画
    func scrollToRight(animated: Bool = true) {
        var point = self.contentOffset
        point.x =  self.contentSize.width - self.bounds.size.width + self.contentInset.right
        self.setContentOffset(point, animated: animated)
    }
}
