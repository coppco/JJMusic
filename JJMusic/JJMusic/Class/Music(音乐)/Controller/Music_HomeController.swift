//
//  Music_HomeController.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class Music_HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        self.view.addSubview(backgroundImageV)
        self.view.addSubview(topView)
        
        backgroundImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(64)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.backgroundImageV.snp.bottom)
            make.left.right.equalTo(self.backgroundImageV)
            make.height.equalTo(44)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**背景图片*/
    fileprivate lazy var backgroundImageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "night.gif")?.hj_getSmallPictureForLongPicture(smallSize: CGSize(width: kMainScreenWidth, height: 64)))
        return object
    }()

    /**顶部标题栏*/
    private lazy var topView: TopTitleView = {
        let object = TopTitleView(titleArray: ["推荐", "歌单", "榜单", "K歌"], didClickedTitle: { (title, index) in
            
        })
        return object
    }()

}
