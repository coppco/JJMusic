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

        HTTPRequest.requestJSON(type: .post, URLString: "http://tingapi.ting.baidu.com/v1/restserver/ting", parameters: ["method": "baidu.ting.ugcfriend.getList", "channel": "0e939898c11ad3b9b52e6fb5d50e009ad930a65b", "cuid": "appstore", "from": "ios", "version": "5.9.1",  "param": "qhnOoDAY5EdRmwT3K%2Bn%2FeyWASesMIgwzD0l5NOgD3sk9BErsaItY5lobilvkHhLqYYQPb5kdp4XP5%2BlkXjaPeu2lrNxUIzzRNQsamjzK8w%2BuLLmpxaTWg5qUqYrYfRMu","sign": "514bf7093dbe7fe28daf1738276af799", "timestamp": Date.currentTenTimeSamp()], success: { (object) in
            HHLog(object)
            }) { (error) in
                HHLog(error)
        }
        request("http://tingapi.ting.baidu.com/v1/restserver/ting", method: .post, parameters: ["method": "baidu.ting.ugcfriend.getList", "channel": "0e939898c11ad3b9b52e6fb5d50e009ad930a65b", "cuid": "appstore", "from": "ios", "version": "5.9.1",  "param": "lEgndGwDtG3XJxKXTbG4YzJglwWYScGupwI%2Fu03YoQ4l3RumqkjWjfIk6OWI%2BwII%2BLP08Zi1ObffX5xR1N4KljQ1bl0CoEsf7cC55z%2Fy8w6W4lVq9m%2BKn0%2F83HiQF%2Bvv","sign": "7ac6d985e7be31647cbd5ded7002538f", "timestamp": Date.currentTenTimeSamp()], encoding: JSONEncoding.default, headers: nil).responseData(queue: nil) { (data) in
            print(data)
        }
        
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
