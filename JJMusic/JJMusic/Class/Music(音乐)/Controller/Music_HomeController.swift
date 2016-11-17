//
//  Music_HomeController.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let kCollectionView_cell_identify = "kCollectionView_cell_identify"
class Music_HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        self.view.addSubview(backgroundImageV)
        self.view.addSubview(topView)
        self.view.addSubview(collectionView)
        self.addChildViewController(recommendVC)
        self.addChildViewController(playListVC)
        self.addChildViewController(listVC)
        self.addChildViewController(kSongVC)
        
        backgroundImageV.snp.makeConstraints {[unowned self] (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(64)
        }
        
        topView.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.backgroundImageV.snp.bottom)
            make.left.right.equalTo(self.backgroundImageV)
            make.height.equalTo(44)
        }
        
        self.collectionView.snp.makeConstraints {[unowned self] (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
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

    /**顶部标题栏*/
    fileprivate lazy var topView: TopTitleView = {
        let object = TopTitleView(titleArray: ["推荐", "歌单", "榜单", "K歌"], isAddButton: false, didClickedTitle: {[weak self] (identify_string, index) in
            self?.collectionView.setContentOffset(CGPoint.init(x: CGFloat(index) * kMainScreenWidth, y: 0), animated: false)
            }, didClickedEdit: { 
                
        })
        return object
    }()

    /**推荐*/
    fileprivate lazy var recommendVC: RecommendController = {
        let object = RecommendController()
        return object
    }()

    /// 歌单
    fileprivate lazy var playListVC: PlayListController = {
        let object = PlayListController()
        return object
    }()
    
    /// 榜单
    fileprivate lazy var listVC: ListCollectionVController = {
        let object = ListCollectionVController()
        return object
    }()
    
    /// k歌
    fileprivate lazy var kSongVC: KSongCollectionVController = {
        let object = KSongCollectionVController()
        return object
    }()


    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 44 - 64 - 44)
        let object = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        object.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionView_cell_identify)
        object.backgroundColor = UIColor.white
        object.isPagingEnabled = true
        object.showsVerticalScrollIndicator = false
        object.showsHorizontalScrollIndicator = false
        object.delegate = self
        object.dataSource = self
        return object
    }()
}

// MARK: - UICollectionViewDelegate
extension Music_HomeController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource
extension Music_HomeController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_cell_identify, for: indexPath)
        for item in cell.contentView.subviews {
            item.removeFromSuperview()
        }
        if indexPath.item == 0 {
            cell.contentView.addSubview(self.recommendVC.view)
            self.recommendVC.view.frame = cell.bounds
        } else if indexPath.item == 1 {
            cell.contentView.addSubview(self.playListVC.view)
            self.playListVC.view.frame = cell.bounds
        } else if indexPath.item == 2 {
            cell.contentView.addSubview(self.listVC.view)
            self.listVC.view.frame = cell.bounds
        } else if indexPath.item == 3 {
            cell.contentView.addSubview(self.kSongVC.view)
            self.kSongVC.view.frame = cell.bounds
        }
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension Music_HomeController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let page = (offset.x - scrollView.frame.width / 2) / scrollView.frame.width
//        let page = scrollView.contentOffset.x / scrollView.width
        self.topView.shouldScrollToCurrentLocation(index: Int(ceil(page)))
    }
}
