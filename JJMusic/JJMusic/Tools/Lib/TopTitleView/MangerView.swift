//
//  MangerView.swift
//  TypeManger
//
//  Created by coco on 16/11/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private enum CreateButtonType {
    case top, bottom
}

private let leftRight:CGFloat = 15  //左右间距
private let spaceX: CGFloat = 10  //x间距
private let spaceY: CGFloat = 10  //y间距
private let btnWidth = (UIScreen.main.bounds.width - CGFloat(buttonNumberOfRow - 1) * spaceX - 2 * leftRight) / CGFloat(buttonNumberOfRow)  //按钮宽度
private let btnHeight: CGFloat = 40 //按钮高度
private let buttonNumberOfRow: Int = 4   //每行按钮数
class MangerView: UIView {
    
    /// 已经选择类别数组
    var selectedTypeArray: [Identify]?
    
    /// 所有类别数组
    var allTypeArray: [Identify]?
    
    //最少保留几个按钮, 默认为1
    var fixedCount: Int = 1
    
    /// 未订阅类别数组
    private lazy var unSelectedTypeArray: [Identify]? = {
        var temp = self.allTypeArray
        if let didSelected = self.selectedTypeArray {
            for item in didSelected { //从全部里面去掉已选择的
                if temp?.contains(where: { (identify) -> Bool in
                    return identify.equal(to: item)
                }) == true {
                    if let index = temp?.index(where: { (identify) -> Bool in
                        return identify.equal(to: item)
                    }) {
                        temp?.remove(at: index)
                    }
                }
            }
        }
        return temp
    }()
    
    private override init(frame: CGRect) {
        self.selectedTypeArray = [Identify]()
        self.allTypeArray = [Identify]()
        super.init(frame: frame)
    }
    
    private init() {
        self.selectedTypeArray = [Identify]()
        self.allTypeArray = [Identify]()
        super.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect, selectedTypeArray: [Identify], allTypeArray: [Identify]) {
        self.allTypeArray = allTypeArray
        self.selectedTypeArray = selectedTypeArray
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private Function
    private func configUI() {
        self.addGestureRecognizer(self.longPressGuesture)
        self.addSubview(scrollView)
        scrollView.addSubview(topL)
        scrollView.addSubview(bottomL)
        topL.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(10)
            make.left.right.equalTo(self).inset(UIEdgeInsetsMake(0, 10, 0, 10))
        }
        
        if let selected = self.selectedTypeArray {
            for (index, item) in selected.enumerated() {
                self.createButton(type: .top, index: index, item: item)
            }
        }
        //分页 (count + maxColumns - 1) / maxColumns
        let topPage = ceil(Double(self.selectedTypeArray?.count ?? 0) / Double(buttonNumberOfRow))

        bottomL.snp.makeConstraints {[unowned self] (make) in
            make.left.right.equalTo(self).inset(UIEdgeInsetsMake(0, 10, 0, 10))
            make.top.equalTo(self.topL.snp.bottom).offset(spaceY + CGFloat(topPage) * (btnHeight + spaceY))
        }
        
        if let selected = self.unSelectedTypeArray {
            for (index, item) in selected.enumerated() {
                self.createButton(type: .bottom, index: index, item: item)
            }
        }
        
        let bottomPage = ceil(Double(self.unSelectedTypeArray?.count ?? 0) / Double(buttonNumberOfRow))
        scrollView.snp.makeConstraints {[unowned self] (make) in
            make.edges.equalTo(self)
            make.right.equalTo(self.bottomL.snp.right)
            make.bottom.equalTo(self.bottomL).offset(bottomPage * Double(btnHeight + spaceX))
        }
    }
    
    private func updateTitleVAndScrollView() {
    }
    
    /// 创建按钮
    @discardableResult
    private func createButton(type: CreateButtonType, index: Int, item: Identify) -> UIButton {
        let object = UIButton(type: UIButtonType.custom)
        object.setTitle(item.identify_string, for: UIControlState.normal)
        object.setTitleColor(UIColor.black, for: UIControlState.normal)
        object.layer.cornerRadius = 4
        object.layer.borderWidth = 0.5
        object.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        object.layer.borderColor = UIColor.gray.cgColor
        object.backgroundColor = UIColor.white
        let row = index / buttonNumberOfRow
        let column = index % buttonNumberOfRow
        scrollView.addSubview(object)
        if type == .top {
            selectedButtons.append(object)
            object.addTarget(self, action: #selector(MangerView.didSelectedTopButton(sender:)), for: UIControlEvents.touchUpInside)
            object.snp.makeConstraints({ (make) in
                make.top.equalTo(topL.snp.bottom).offset(spaceY + CGFloat(row) * (btnHeight + spaceY))
                make.width.equalTo(btnWidth)
                make.height.equalTo(btnHeight)
                make.left.equalTo(self.snp.left).offset(leftRight + CGFloat(column) * (btnWidth + spaceX))
            })
        } else if type == .bottom {
            unSelectedButtons.append(object)
            object.addTarget(self, action: #selector(MangerView.didSelectedBottomButton(sender:)), for: UIControlEvents.touchUpInside)
            object.snp.makeConstraints({ (make) in
                make.top.equalTo(bottomL.snp.bottom).offset(spaceY + CGFloat(row) * (btnHeight + spaceY))
                make.width.equalTo(btnWidth)
                make.height.equalTo(btnHeight)
                make.left.equalTo(self.snp.left).offset(leftRight + CGFloat(column) * (btnWidth + spaceX))
            })
        }
        return object
    }
    
    @objc private func didSelectedTopButton(sender: UIButton) {
        if self.selectedButtons.count <= self.fixedCount { //最少保留几个按钮
            return
        }
        guard let index = self.selectedButtons.index(of: sender) else{
            return
        }
        guard let object = self.selectedTypeArray?.remove(at: index) else{
            return
        }
        self.isUserInteractionEnabled = false
        self.selectedButtons.remove(at: index)
        self.unSelectedButtons.insert(sender, at: 0)
        self.unSelectedTypeArray?.insert(object, at: 0)
        self.bringSubview(toFront: sender)
        //更新位置
        updateLocation()
        sender.addTarget(self, action: #selector(MangerView.didSelectedBottomButton(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func didSelectedBottomButton(sender: UIButton) {
        guard let index = self.unSelectedButtons.index(of: sender) else{
            return
        }
        guard let object = self.unSelectedTypeArray?.remove(at: index) else{
            return
        }
        self.isUserInteractionEnabled = false
        self.unSelectedButtons.remove(at: index)
        self.selectedButtons.append(sender)
        self.selectedTypeArray?.append(object)
        self.bringSubview(toFront: sender)
        //更新位置
        updateLocation()
        
        sender.addTarget(self, action: #selector(MangerView.didSelectedTopButton(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    //更新位置
    fileprivate func updateLocation() {
        
        for (index, button) in self.selectedButtons.enumerated() {
            let row = index / buttonNumberOfRow
            let column = index % buttonNumberOfRow
            button.snp.remakeConstraints({ (make) in
                make.width.equalTo(btnWidth)
                make.height.equalTo(btnHeight)
                make.top.equalTo(topL.snp.bottom).offset(spaceY + CGFloat(row) * (btnHeight + spaceY))
                make.left.equalTo(self.snp.left).offset(leftRight + CGFloat(column) * (btnWidth + spaceX))
            })
        }
        
        let topPage = ceil(Double(self.selectedTypeArray?.count ?? 0) / Double(buttonNumberOfRow))
        bottomL.snp.updateConstraints { (make) in
            make.top.equalTo(topL.snp.bottom).offset(spaceY + CGFloat(topPage) * (btnHeight + spaceY))
        }
        
        
        for (index, button) in self.unSelectedButtons.enumerated() {
            let row = index / buttonNumberOfRow
            let column = index % buttonNumberOfRow
            button.snp.remakeConstraints({ (make) in
                make.top.equalTo(bottomL.snp.bottom).offset(spaceY + CGFloat(row) * (btnHeight + spaceY))
                make.width.equalTo(btnWidth)
                make.height.equalTo(btnHeight)
                make.left.equalTo(self.snp.left).offset(leftRight + CGFloat(column) * (btnWidth + spaceX))
            })
        }
        let bottomPage = ceil(Double(self.unSelectedTypeArray?.count ?? 0) / Double(buttonNumberOfRow))
        scrollView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.bottomL).offset(bottomPage * Double(btnHeight + spaceX))
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }) { (flag) in
            self.isUserInteractionEnabled = true
        }
    }
    
    /**记录长按的按钮*/
    private var longPressButton: UIButton?
    private var startPoint: CGPoint?
    @objc private func longPress(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self)
        
        switch sender.state {
        case .began:
            guard let locationButton = self.getSelectedButton(point: point) else {
                return
            }
            
            self.longPressButton = locationButton
            self.bringSubview(toFront: locationButton)
            self.addSubview(self.popButton)
            self.popButton.setTitle(locationButton.currentTitle, for: UIControlState.normal)
            self.popButton.setTitleColor(locationButton.currentTitleColor, for: UIControlState.normal)
            self.popButton.backgroundColor = locationButton.backgroundColor
            self.popButton.frame = locationButton.frame
            self.startPoint = point
            UIView.animate(withDuration: 0.25, animations: {
                self.popButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        case .changed:
            guard let longPressB = self.longPressButton else {
                return
            }
            if let startP = self.startPoint {
                let center = self.popButton.center
                self.popButton.center = CGPoint(x: center.x + point.x - startP.x, y: center.y + point.y - startP.y)
                self.startPoint = point
            }
            
            guard let destinationButton = self.getSelectedButton(point: point) else {//没找到按钮
                return
            }
            if destinationButton == self.longPressButton { //同一个按钮返回
                return
            }
            //交换位置
            guard let startIndex = self.selectedButtons.index(of: longPressB) else {
                return
            }
            guard let destination = self.selectedButtons.index(of: destinationButton) else {
                return
            }
            self.selectedButtons.remove(at: startIndex)
            let object = self.selectedTypeArray?.remove(at: startIndex)
            self.selectedButtons.insert(longPressB, at: destination)
            if let temp = object {
                self.selectedTypeArray?.insert(temp, at: destination)
            }
            self.updateLocation()
            
            break
        case .cancelled:
            fallthrough
        case .ended:
            self.startPoint = nil
            UIView.animate(withDuration: 0.25, animations: {
                if let center = self.longPressButton?.center {
                    self.popButton.center = center
                }
                self.popButton.transform = .identity
                }, completion: { (flag) in
                    self.popButton.removeFromSuperview()
                    self.longPressButton = nil
            })
            break
        default:
            break
        }
    }
    
    fileprivate func getSelectedButton(point: CGPoint) -> UIButton? {
        for (_, butotn) in self.selectedButtons.enumerated() {
            if butotn.frame.contains(point) {
                return butotn
            }
        }
        return nil
    }
    
    //MARK: Private Property
    /// scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let object = UIScrollView()
        return object
    }()
    
    /// 已选择Label
    fileprivate lazy var topL: UILabel = {
        let object = UILabel()
        object.text = "已订阅类别(拖动调整顺序)"
        object.textColor = UIColor.gray
        object.font = .systemFont(ofSize: 14)
        return object
    }()
    
    /// 取消Label
    fileprivate lazy var bottomL: UILabel = {
        let object = UILabel()
        object.text = "全部类别(点击添加更多)"
        object.textColor = UIColor.gray
        object.font = .systemFont(ofSize: 14)
        return object
    }()
    
    /**长按手势*/
    fileprivate lazy var longPressGuesture: UILongPressGestureRecognizer = {
        let object = UILongPressGestureRecognizer(target: self, action: #selector(MangerView.longPress(sender:)))
        object.minimumPressDuration = 0.5
        return object
    }()
    
    /**popView*/
    fileprivate lazy var popButton: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setTitle("示例弹出view", for: UIControlState.normal)
        //        object.setTitleColor(UIColor.randomColor(), for: UIControlState.normal)
        object.layer.cornerRadius = 5
        object.layer.borderColor = UIColor.gray.cgColor
        object.layer.borderWidth = 1
        return object
    }()

    
    /// 已选择按钮
    fileprivate lazy var selectedButtons = [UIButton]()
    /// 未选择按钮
    fileprivate lazy var unSelectedButtons = [UIButton]()
}
