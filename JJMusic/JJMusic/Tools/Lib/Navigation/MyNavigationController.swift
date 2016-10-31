//
//  MyNavigationController.swift
//  EasyTravel
//
//  Created by coco on 16/10/20.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override class func initialize() {
        self.configNavigationBar()
    }
    
    private class func configNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.colorWithRGB(r: 248, g: 73, b: 76)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: 解决自定义导航栏控制器右滑失效问题
        self.interactivePopGestureRecognizer?.delegate = self
        
        #if DEBUG
            addPFS()
        #endif
    }
    
    fileprivate func addPFS() {
        let label = V2FPSLabel(frame: CGRect(x: 15, y: kMainScreenHeight - 80, width: 0, height: 0))
        self.view.addSubview(label)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(title: nil, titleNormalColor: nil, titleHighlightedColor: nil, normalImage: "navigationButtonReturn", highlightedImage: "navigationButtonReturn", target: self, action: #selector(MyNavigationController.back), edg: UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back() {
        self.popViewController(animated: true)
    }
    
    /// 手势识别器对象会调用代理这个方法, 决定手势是否有效
    ///
    /// - parameter gestureRecognizer:
    ///
    /// - returns: true-----> 有效   false------->无效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
    /// 状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
