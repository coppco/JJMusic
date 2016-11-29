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
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.diyInfoVo?.title
        self.view.backgroundColor = UIColor.white
        
        guard let listid = self.diyInfoVo?.list_id else {
            return
        }
        HTTPRequestModel<ListDetailVo>.requestModel(type: .get, URLString: HTTPAddress.detailOfList(listID: listid), parameters: nil, success: {[weak self] (object) in
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
        self.view.addSubview(navigationV)
        self.view.addSubview(backImageV)
        self.view.addSubview(tableView)
        navigationV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(64)
        }
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
