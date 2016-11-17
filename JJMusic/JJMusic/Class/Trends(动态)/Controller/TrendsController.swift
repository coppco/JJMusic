//
//  TrendsController.swift
//  JJMusic
//
//  Created by coco on 16/11/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class TrendsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(backgroundImageV)
        backgroundImageV.snp.makeConstraints {[unowned self] (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(64)
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

}
