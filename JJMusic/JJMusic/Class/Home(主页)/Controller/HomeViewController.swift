//
//  HomeViewController.swift
//  JJMusic
//
//  Created by coco on 16/10/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 
        self.edgesForExtendedLayout = .init(rawValue: 0) //默认情况下,如果是导航栏从导航栏下面开始布局, 设置为0取消这个设置
        self.view.addSubview(collectionView)
        self.addChildViewController(myMusicV)
        self.addChildViewController(myLocalV)
        self.addChildViewController(trendsV)
        collectionView.snp.makeConstraints {[unowned self] (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
        
        self.view.addSubview(navigationV)
        navigationV.snp.makeConstraints {[unowned self] (make) in
            make.top.right.left.equalTo(self.collectionView)
            make.height.equalTo(64)
        }
        self.view.bringSubview(toFront: navigationV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Private
    
    /**导航栏*/
    fileprivate lazy var navigationV: HomeNavigationView = {
        let object = HomeNavigationView.shared
        object.didSelectedButton = {[weak self] index in
            let offset = self?.collectionView.contentOffset
            self?.collectionView.contentOffset = CGPoint(x: CGFloat(index) * kMainScreenWidth, y: offset?.y ?? 0)
        }
        return object
    }()

    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        let object = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        object.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        object.backgroundColor = UIColor.white
        object.isPagingEnabled = true
        object.delegate = self
        object.dataSource = self
        object.showsVerticalScrollIndicator = false
        object.showsHorizontalScrollIndicator = false
        return object
    }()

    
    /**我的*/
    fileprivate lazy var myLocalV: My_HomeController = {
        let object = My_HomeController()
        return object
    }()

    /**音乐*/
    fileprivate lazy var myMusicV: Music_HomeController = {
        let object = Music_HomeController()
        return object
    }()

    /// 动态
    fileprivate lazy var trendsV: TrendsController = {
        let object = TrendsController()
        return object
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        if indexPath.section == 0 {
            cell.contentView.addSubview(self.myLocalV.view)
            myLocalV.view.frame = cell.bounds
        } else if indexPath.section == 1{
            cell.contentView.addSubview(self.myMusicV.view)
            myMusicV.view.frame = cell.bounds
        } else if indexPath.section == 2 {
            cell.contentView.addSubview(self.trendsV.view)
            trendsV.view.frame = cell.bounds
        }
        return cell
    }
}



extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let page = (offset.x - scrollView.frame.width / 2) / scrollView.frame.width
        self.navigationV.shouldMoveTo(index: Int(ceil(page)))
    }
}
