//
//  LocalMusicController.swift
//  JJMusic
//
//  Created by coco on 16/11/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class LocalMusicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
          let a =  UIBarButtonItem(image: UIImage(named: "bt_home_login_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(LocalMusicController.show(sender:)))
        
        let b = UIBarButtonItem(image: UIImage(named: "ic_recommend_back_normal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(LocalMusicController.showNetworkStatus(sender:)))

        self.navigationItem.rightBarButtonItems = [a,b]
        
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage.init(named: "bt_home_login_normal"), for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        button.addTarget(self, action: #selector(LocalMusicController.pri), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }

    @objc private func pri() {
        print("sdfdsfa")
    }
    @objc private func showNetworkStatus(sender: UIBarButtonItem) {
       
    }
    @objc private func show(sender: UIBarButtonItem) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
