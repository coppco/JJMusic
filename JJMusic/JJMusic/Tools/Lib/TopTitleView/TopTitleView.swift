//
//  TopTitleView.swift
//  RSS_Message
//
//  Created by coco on 16/10/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let labelFont: CGFloat = 14
private let kButtonTag: Int = 9909
private let editButtonWidth: CGFloat = 44
class TopTitleView: UIView {
    
    /// 滚动到合适的位置
    ///
    /// - parameter index: 下标
    func shouldScrollToCurrentLocation(index: Int) {
        if let oldB = self.selectedButton, let newB = self.viewWithTag(index + kButtonTag) as? UIButton, oldB != newB {
            self.animations(oldButton: oldB, newButton: newB)
            self.selectedButton = newB
        }
    }
    
    
    /// 更改顶部标签执行
    ///
    /// - parameter titleArray:
    func updateViewWithTitleArray(titleArray: [Identify]?) {
        if let new = titleArray {
            self.titleArray = new
            
            if self.allButtons.count == self.titleArray.count {
                for (index, item) in self.titleArray.enumerated() {
                    self.allButtons[index].setTitle(item.identify_string, for: UIControlState.normal)
                }
            } else if self.allButtons.count > self.titleArray.count {
                let count = self.titleArray.count
                if count <= 0 {
                    return
                }
//                var width: CGFloat = 0
//                if count < 5 {
//                    if self.isAddButton {
//                        width = (kMainScreenWidth - editButtonWidth) / CGFloat(count)
//                    } else {
//                        width = kMainScreenWidth / CGFloat(count)
//                    }
//                } else {
//                    if self.isAddButton {
//                        width = (kMainScreenWidth - editButtonWidth) / 4
//                    } else {
//                        width = kMainScreenWidth / 4
//                    }
//                }
                var tempB: UIButton?
                for (index, item) in self.allButtons.enumerated() {
                    if index < self.titleArray.count {
                        item.setTitle(self.titleArray[index].identify_string, for: UIControlState.normal)
                        item.snp.updateConstraints({ (make) in
//                            make.left.equalTo(width * CGFloat(index))
//                            make.width.equalTo(width)
                            
                            if self.isAddButton {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(5)
                                }
                            } else {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).dividedBy(5)
                                }
                            }
                            if tempB == nil {
                                make.left.equalTo(0)
                            } else {
                                make.left.equalTo(tempB!.snp.right)
                            }
                            
                        })
                        if index == self.titleArray.count - 1 {
                            scrollView.snp.makeConstraints { (make) in
                                make.right.equalTo(item.snp.right)
                            }
                        }
                        tempB = item
                    } else {
                        item.snp.removeConstraints()
                        item.removeFromSuperview()
                    }
                }
                self.allButtons.removeLast(self.allButtons.count - self.titleArray.count)
            } else if self.allButtons.count < self.titleArray.count {
                let count = self.titleArray.count
                if count <= 0 {
                    return
                }
//                var width: CGFloat = 0
//                if count < 5 {
//                    if self.isAddButton {
//                        width = (kMainScreenWidth - editButtonWidth) / CGFloat(count)
//                    } else {
//                        width = kMainScreenWidth / CGFloat(count)
//                    }
//                } else {
//                    if self.isAddButton {
//                        width = (kMainScreenWidth - editButtonWidth) / 4
//                    } else {
//                        width = kMainScreenWidth / 4
//                    }
//                }
                var tempB: UIButton?
                for (index, item) in self.titleArray.enumerated() {
                    if index < self.allButtons.count {
                        self.allButtons[index].setTitle(item.identify_string, for: UIControlState.normal)
                        self.allButtons[index].titleLabel?.font = UIFont.systemFont(ofSize: labelFont)
                        self.allButtons[index].snp.updateConstraints({ (make) in
//                            make.left.equalTo(width * CGFloat(index))
//                            make.width.equalTo(width)
                            if self.isAddButton {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(5)
                                }
                            } else {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).dividedBy(5)
                                }
                            }
                            if tempB == nil {
                                make.left.equalTo(0)
                            } else {
                                make.left.equalTo(tempB!.snp.right)
                            }
                        })
                        tempB = self.allButtons[index]
                    } else {
                        //创建按钮
                        let button = UIButton(type: UIButtonType.custom)
                        self.allButtons.append(button)
                        button.setTitle(item.identify_string, for: UIControlState.normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: labelFont)
                        button.setTitleColor(UIColor.black, for: UIControlState.normal)
                        button.addTarget(self, action: #selector(TopTitleView.buttonHasClicked(sender:)), for: UIControlEvents.touchUpInside)
                        button.tag = index + kButtonTag
                        
                        scrollView.addSubview(button)
                        button.snp.makeConstraints({ (make) in
                            make.centerY.equalTo(scrollView)
//                            make.left.equalTo(width * CGFloat(index))
//                            make.width.equalTo(width)
                            make.height.lessThanOrEqualTo(scrollView.snp.height).multipliedBy(0.9).priority(10)
                            if self.isAddButton {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(5)
                                }
                            } else {
                                if count < 5 {
                                    make.width.equalTo(self.snp.width).dividedBy(count)
                                } else {
                                    make.width.equalTo(self.snp.width).dividedBy(5)
                                }
                            }
                            if tempB == nil {
                                make.left.equalTo(0)
                            } else {
                                make.left.equalTo(tempB!.snp.right)
                            }
                        })
                        tempB = button
                        if index == self.titleArray.count - 1 {
                            scrollView.snp.remakeConstraints { (make) in
                                if self.isAddButton {
                                    make.left.top.bottom.equalTo(self)
                                    make.right.equalTo(editB.snp.left)
                                } else {
                                    make.edges.equalTo(self)
                                }
                                    make.right.equalTo(button.snp.right)
                            }
                        }
                        
                    }
                }
            }
            //偷懒做法 每次都是返回都是首页
            if let tempB = self.allButtons.first {
                tempB.setTitleColor(self.tintColor, for: UIControlState.normal)
                tempB.transform = .identity
                tempB.transform = tempB.transform.scaledBy(x: 1.1, y: 1.1)
                selectedButton = tempB
                underLineV.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(self)
                    make.height.equalTo(1.5)
                    make.centerX.equalTo(tempB.snp.centerX)
                    if let title = tempB.currentTitle {
                        make.width.equalTo(title.width(font: labelFont) * 1.1 + 10)
                    } else {
                        make.width.equalTo(tempB.snp.width)
                    }
                }

            }
            self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        } else {
            self.titleArray.removeAll()
            self.allButtons.forEach({ (button) in
                button.snp.removeConstraints()
                button.removeFromSuperview()
            })
            self.allButtons.removeAll()
        }
    }
    
    /// 点击标题执行的block
    private var didClickedTitle: ((_ title: Identify, _ index: Int) -> Void)?
    
    /// 点击编辑
    private var didClickedEdit: (() -> Void)?
    
    /// 标题数组
    private var titleArray: [Identify]

    
    /// 是否添加修改按钮
    private var isAddButton: Bool = false
    
    private override init(frame: CGRect) {
        self.titleArray = [Identify]()
        super.init(frame: frame)
    }
    private init() {
        self.titleArray = [Identify]()
        super.init(frame: CGRect.zero)
    }
    
    init(titleArray: [Identify], isAddButton: Bool = false, didClickedTitle: ((_ title: Identify, _ index: Int) -> Void)?, didClickedEdit: (() -> Void)?) {
        self.titleArray = titleArray
        self.didClickedTitle = didClickedTitle
        self.isAddButton = isAddButton
        self.didClickedEdit = didClickedEdit
        super.init(frame: CGRect.zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configUI() {
        createButton()
        scrollView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    private func createButton() {
        
        self.addSubview(scrollView)
        var tempB: UIButton?
        let count = self.titleArray.count
        if count <= 0 {
            return
        }
//        var width: CGFloat = 0
//        if count < 5 {
//            if self.isAddButton {
//                width = (kMainScreenWidth - editButtonWidth) / CGFloat(count)
//            } else {
//                width = kMainScreenWidth / CGFloat(count)
//            }
//        } else {
//            if self.isAddButton {
//                width = (kMainScreenWidth - editButtonWidth) / 4
//            } else {
//                width = kMainScreenWidth / 4
//            }
//        }
        for i in 0..<count {
            let title = self.titleArray[i].identify_string
            let button = UIButton(type: UIButtonType.custom)
            self.allButtons.append(button)
            button.setTitle(title, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: labelFont)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.addTarget(self, action: #selector(TopTitleView.buttonHasClicked(sender:)), for: UIControlEvents.touchUpInside)
            button.tag = i + kButtonTag

            
            scrollView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self)
                if self.isAddButton {
                    if count < 5 {
                        make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(count)
                    } else {
                        make.width.equalTo(self.snp.width).offset(-editButtonWidth).dividedBy(5)
                    }
                } else {
                    if count < 5 {
                        make.width.equalTo(self.snp.width).dividedBy(count)
                    } else {
                        make.width.equalTo(self.snp.width).dividedBy(5)
                    }
                }
                if tempB == nil {
                    make.left.equalTo(0)
                } else {
                    make.left.equalTo(tempB!.snp.right)
                }
                make.height.lessThanOrEqualTo(scrollView.snp.height).multipliedBy(0.9).priority(10)
            })
            if i == 0 {
                self.addSubview(underLineV)
                underLineV.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(self.snp.bottom)
                    make.height.equalTo(3)
                    make.centerX.equalTo(button.snp.centerX)
                    make.width.equalTo(title.width(font: labelFont) + 10)
                })
                button.setTitleColor(self.tintColor, for: UIControlState.normal)
                button.transform = button.transform.scaledBy(x: 1.1, y: 1.1)
                selectedButton = button
            }
//            if i == count - 1 {
                tempB = button
//            }
        }
        if self.isAddButton {
            self.addSubview(editB)
            editB.snp.makeConstraints({ (make) in
                make.centerY.right.equalTo(self)
                make.width.height.equalTo(editButtonWidth)
            })
            scrollView.snp.makeConstraints { (make) in
                make.left.top.bottom.equalTo(self)
                make.right.equalTo(editB.snp.left)
                if let temp = tempB {
                    make.right.equalTo(temp.snp.right)
                }
            }
        } else {
            scrollView.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
                if let temp = tempB {
                    make.right.equalTo(temp.snp.right)
                }
            }
        }
    }
    
    //MARK: Private
    /**scrollView*/
    private lazy var scrollView: UIScrollView = {
        let object = UIScrollView()
        object.showsVerticalScrollIndicator = false
        object.showsHorizontalScrollIndicator = false
        return object
    }()
    
    /**underL*/
    private lazy var underLineV: UIView = {
        let object = UIView()
        object.backgroundColor = self.tintColor
        return object
    }()
    
    /**bottomLine*/
    private lazy var bottomLine: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return object
    }()
    
    /**修改Button*/
    private lazy var editB: UIButton = {
        let object = UIButton(type: UIButtonType.custom)
        object.setImage(UIImage.init(named: "supply_add"), for: UIControlState.normal)
//        object.backgroundColor = UIColor.colorWithHexString(hex: "e2f2fe")
        object.backgroundColor = UIColor.gray
        object.addTarget(self, action: #selector(TopTitleView.EditHasClicked(sender:)), for: UIControlEvents.touchUpInside)
        return object
    }()
    
    @objc private func EditHasClicked(sender: UIButton) {
        if let closure =  self.didClickedEdit {
            closure()
        }
    }

    
    private var allButtons: [UIButton] = [UIButton]()
    private var selectedButton: UIButton?
    
    /// 点击方法
    @objc private func buttonHasClicked(sender: UIButton) {
        if selectedButton == sender {
            return
        }
        //更改下划线和字体大小、颜色等
        if let selectedB = selectedButton {
            animations(oldButton: selectedB, newButton: sender)
        }
        selectedButton = sender
        
        //执行操作
        if let closure = self.didClickedTitle {
            let tag = sender.tag - kButtonTag
            if  tag < self.titleArray.count && tag >= 0 {
                closure(self.titleArray[sender.tag - kButtonTag], tag)
            }
        }
        
    }
    
    private func animations(oldButton: UIButton, newButton: UIButton) {
        underLineV.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(3)
            make.centerX.equalTo(newButton.snp.centerX)
            if let title = newButton.currentTitle {
                make.width.equalTo(title.width(font: labelFont) + 10)
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            oldButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            oldButton.transform = CGAffineTransform.identity
            newButton.transform = newButton.transform.scaledBy(x: 1.1, y: 1.1)
            newButton.setTitleColor(self.tintColor, for: UIControlState.normal)
            self.toSuitableLocation(newButton: newButton)
            self.layoutIfNeeded()
            }) { (flag) in
        }
    }
    
    
    private func toSuitableLocation(newButton: UIButton) {
        //点击butotn的中心点
        var offSet = newButton.center.x - self.frame.width * 0.5
        
        //最大偏移量
        var maxOffset = scrollView.contentSize.width - scrollView.frame.size.width
        if maxOffset < 0 {
            maxOffset = 0
        }
        
        if offSet > maxOffset {
            offSet = maxOffset
        } else {
            offSet = newButton.center.x - self.frame.width / 2
        }
        if offSet < 0 {
            offSet = 0
        }
        scrollView.setContentOffset(CGPoint(x: offSet, y: 0), animated: true)
        
    }
    
    override func tintColorDidChange() {
        for item in self.allButtons {
            item.setTitleColor(UIColor.black, for: UIControlState.normal)
        }
        self.selectedButton?.setTitleColor(self.tintColor, for: UIControlState.normal)
        self.underLineV.backgroundColor = self.tintColor
    }
}
