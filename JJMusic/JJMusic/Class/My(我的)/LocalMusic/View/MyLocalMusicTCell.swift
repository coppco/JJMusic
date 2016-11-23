//
//  MyLocalMusicTCell.swift
//  JJMusic
//
//  Created by coco on 16/11/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import MediaPlayer
class MyLocalMusicTCell: UITableViewCell {

    var mediaItem: MPMediaItem? {
        didSet {
            self.songTitleL.text = mediaItem?.title
            
            self.artistL.text = (mediaItem?.artist ?? "未知艺人") + "《\((mediaItem?.albumTitle?.characters.count == 0 || mediaItem?.title == nil) ? (mediaItem?.title ?? "未知") : (mediaItem?.albumTitle)!)》"
        }
    }
    
    @IBOutlet weak var songTitleL: UILabel!
    @IBOutlet weak var detailB: UIButton!
    @IBOutlet weak var artistL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
