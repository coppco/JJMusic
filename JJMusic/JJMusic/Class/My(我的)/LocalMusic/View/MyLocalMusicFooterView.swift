//
//  MyLocalMusicFooterView.swift
//  JJMusic
//
//  Created by coco on 16/11/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class MyLocalMusicFooterView: UIView {

    var count: Int = 0 {
        didSet {
            self.numberL.text = "共有\(count)首歌曲"
        }
    }
    
    @IBOutlet weak var numberL: UILabel!

    class func loadViewFromXib() -> MyLocalMusicFooterView {
        return Bundle.main.loadNibNamed("MyLocalMusicFooterView", owner: nil, options: nil)?.first as! MyLocalMusicFooterView
    }
    
}
