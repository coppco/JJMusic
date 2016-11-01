//
//  UIPageControl+HJExtension.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

extension UIPageControl {
    
    /// 当前指示器图标
    var currentPageIndicatorImage: UIImage? {
        set {
            self.setValue(newValue, forKeyPath: "_currentPageImage")
        }
        get {
            return self.value(forKeyPath: "_currentPageImage") as? UIImage
        }
    }
    
    /// 不活动的指示器图标
    var pageIndicatorImage: UIImage? {
        set {
            self.setValue(newValue, forKeyPath: "_pageImage")
        }
        get {
            return self.value(forKeyPath: "_pageImage") as? UIImage
        }
    }

}
