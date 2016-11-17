//
//  ListCollectionVController.swift
//  JJMusic
//
//  Created by coco on 16/11/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let reuseIdentifier_header = "reuseIdentifier_header"
class ListCollectionVController: UICollectionViewController {

    init() {
        let object = UICollectionViewFlowLayout()
        object.minimumLineSpacing = 0
        object.minimumInteritemSpacing = 0
        object.headerReferenceSize = CGSize(width: kMainScreenWidth, height: 8)
        object.itemSize = CGSize(width: kMainScreenWidth, height: 100)
        super.init(collectionViewLayout: object)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var listArray: ListArray? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246)
        getListData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(ListCCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier_header)
        // Do any additional setup after loading the view.
    }
    
    
    private func getListData() {
        self.show_LoadingHud()
        HTTPRequestModel<ListArray>.requestModel(type: .get, URLString: HTTPAddress.getList, parameters: nil, success: {[weak self] (object) in
            self?.hideAllHud()
            self?.listArray = object
            }) {[weak self] (error) in
                self?.hideAllHud()
        }
    }


    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.listArray?.content?.count ?? 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListCCell
        cell.listVo = self.listArray?.content?[indexPath.section]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier_header, for: indexPath)
            header.backgroundColor = UIColor.colorWithRGB(r: 246, g: 246, b: 246
            )
            return header
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
