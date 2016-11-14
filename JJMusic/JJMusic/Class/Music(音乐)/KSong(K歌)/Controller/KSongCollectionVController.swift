//
//  KSongCollectionVController.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let kCollectionView_topImage_cell = "kCollectionView_topImage_cell"
private let kCollectionView_my_k_song_cell = "kCollectionView_my_k_song_cell"
private let kCollectionView_cateroty_cell = "kCollectionView_cateroty_cell"
private let kCollectionView_everyone_cell = "kCollectionView_everyone_cell"
class KSongCollectionVController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    init() {
        let object = UICollectionViewFlowLayout()
        object.minimumLineSpacing = 0
        object.minimumInteritemSpacing = 0
        object.headerReferenceSize = CGSize(width: kMainScreenWidth, height: 8)
//        object.itemSize = CGSize(width: kMainScreenWidth, height: 100)
        super.init(collectionViewLayout: object)
    }
    
    var topImage: KSongTopImageVo?
    var cateroty: KSongCategoryVo?
    var everyoneSong: KSongEveryoneVo?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
        getKSongData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(TopImageCCell.self, forCellWithReuseIdentifier: kCollectionView_topImage_cell)
        self.collectionView!.register(CategoryCCell.self, forCellWithReuseIdentifier: kCollectionView_cateroty_cell)
        self.collectionView!.register(RecsongCCell.self, forCellWithReuseIdentifier: kCollectionView_everyone_cell)
               self.collectionView!.register(MyKSongCCell.self, forCellWithReuseIdentifier: kCollectionView_my_k_song_cell)
        
    }

    private func getKSongData() {
        let group = DispatchGroup()
        self.getMyKSongData(group: group)
        self.getTopImageData(group: group)
        self.getEveryontData(group: group)
        
        group.notify(queue: DispatchQueue.main) { 
            if self.cateroty != nil && self.topImage != nil && self.everyoneSong != nil {
                //刷新界面
                self.collectionView?.reloadData()
            } else {
                //显示错误界面
            }
        }
    }
    //获取顶部图片
    private func getTopImageData(group: DispatchGroup) {
        group.enter()
        HTTPRequestModel<KSongTopImageVo>.requestModel(type: .get, URLString: HTTPAddress.KSongTopImage, parameters: nil, success: { (object) in
            group.leave()
            self.topImage = object
            }) { (error) in
                group.leave()
        }
    }
    //获取K歌
    private func getMyKSongData(group: DispatchGroup) {
        group.enter()
        HTTPRequestModel<KSongCategoryVo>.requestModel(type: .get, URLString: HTTPAddress.KSongMyK, parameters: nil, success: { (object) in
            group.leave()
            self.cateroty = object
        }) { (error) in
            group.leave()
        }

    }
    //大家都在唱
    private func getEveryontData(group: DispatchGroup) {
        group.enter()
        HTTPRequestModel<KSongEveryoneVo>.requestModel(type: .get, URLString: HTTPAddress.KSongEveryone, parameters: nil, success: { (object) in
            group.leave()
            self.everyoneSong = object
        }) { (error) in
            group.leave()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            return self.topImage?.result?.count ?? 0
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return self.cateroty?.items?.count ?? 0
        } else if section == 3 {
            return self.everyoneSong?.items?.count ?? 0
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  kCollectionView_topImage_cell, for: indexPath) as! TopImageCCell
            cell.item = self.topImage?.result?[indexPath.item]
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  kCollectionView_my_k_song_cell, for: indexPath) as! MyKSongCCell
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  kCollectionView_cateroty_cell, for: indexPath) as! CategoryCCell
            cell.item = self.cateroty?.items?[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  kCollectionView_everyone_cell, for: indexPath) as! RecsongCCell
            cell.kSongVo = self.everyoneSong?.items?[indexPath.item]
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.width, height: 174)
        } else if indexPath.section == 1 {
            return CGSize(width: self.view.frame.width, height: 60)
        } else if indexPath.section == 2 {
            return CGSize(width: self.view.frame.width / 3, height: self.view.frame.width / 3)
        } else if indexPath.section == 3 {
            return CGSize(width: self.view.frame.width, height: 60)
        }
        return CGSize.zero
    }
    
    
    
}
