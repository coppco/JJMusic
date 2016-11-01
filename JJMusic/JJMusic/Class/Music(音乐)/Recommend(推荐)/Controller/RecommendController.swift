//
//  RecommendController.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//  推荐控制器

import UIKit

class RecommendController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }

    private func configUI() {
        self.view.addSubview(focusV)
        focusV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(150)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /**轮播图*/
    private lazy var focusV: HJWheelView = {
        let object = HJWheelView(pictureArray: ["http://business.cdn.qianqian.com/qianqian/pic/bos_client_147796532705ae55ee0dab5099118e84db5b3929e8.jpg", "http://business.cdn.qianqian.com/qianqian/pic/bos_client_1477880068d5081634adc40bf2252340bde46acde0.jpg", "http://business.cdn.qianqian.com/qianqian/pic/bos_client_1477882761173ee2bc9378dfadb33632b05e8227cc.jpg", "http://business.cdn.qianqian.com/qianqian/pic/bos_client_1477624614b413c57803844ea999992b7142702e71.jpg", "http://business.cdn.qianqian.com/qianqian/pic/bos_client_1477905023c8b984e71494f2822cdf31ac5b627281.jpg"], didSelectItem: { (collectionView, indexPath) in
            
        })
        return object
    }()


}
