//
//  LocalMusicController.swift
//  JJMusic
//
//  Created by coco on 16/11/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import MediaPlayer
//显示模式
enum SortType: String {
    case all = "全部"  //全部
    case download = "下载"  //下载
    case singer = "歌手"  //歌手
    case album = "专辑"   //专辑
}

class LocalMusicController: UIViewController {
    //显示模式
    private var type: SortType = .all
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        HHLog(self.navigationController?.navigationBar.isTranslucent)
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "本地音乐"
        configUI()
        self.show_LoadingHud(message: "好音乐马上来")
        DispatchQueue.global().async {
            self.getIpodMusic()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configUI() {
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        topView.snp.makeConstraints {[unowned self] (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
    }
    //同步Ipod音乐
    private func getIpodMusic() {
        let group = DispatchGroup()
        self.sortAll(group: group)  //获取所有的
//        self.sortDownload(group: group) //下载的
        self.sortSinger(group: group)  //歌手
        self.sortAlbum(group: group) //专辑
        
        group.notify(queue: DispatchQueue.main) {
            self.show_Success(message: "同步音乐成功", delay: 0.8)
            self.sortDic = self.allSortDic
            self.sortKeys = self.allSortDic.keys.sorted(by: { (first, second) -> Bool in
                return first < second
            })
            if self.sortDic.count != 0 {
                self.tableView.tableHeaderView = self.tableHeaderView
                self.tableView.tableFooterView = self.tableFooterView
                self.tableFooterView.count = self.songCount
            } else {
                self.tableView.tableHeaderView = nil
                self.tableView.tableFooterView = UIView()
            }
            self.tableView.reloadData()
        }
    }
    
    /// topView
    fileprivate lazy var topView: TopTitleView = {
        let object = TopTitleView(titleArray: ["全部", "下载", "歌手", "专辑"], isAddButton: false, didClickedTitle: {[weak self] (title, index) in
            self?.gotoCurrentPage(title: title.identify_string)
            }, didClickedEdit: nil)
        return object
    }()
    
    private func gotoCurrentPage(title: String) {
        if title == self.type.rawValue { return }
        let temp = SortType(rawValue: title)
        if temp == .all {
            self.sortDic = self.allSortDic
            self.sortKeys = self.sortDic.keys.sorted(by: { (first, second) -> Bool in
                return first < second
            })
        } else if temp == .download {
            self.sortDic = self.downloadSortDic
            self.sortKeys = self.sortDic.keys.sorted(by: { (first, second) -> Bool in
                return first < second
            })
        } else if temp == .singer {
            self.sortDic = self.singerSortDic
            self.sortKeys = self.sortDic.keys.sorted(by: { (first, second) -> Bool in
                return first < second
            })
        } else if temp == .album {
            self.sortDic = self.albumSortDic
            self.sortKeys = self.sortDic.keys.sorted(by: { (first, second) -> Bool in
                return first < second
            })
        }
        self.tableView.reloadData()
    }
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        let object = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
//        object.register(MyLocalMusicTCell.self, forCellReuseIdentifier: "cell")
        object.register(UINib(nibName: "MyLocalMusicTCell", bundle: nil), forCellReuseIdentifier: "MyLocalMusicTCell")
        object.register(UINib(nibName: "MyLocalMusicSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MyLocalMusicSectionHeaderView")
        object.delegate = self
        object.dataSource = self
        object.tableFooterView = UIView()
        return object
    }()

    /// 歌曲媒体查询
    fileprivate lazy var songMediaQuery: MPMediaQuery = {
        let object = MPMediaQuery.songs()
        return object
    }()
    
    /// 歌手媒体查询
    fileprivate lazy var singerMediaQuery: MPMediaQuery = {
        let object = MPMediaQuery.artists()
        return object
    }()

    /// 专辑媒体查询
    fileprivate lazy var albumMediaQuery: MPMediaQuery = {
        let object = MPMediaQuery.albums()
        return object
    }()
    
    private func sortAll(group: DispatchGroup) {
        group.enter()
        self.allSortDic.removeAll()
        let array = self.songMediaQuery.items
        if array == nil || array?.count == 0{
            group.leave()
            return
        }
        songCount = array!.count
        for item in array! {
            //按歌名分类
            if let title = item.title {
                let first = title.transformToPinYin(whiteSpaceAllow: false, showPhoneticSymbol: false).firstCharacter().uppercased()
                if self.allSortDic.keys.contains(first) {
                    self.allSortDic[first]?.append(item)
                } else {
                    if first.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
                        self.allSortDic.updateValue([item], forKey: "#")
                    } else {
                        self.allSortDic.updateValue([item], forKey: first)
                    }
                }
            } else {
                if self.allSortDic.keys.contains("#") {
                    self.allSortDic["#"]?.append(item)
                } else {
                    self.allSortDic.updateValue([item], forKey: "#")
                }
            }
        }
        group.leave()
    }
    
    private func sortSinger(group: DispatchGroup) {
        group.enter()
        self.singerSortDic.removeAll()
        let array = self.singerMediaQuery.items
        if array == nil || array?.count == 0{
            group.leave()
            return
        }
        for item in array! {
            //按歌名分类
            if let title = item.artist {
                let first = title.transformToPinYin(whiteSpaceAllow: false, showPhoneticSymbol: false).firstCharacter().uppercased()
                if self.singerSortDic.keys.contains(first) {
                    self.singerSortDic[first]?.append(item)
                } else {
                    if first.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
                        self.singerSortDic.updateValue([item], forKey: "#")
                    } else {
                        self.singerSortDic.updateValue([item], forKey: first)
                    }
                }
            } else {
                if self.singerSortDic.keys.contains("#") {
                    self.singerSortDic["#"]?.append(item)
                } else {
                    self.singerSortDic.updateValue([item], forKey: "#")
                }
            }
        }
        group.leave()
    }
    
    private func sortAlbum(group: DispatchGroup) {
        group.enter()
        self.albumSortDic.removeAll()
        let array = self.albumMediaQuery.items
        if array == nil || array?.count == 0{
            group.leave()
            return
        }
        for item in array! {
            //按歌名分类
            if let title = item.albumTitle {
                let first = title.transformToPinYin(whiteSpaceAllow: false, showPhoneticSymbol: false).firstCharacter().uppercased()
                if self.albumSortDic.keys.contains(first) {
                    self.albumSortDic[first]?.append(item)
                } else {
                    if first.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
                        self.albumSortDic.updateValue([item], forKey: "#")
                    } else {
                        self.albumSortDic.updateValue([item], forKey: first)
                    }
                }
            } else {
                if self.albumSortDic.keys.contains("#") {
                    self.albumSortDic["#"]?.append(item)
                } else {
                    self.albumSortDic.updateValue([item], forKey: "#")
                }
            }
        }
        group.leave()
    }

    //歌曲数目
    fileprivate var songCount: Int = 0
    
    ///排序后的字典
    fileprivate var sortDic: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    ///排序后的字典key
    fileprivate var sortKeys: [String] = [String]()
    /// 所有
    fileprivate var allSortDic: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    //下载
    fileprivate var downloadSortDic: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    //歌手
    fileprivate var singerSortDic: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    //专辑
    fileprivate var albumSortDic: [String: [MPMediaItem]] = [String: [MPMediaItem]]()
    
    fileprivate lazy var tableHeaderView = MyLocalMusicHeaderView.loadViewFromXib()
    fileprivate lazy var tableFooterView = MyLocalMusicFooterView.loadViewFromXib()
}

// MARK: - UITableViewDelegate
extension LocalMusicController: UITableViewDelegate {
    /// 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.sortDic[self.sortKeys[indexPath.section]]?[indexPath.row]
        PlayerTool.shared.playWithURL(urlString: model?.assetURL?.absoluteString ?? "")
    }
}

// MARK: - UITableViewDataSource
extension LocalMusicController: UITableViewDataSource {
    
    /// 分区标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sortKeys[section]
    }
    /// 分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortKeys.count
    }
    /// 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortDic[self.sortKeys[section]]?.count ?? 0
    }
    /// cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyLocalMusicTCell", for: indexPath) as! MyLocalMusicTCell
        cell.mediaItem = self.sortDic[self.sortKeys[indexPath.section]]?[indexPath.row]
        return cell
    }
    //索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sortKeys
    }
    
    /// 点击右侧索引时执行的方法
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        IndexPopView.show(title: title, in: self.view)
        return index
    }
}
