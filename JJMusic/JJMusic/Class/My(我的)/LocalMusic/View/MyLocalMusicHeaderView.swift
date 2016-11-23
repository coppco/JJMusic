//
//  MyLocalMusicHeaderView.swift
//  JJMusic
//
//  Created by coco on 16/11/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyLocalMusicHeaderView: UIView {

    class func loadViewFromXib() -> MyLocalMusicHeaderView {
        return Bundle.main.loadNibNamed("MyLocalMusicHeaderView", owner: nil, options: nil)?.first as! MyLocalMusicHeaderView
    }
    
    
    @IBOutlet weak var randomB: UIButton!
    @IBOutlet weak var sortB: UIButton!
    @IBOutlet weak var editB: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
