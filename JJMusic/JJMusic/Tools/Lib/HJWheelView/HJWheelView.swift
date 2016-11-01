//
//  HJWheelView.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//  轮播图

import UIKit

private let duration: TimeInterval = 3.0
private let WheelView_Reuse_Identifier = "WheelView_Reuse_Identifier"
class HJWheelView: UIView {
    
    typealias didSelectClosure = (UICollectionView, IndexPath) -> Void
    /// 图片地址数组
    fileprivate var pictureArray: [String] = [String]()
    
    /// 选中item执行的闭包
    fileprivate var didSelectItem: didSelectClosure?

    /// 是否轮播
    fileprivate var isLoop: Bool = true
    
    
    /// 初始化方法
    ///
    /// - parameter pictureArray:  图片地址数组
    /// - parameter isLoop:        是否轮播,默认true
    /// - parameter duration:        轮播图默认时间
    /// - parameter didSelectItem: 选择item执行的闭包
    ///
    /// - returns: 返回对象
    init(pictureArray: [String], isLoop: Bool = true, duration: TimeInterval = duration, didSelectItem: didSelectClosure?) {
        //前面添加一张过渡图片(最后一张图片)
        var temp = [String]()
        temp.append(contentsOf: pictureArray)
        if let last = pictureArray.last {
            temp.insert(last, at: 0)
        }
        self.pictureArray = temp
        self.isLoop = isLoop
        self.didSelectItem = didSelectItem
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    private init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.pageControl.numberOfPages = self.pictureArray.count - 1
        
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        //添加进入common运行循环,防止拖动的时候不轮播
        if self.isLoop {
            RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(30)
        }
        
    }
    
    fileprivate func startTimer() {
        self.timer = Timer(timeInterval: duration, target: self, selector: #selector(HJWheelView.timer(sender:)), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
    }
    
    //MARK: Private
    /**集合视图*/
    fileprivate lazy var collectionView: UICollectionView = {
        let object = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        object.isPagingEnabled = true
        object.showsHorizontalScrollIndicator = false
        object.backgroundColor = .clear
        object.delegate = self
        object.dataSource = self
        object.register(UICollectionViewCell.self, forCellWithReuseIdentifier: WheelView_Reuse_Identifier)
        return object
    }()
    
    /**layout*/
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let object = UICollectionViewFlowLayout()
        object.scrollDirection = .horizontal
        object.minimumLineSpacing = 0
        object.minimumInteritemSpacing = 0
        object.sectionInset = UIEdgeInsets.zero
        return object
    }()

    /**PageControl*/
    fileprivate lazy var pageControl: UIPageControl = {
        let object = UIPageControl()
        object.currentPage = 0
        object.currentPageIndicatorImage = UIImage(named: "currentPageControl@2x")
        object.pageIndicatorImage = UIImage(named: "otherPageControl@2x")
        object.addTarget(self, action: #selector(HJWheelView.pageDidChange(sender:)), for: UIControlEvents.valueChanged)
        return object
    }()

    /**定时器*/
    fileprivate lazy var timer: Timer = {
        let object = Timer(timeInterval: duration, target: self, selector: #selector(HJWheelView.timer(sender:)), userInfo: nil, repeats: true)
        return object
    }()
    
    /// 定时器执行方法
    @objc fileprivate func timer(sender: Timer) {
        let offset = self.collectionView.contentOffset
        if offset.x >= CGFloat(self.pictureArray.count - 1) * self.collectionView.frame.width {
            self.collectionView.setContentOffset(CGPoint.init(x: 0, y: offset.y), animated: false)
            self.collectionView.setContentOffset(CGPoint.init(x: self.collectionView.frame.width, y: offset.y), animated: true)
        } else {
            self.collectionView.setContentOffset(CGPoint.init(x: offset.x + self.collectionView.frame.width, y: offset.y), animated: true)
        }
    }
    
    /// pageControl执行方法
    @objc fileprivate func pageDidChange(sender: UIPageControl) {
        self.collectionView.setContentOffset(CGPoint(x:CGFloat(sender.currentPage) * self.collectionView.frame.width, y: 0), animated: true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout.itemSize = self.frame.size
        self.collectionView.contentOffset = CGPoint(x: self.collectionView.frame.width, y: 0) //偏移量
    }
    
}

// MARK: - UICollectionViewDelegate
extension HJWheelView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let closure = self.didSelectItem {
            closure(collectionView, indexPath)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HJWheelView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheelView_Reuse_Identifier, for: indexPath)
        let string = self.pictureArray[indexPath.item]
        if let imageV =  cell.backgroundView as? UIImageView {
            if string.hasPrefix("http") {
                imageV.kf.setImage(with: URL(string: string), placeholder: UIImage(named: "homepage_focus_default"), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                imageV.image = UIImage(named: string)
            }
        } else {
            let imageV = UIImageView(frame: cell.bounds)
            if string.hasPrefix("http") {
                imageV.kf.setImage(with: URL(string: string), placeholder: UIImage(named: "homepage_focus_default"), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                imageV.image = UIImage(named: string)
            }
            cell.backgroundView = imageV
        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureArray.count
    }
}

// MARK: - UIScrollViewDelegate
extension HJWheelView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.isLoop {
            self.timer.invalidate()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.isLoop {
            self.startTimer()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x - scrollView.frame.width / 2) / scrollView.frame.width
        if page < 0 {
            self.pageControl.currentPage = self.pageControl.numberOfPages - 1
        } else {
            self.pageControl.currentPage = Int(page)
        }
    }
    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let page = (offset.x - scrollView.frame.width / 2) / scrollView.frame.width
        if page <= 0 {
            scrollView.setContentOffset(CGPoint.init(x: CGFloat(self.pictureArray.count - 1) * scrollView.frame.width, y: offset.y), animated: false)
        } else if page > CGFloat(self.pictureArray.count) - 2 {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: offset.y), animated: false)
        }
    }
}

