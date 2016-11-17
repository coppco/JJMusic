//
//  RefreshHeader.swift
//  Chemistry
//
//  Created by coco on 16/9/29.
//  Copyright © 2016年 lhw. All rights reserved.
//

import UIKit

class RefreshHeader: MJRefreshGifHeader {

    lazy var images: [UIImage] = {
        var temp = [UIImage]()
        for i in 1...12 {
            temp.append(UIImage(named: "refresh-\(i)")!)
        }
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.lastUpdatedTimeLabel.isHidden = true //隐藏最后更新时间
//        self.setImages(self.images, forState: MJRefreshState.Refreshing)  //动画图片
        self.setImages(self.images, duration: 0.5, for: MJRefreshState.refreshing)
        self.setImages([UIImage(named: "refresh-down")!], for: MJRefreshState.idle)
        self.setImages([UIImage(named: "refresh-up")!], for: MJRefreshState.pulling)
//        self.setTitle("下拉更新", forState: MJRefreshState.Idle)
//        self.setTitle("松开更新", forState: MJRefreshState.Pulling)
//        self.setTitle("更新中", forState: MJRefreshState.Refreshing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        self.stateLabel.snp.makeConstraints {[unowned self] (make) in
            make.left.equalTo(self.snp.centerX).offset(-15)
            make.centerY.equalTo(self)
        }
        self.gifView.snp.makeConstraints {[unowned self] (make) in
            make.right.equalTo(self.snp.centerX).offset(-30)
            make.centerY.equalTo(self)
        }
        
    }
    
    
    override var state: MJRefreshState {
        didSet {
            if oldValue == state {
                return
            }
            super.state = state
            switch state {
            case .idle:
                if oldValue == .refreshing {
                    self.stateLabel.text = "更新完成"
                    state = .idle
                } else {
                    self.stateLabel.text = "下拉更新"
                }
            case .pulling:
                self.stateLabel.text = "松开更新"
            case .refreshing:
                self.stateLabel.text = "更新中"
            default:
                break
            }

        }
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable: Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        if self.state == .idle {
            if let offset = (change["new"] as AnyObject).cgPointValue {
                if offset.x == 0 {
                    self.stateLabel.text = "下拉更新"
                }
            }
        }
    }
}
