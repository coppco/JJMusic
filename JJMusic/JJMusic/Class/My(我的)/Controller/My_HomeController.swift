//
//  My_HomeController.swift
//  JJMusic
//
//  Created by coco on 16/10/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let HomeController_Cell_ReuseIdentifier = "HomeController_Cell_ReuseIdentifier"
class My_HomeController: UIViewController {

    fileprivate var dataArray: [[My_Home_Cell_Data]] = {
        //section 1
        let local = My_Home_Cell_Data(iconName: "ic_mymusic_local",iconHightName: "ic_mymusic_local_press", title: "本地音乐", subTitle: "共0首歌曲", rightIcomName: "icon_home_guess_play_press", rightHightIconName: "icon_home_guess_play_normal")
        let recent = My_Home_Cell_Data(iconName: "ic_mymusic_time",iconHightName: "ic_mymusic_time_press", title: "最近播放", subTitle: "共0首歌曲,0首离线可播", rightIcomName: "bt_localmusic_enter_normal", rightHightIconName: "bt_localmusic_enter_press")
        let guss = My_Home_Cell_Data(iconName: "ic_mymusic_guss",iconHightName: "ic_mymusic_guss_press", title: "谁便听听", subTitle: "好音乐,随身听", rightIcomName: "bt_localmusic_enter_normal", rightHightIconName: "bt_localmusic_enter_press")
        
        //section2 
        let myLike = My_Home_Cell_Data(iconName: "ic_mymusic_ilike_normal",iconHightName: "ic_mymusic_ilike_normal", title: "我喜欢的单曲", subTitle: "共9首歌曲", rightIcomName: "bt_localmusic_enter_normal", rightHightIconName: "bt_localmusic_enter_press")
        
        return [[local, recent, guss], [myLike], []]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    fileprivate func configUI() {
        self.view.addSubview(backgroundImageV)
        self.view.addSubview(tableView)
        
        backgroundImageV.snp.makeConstraints {[unowned self] (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.backgroundImageV.snp.width)
        }
        
        tableView.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.view.snp.top).offset(64)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**背景图片*/
    fileprivate lazy var backgroundImageV: UIImageView = {
        let object = UIImageView(image: UIImage(named: "night.gif"))
        return object
    }()

    /**表视图*/
    fileprivate lazy var tableView: UITableView = {
        let object = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        object.separatorStyle = .none
        object.register(MyHomeTCell.self, forCellReuseIdentifier: HomeController_Cell_ReuseIdentifier)
        object.register(MyHomeIconHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyHomeIconHeaderView")
        object.register(MyHomeListHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyHomeListHeaderView")
        object.register(MyHomeCollectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyHomeCollectionHeaderView")
        object.register(MyHomeFooterView.self, forHeaderFooterViewReuseIdentifier: "MyHomeFooterView")
        object.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
        object.delegate = self
        object.dataSource = self
        object.sectionHeaderHeight = 0
        object.sectionFooterHeight = 0
        object.backgroundColor = UIColor.clear
        object.contentInset = UIEdgeInsetsMake(80, 0, 0, 0)
        return object
    }()
}

extension My_HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: HomeController_Cell_ReuseIdentifier, configuration: { (cell) in
            (cell as? MyHomeTCell)?.cellData = self.dataArray[indexPath.section][indexPath.row]
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = LocalMusicController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 52
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 50
        }
         return 8
    }
}

extension My_HomeController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeController_Cell_ReuseIdentifier) as! MyHomeTCell
        let model = self.dataArray[indexPath.section][indexPath.row]
        cell.cellData = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHomeIconHeaderView") as! MyHomeIconHeaderView
            return view
        } else if section == 1 {
             let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHomeListHeaderView") as! MyHomeListHeaderView
            return view
        } else if section == 2 {
             let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHomeCollectionHeaderView") as! MyHomeCollectionHeaderView
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyHomeFooterView") as! MyHomeFooterView
            return view
        } else {
            let view = UIView()
            view.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
            return view
        }
    }
}
