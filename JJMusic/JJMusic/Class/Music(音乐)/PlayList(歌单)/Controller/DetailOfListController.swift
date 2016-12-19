//
//  DetailOfListController.swift
//  JJMusic
//
//  Created by M_coppco on 2016/11/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//  歌单详情

import UIKit

class DetailOfListController: UIViewController {

    var diyInfoVo: DiyInfoVo?
    var listDetailVo: ListDetailVo? {
        didSet {
            if listDetailVo != nil {
                if let icon = self.listDetailVo?.pic_500 {
                    backImageV.kf.setImage(with: URL(string: icon))
                }
                self.tableView.reloadData()
                HHLog(diyInfoVo?.list_id)
                for item in listDetailVo!.content! {
                    HHLog(item.song_id!)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //去掉底部线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //是否透明
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        //歌曲详情
        //http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1482144123&songid=8074547&nw=2&l2p=507.4&lpb=320000&ext=MP3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=QOGTjG2ETKMi9RMZ0z0G%2FDONjq9EczQwIxGmMPNxZ%2B0%3D&channel=(null)&cuid=appstore&from=ios&version=5.9.5
        
        super.viewDidLoad()
        self.navigationItem.title = self.diyInfoVo?.title
        self.view.backgroundColor = UIColor.white
        
        guard let listid = self.diyInfoVo?.list_id else {
            return
        }

        
        HTTPRequestModel<ListDetailVo>.requestModel(type: .post, URLString: HTTPAddress.detailOfList(listID: listid), parameters: nil, success: {[weak self] (object) in
            DispatchQueue.main.async {
                self?.listDetailVo = object
            }
            }) { (error) in
                print(error)
        }
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configUI() {
//        self.view.addSubview(navigationV)
        self.view.addSubview(backImageV)
        self.view.addSubview(tableView)
//        navigationV.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(self.view)
//            make.height.equalTo(64)
//        }
        backImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(backImageV.snp.width)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 44, 0))
        }
        
        self.view.bringSubview(toFront: self.navigationV)
    }
    //MARK: Private
    ///背景图
    fileprivate lazy var backImageV: UIImageView = {
        let object = UIImageView()
        return object
    }()
    
    ///表视图
    fileprivate lazy var tableView: UITableView = {
        let object = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        object.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        object.delegate = self
        object.dataSource = self
        object.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        object.backgroundColor = UIColor.clear
        object.showsVerticalScrollIndicator = false
        object.showsHorizontalScrollIndicator = false
        return object
    }()
    
    ///导航栏
    fileprivate lazy var navigationV: DetailNavigationView = {
        let object = DetailNavigationView()
        return object
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension DetailOfListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.listDetailVo?.content?[indexPath.row].song_id {
            HTTPRequest.requestJSON(type: .get, URLString: HTTPAddress.songInfo(songId: data), parameters: nil, encoding: JSONEncoding.default, headers: nil, success: { (object) in
                if let dic = object as? NSDictionary {
                    if let data = dic["data"] as? NSDictionary {
                        if let songList = data["songList"] as? NSArray {
                            if let d = songList.firstObject as? NSDictionary {
                                if let url = d["songLink"] as? String {
                                    HHLog(url)
                                    PlayerTool.shared.playWithURL(urlString: url)
                                }
                            }
                        }
                    }
                }
                }, failed: { (error) in
                    HHLog(error)
            })
        }
    }
}

extension DetailOfListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDetailVo?.content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.listDetailVo?.content?[indexPath.row].title
        cell?.detailTextLabel?.text = self.listDetailVo?.content?[indexPath.row].author
        return cell!
    }
}
