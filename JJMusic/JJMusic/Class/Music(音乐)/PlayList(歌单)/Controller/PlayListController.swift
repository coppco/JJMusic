//
//  PlayListController.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//  歌单

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
        self.show_LoadingHud()
        HTTPRequestModel<PlayListVo>.requestModel(type: .get, URLString: HTTPAddress.getPlayList, parameters: nil, success: {[weak self] (object) in
            self?.playList = object
            }) {[weak self] (error) in
                self?.hideAllHud()
        }
    }
    
    private func configUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {[unowned self] (make) in
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailOfListController()
        detailVC.diyInfoVo = self.playList?.diyInfo?[indexPath.item]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
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
