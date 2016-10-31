//
//  TopTitleView.swift
//  RSS_Message
//
//  Created by coco on 16/10/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

private let labelFont: CGFloat = 15
private let kButtonTag: Int = 9909
class TopTitleView: UIView {
    
    func shouldScrollToCurrentLocation(index: Int) {
        if let oldB = self.selectedButton, let newB = self.viewWithTag(index + kButtonTag) as? UIButton, oldB != newB {
            self.animations(oldButton: oldB, newButton: newB)
            self.selectedButton = newB
        }
    }
    
    private var didClickedTitle: ((_ title: String, _ index: Int) -> Void)?
    private var titleArray: [String]
    
    private override init(frame: CGRect) {
        self.titleArray = [String]()
        super.init(frame: frame)
    }
    
    init(titleArray: [String], didClickedTitle: ((_ title: String, _ index: Int) -> Void)?) {
        self.titleArray = titleArray
        self.didClickedTitle = didClickedTitle
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
        var width: CGFloat = 0
        if count < 5 {
            width = kMainScreenWidth / CGFloat(count)
        } else {
            width = kMainScreenWidth / 4
        }
        for i in 0..<count {
            let title = self.titleArray[i]
            let button = UIButton(type: UIButtonType.custom)
            self.allButtons.append(button)
            button.setTitle(title, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: labelFont)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.addTarget(self, action: #selector(TopTitleView.buttonHasClicked(sender:)), for: UIControlEvents.touchUpInside)
            button.tag = i + kButtonTag
            
            scrollView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.snp.centerY)
                make.left.equalTo(width * CGFloat(i))
                make.width.equalTo(width)
                make.height.lessThanOrEqualTo(self.snp.height).multipliedBy(0.9).priority(10)
            })
            if i == 0 {
                self.addSubview(underLineV)
                underLineV.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(self)
                    make.height.equalTo(1.5)
                    make.centerX.equalTo(button.snp.centerX)
                    make.width.equalTo(title.width(font: labelFont) + 10)
                })
                button.setTitleColor(navigationColor, for: UIControlState.normal)
                button.transform = button.transform.scaledBy(x: 1.1, y: 1.1)
                selectedButton = button
            }
            if i == count - 1 {
                tempB = button
            }
        }
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            if let temp = tempB {
                make.right.equalTo(temp.snp.right)
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
        object.backgroundColor = navigationColor
        return object
    }()
    
    /**bottomLine*/
    private lazy var bottomLine: UIView = {
        let object = UIView()
        object.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return object
    }()
    
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
            make.bottom.equalTo(self)
            make.height.equalTo(1.5)
            make.centerX.equalTo(newButton.snp.centerX)
            if let title = newButton.currentTitle {
                make.width.equalTo(title.width(font: labelFont) + 10)
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            oldButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            oldButton.transform = CGAffineTransform.identity
            newButton.transform = newButton.transform.scaledBy(x: 1.1, y: 1.1)
            newButton.setTitleColor(navigationColor, for: UIControlState.normal)
            self.toSuitableLocation(newButton: newButton)
            self.layoutIfNeeded()
            }) { (flag) in
        }
    }
    
    
    private func toSuitableLocation(newButton: UIButton) {
        //点击butotn的中心点
        var offSet = newButton.centerX - self.frame.width * 0.5
        
        //最大偏移量
        var maxOffset = scrollView.contentSize.width - scrollView.frame.size.width
        if maxOffset < 0 {
            maxOffset = 0
        }
        
        if offSet > maxOffset {
            offSet = maxOffset
        } else {
            offSet = newButton.centerX - self.frame.width / 2
        }
        if offSet < 0 {
            offSet = 0
        }
        scrollView.setContentOffset(CGPoint(x: offSet, y: 0), animated: true)
        
    }
}
