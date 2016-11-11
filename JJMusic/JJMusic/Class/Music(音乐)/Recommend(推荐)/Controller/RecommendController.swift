//
//  RecommendController.swift
//  JJMusic
//
//  Created by coco on 16/10/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//  推荐控制器

import UIKit

private let kCollectionView_header_identify = "kCollectionView_header_identify"
private let kCollectionView_footer_identify = "kCollectionView_footer_identify"

private let kCollectionView_focus_identify = "kCollectionView_focus_identify"
private let kCollectionView_entry_identify = "kCollectionView_entry_identify"
private let kCollectionView_day_hot_identify = "kCollectionView_day_hot_identify"
private let kCollectionView_recsong_identify = "kCollectionView_recsong_identify"
private let kCollectionView_music_identify = "kCollectionView_music_identify"
private let kCollectionView_advert_identify = "kCollectionView_advert_identify"


class RecommendController: UIViewController {

    fileprivate var recommendData: RecommendVo?{
        didSet {
            configUI()
        }
    }
    
    /// 图片地址
    private var pictureArray: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecommendData()
    }

    private func configUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    //获取推荐数据
    private func getRecommendData() {
        HTTPRequestModel<RecommendVo>.requestModel(type: .get, URLString: HTTPAddress.getRecommend, parameters: nil, success: {[weak self] (model) in
            self?.recommendData = model
            }) { (error) in

        }
    }
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let object = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        object.backgroundColor = UIColor.white
        object.register(FocusCCell.self, forCellWithReuseIdentifier: kCollectionView_focus_identify)
        object.register(EntryCCell.self, forCellWithReuseIdentifier: kCollectionView_entry_identify)
        object.register(DayHotCCell.self, forCellWithReuseIdentifier: kCollectionView_day_hot_identify)
        object.register(MusicCCell.self, forCellWithReuseIdentifier: kCollectionView_music_identify)
        object.register(AdvertCCell.self, forCellWithReuseIdentifier: kCollectionView_advert_identify)
        object.register(RecsongCCell.self, forCellWithReuseIdentifier: kCollectionView_recsong_identify)
        
        object.register(MusicCHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionView_header_identify)
        object.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: kCollectionView_footer_identify)
        
        object.delegate = self
        object.dataSource = self
        return object
    }()

    /// layout
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let object = UICollectionViewFlowLayout()
        object.minimumLineSpacing = spacingY  //上下间距
        object.minimumInteritemSpacing = spacingX  //左右间距
        return object
    }()

    fileprivate lazy var itemWidth: CGFloat = {
        return (kMainScreenWidth - itemLeftRight - itemLeftRight - 2 * self.layout.minimumInteritemSpacing) / 3
    }()
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendController: UICollectionViewDelegateFlowLayout {
    /// 分区header大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let recommend = self.recommendData else {
            return CGSize.zero
        }
        guard let item = recommend.module?[section] else{
            return CGSize.zero
        }
        guard let key = item.key else {
            return CGSize.zero
        }
        if key == "focus" || key == "entry" || key == "mod_27" || key == "mix_2" {
            return CGSize.zero
        }
        var size = CGSize.zero
        Mirror(reflecting: recommend).children.forEach {(child) in
            if key == child.label {
                if let _ = child.value as? NSArray {
                    size = CGSize(width: kMainScreenWidth, height: 2 * topBottom + 15)
                }
            }
        }
        return size
    }
    /// 分区footer大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let recommend = self.recommendData else {
            return CGSize.zero
        }
        guard let item = recommend.module?[section] else{
            return CGSize.zero
        }
        guard let key = item.key else {
            return CGSize.zero
        }
        if key == "focus" {
            return CGSize.zero
        }
        var size = CGSize.zero
        Mirror(reflecting: recommend).children.forEach {(child) in
            if key == child.label {
                if let _ = child.value as? NSArray {
                    size = CGSize(width: kMainScreenWidth, height: 8)
                }
            }
        }
        return size
    }
    
    /// item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let recommend = self.recommendData else {
            return CGSize.zero
        }
        guard let item = recommend.module?[indexPath.section] else{
            return CGSize.zero
        }
        guard let key = item.key else {
            return CGSize.zero
        }
        if key == "focus" {
            return CGSize(width: self.view.frame.width, height: 150)
        }
        if key == "entry" {
            return CGSize(width: self.itemWidth, height: self.itemWidth)
        }
        if key == "mod_27" {
            return CGSize(width: self.view.frame.width, height: self.view.frame.width * 106 / 700)
        }
        if key == "mix_2" {
            return CGSize(width: self.view.frame.width, height: 100)
        }
        if key == "recsong" || key == "mod_7" {
            return CGSize(width: self.view.frame.width, height: 60)
        }
        var size = CGSize.zero
        Mirror(reflecting: recommend).children.forEach {(child) in
            if key == child.label {
                if let _ = child.value as? NSArray {
                    size = CGSize(width: self.itemWidth , height: self.itemWidth + 40 + 20)
                }
            }
        }
        return size
    }

    /// 分区内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let recommend = self.recommendData else {
            return UIEdgeInsets.zero
        }
        guard let item = recommend.module?[section] else{
            return UIEdgeInsets.zero
        }
        guard let key = item.key else {
            return UIEdgeInsets.zero
        }
        if key == "focus" || key == "mod_27" || key == "mix_2" || key == "recsong" || key == "mod_7" {
            return UIEdgeInsets.zero
        }
        var edg = UIEdgeInsets.zero
        Mirror(reflecting: recommend).children.forEach { (child) in
            if key == child.label {
                if let _ = child.value as? NSArray {
                    edg = UIEdgeInsetsMake(topBottom, itemLeftRight, topBottom, itemLeftRight)
                }
            }
        }
        return edg
    }
}

// MARK: - UICollectionViewDelegate
extension RecommendController: UICollectionViewDelegate {
    /// cell的高亮
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
     //可以在这里处理cell的高亮,  也可以在cell里面监听cell的hightlight处理
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.colorWithRGB(r: 234, g: 234, b: 234)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
 */
}

// MARK: - UICollectionViewDataSource
extension RecommendController: UICollectionViewDataSource {
    /// 分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendData?.module?.count ?? 0
    }
    
    /// 分区中item数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let recommend = self.recommendData else {
            return 0
        }
        guard let item = recommend.module?[section] else{
            return 0
        }
        guard let key = item.key else {
            return 0
        }
        //反射
        var count = 0
        Mirror(reflecting: recommend).children.forEach { (child) in
            if child.label == key {
                if let array = child.value as? NSArray {
                    count = array.count
                }
            }
            if key == "focus" && count != 0{
                count = 1
            }
            if key == "recsong" && count > 3{
                count = 3
            }
            
            if count > 6 {
                count = 6
            }
        }
        return count
    }
    /// item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let recommend = self.recommendData else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath)
            return cell
        }
        guard let item = recommend.module?[indexPath.section] else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath)
            return cell
        }
        guard let key = item.key else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath)
            return cell
        }
        if key == "focus" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_focus_identify, for: indexPath) as! FocusCCell
            cell.focusArray = self.recommendData?.focus
            return cell
        }
        if key == "entry" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_entry_identify, for: indexPath) as! EntryCCell
            cell.entry = self.recommendData?.entry?[indexPath.item]
            return cell
        }
        if key == "diy" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.div = recommend.diy?[indexPath.item]
            return cell
        }
        if key == "album" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.album = recommend.album?[indexPath.item]
            return cell
        }
        if key == "mix_22" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.mix_22 = recommend.mix_22?[indexPath.item]
            return cell
        }
        if key == "mix_2" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_day_hot_identify, for: indexPath) as! DayHotCCell
            cell.mix_22 = recommend.mix_2?[indexPath.item]
            return cell
        }

        if key == "mix_9" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.mix_9 = recommend.mix_9?[indexPath.item]
            return cell
        }
        if key == "mix_5" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.mix_5 = recommend.mix_5?[indexPath.item]
            return cell
        }
        if key == "radio" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.radio = recommend.radio?[indexPath.item]
            return cell
        }
        if key == "radio" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
            cell.radio = recommend.radio?[indexPath.item]
            return cell
        }
        if key == "mod_27" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_advert_identify, for: indexPath) as! AdvertCCell
            cell.mod_27 = recommend.mod_27?[indexPath.item]
            return cell
        }
        
        if key == "mod_7" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_recsong_identify, for: indexPath) as! RecsongCCell
            cell.mod_7 = recommend.mod_7?[indexPath.item]
            return cell
        }
        
        if key == "recsong" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_recsong_identify, for: indexPath) as! RecsongCCell
            cell.recsong = recommend.recsong?[indexPath.item]
            return cell
        }



        //TODO:  场景电台
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionView_music_identify, for: indexPath) as! MusicCCell
        return cell
}
    /// 表头表尾
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader && indexPath.section != 0 && indexPath.section != 1{
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionView_header_identify, for: indexPath) as! MusicCHeaderView
            view.moduleVo = self.recommendData?.module?[indexPath.section]
            return view
        } else {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: kCollectionView_footer_identify, for: indexPath)
            view.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
            return view
        }
    }
}
