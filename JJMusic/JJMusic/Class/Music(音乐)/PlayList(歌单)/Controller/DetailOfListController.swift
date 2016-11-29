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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let listid = self.diyInfoVo?.list_id else {
            return
        }
        HHLog(HTTPAddress.detailOfList(listID: listid))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
