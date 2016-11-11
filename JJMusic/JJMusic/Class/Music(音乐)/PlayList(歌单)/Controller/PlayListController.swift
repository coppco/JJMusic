//
//  PlayListController.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let kCollectionView_music_identify = "kCollectionView_music_identify"

class PlayListController: UIViewController {

    fileprivate var playList: PlayListVo? {
        didSet {
            DispatchQueue.main.async { 
                self.configUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlayListData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 获取歌单数据
    private func getPlayListData() {
        HTTPRequestModel<PlayListVo>.requestModel(type: .get, URLString: HTTPAddress.getPlayList, parameters: nil, success: {[weak self] (object) in
            self?.playList = object
            }) { (error) in
                
        }
    }
    
    private func configUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let object = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        object.register(MusicCCell.self, forCellWithReuseIdentifier: kCollectionView_music_identify)
        object.backgroundColor = UIColor.white
        object.delegate = self
        object.dataSource = self
        return object
    }()

    /// layout
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let object = UICollectionViewFlowLayout()
        object.minimumLineSpacing = spacingY  //上下间距
        object.minimumInteritemSpacing = spacingX  //左右间距
        object.sectionInset = UIEdgeInsetsMake(topBottom, itemLeftRight, topBottom, itemLeftRight)
        let width = (kMainScreenWidth - object.sectionInset.left - object.sectionInset.right - 2 * object.minimumInteritemSpacing) / 3
        object.itemSize = CGSize(width: width, height: width + 40 + 20)
        return object
    }()
    
}

extension PlayListController: UICollectionViewDelegate {
    
}

extension PlayListController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playList?.diyInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
        cell.diyInfo = self.playList?.diyInfo?[indexPath.item]
        return cell
    }
}
