//
//  UIBarButtonItem+HJExtension.swift
//  EasyTravel
//
//  Created by coco on 16/10/20.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func barButtonItem(title: String?, titleNormalColor: UIColor?, titleHighlightedColor: UIColor?, normalImage: String?, highlightedImage: String?, target: AnyObject?, action: Selector, edg:UIEdgeInsets = UIEdgeInsets.zero) -> UIBarButtonItem {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle(title, for: UIControlState.normal)
        button.setTitle(title, for: UIControlState.highlighted)
        
        button.setTitleColor(titleNormalColor, for: UIControlState.normal)
        button.setTitleColor(titleHighlightedColor, for: UIControlState.highlighted)

        if let normal_image = normalImage {
            button.setImage(UIImage(named: normal_image), for: UIControlState.normal)
        }
        if let highlight_image = highlightedImage {
             button.setImage(UIImage(named: highlight_image), for: UIControlState.highlighted)
        }
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        button.sizeToFit()
        button.contentEdgeInsets = edg
        return UIBarButtonItem(customView: button)
    }
}

