//
//  HomeViewController.swift
//  JJMusic
//
//  Created by coco on 16/10/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navigationV)
        navigationV.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self.view)
        }
        
        self.view.addSubview(myMusicV.view)
        self.addChildViewController(myMusicV)
        myMusicV.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.view.bringSubview(toFront: navigationV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Private
    
    /**导航栏*/
    private lazy var navigationV: HomeNavigationView = {
        return HomeNavigationView.shared
    }()

    /**我的*/
    private lazy var myMusicV: My_HomeController = {
        let object = My_HomeController()
        return object
    }()

    
}
