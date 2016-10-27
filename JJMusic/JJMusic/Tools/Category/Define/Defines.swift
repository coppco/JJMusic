//
//  Defines.swift
//  Swift3
//
//  Created by coco on 16/10/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import UIKit

/*
 OS_ACTIVITY_MODE disable   
 -D DEBUG
 添加桥接文件header   #import <CommonCrypto/CommonHMAC.h>
 */

/// 全局代理
let appDelegate = UIApplication.shared.delegate as! AppDelegate

/// 主屏幕
let kMainScreen = UIScreen.main

/// 主屏幕bounds
let kMainScreenBounds = kMainScreen.bounds

/// 主屏幕size
let kMainScreenSize = kMainScreenBounds.size

/// 主屏幕width
let kMainScreenWidth = kMainScreenSize.width

/// 主屏幕height
let kMainScreenHeight = kMainScreenSize.height

/// document路径
///
/// - returns: 返回一个字符串路径
func documentsPath() -> String {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
}


/// document文件夹下面拼接文件名称
///
/// - parameter fileName: 文件名称
///
/// - returns: 返回字符串路径
func filePathInDocumentsDirectory(fileName: String) -> String {
    return documentsPath().appending("/\(fileName)")
}

/// document文件夹下面创建子文件夹, 子文件下面存放文件名称
///
/// - parameter subPath:  子文件夹
/// - parameter fileName: 文件名称
///
/// - returns: 返回字符串路径
func fileInSubDirectoryOfDocumentsDirectory(subPath: String, fileName: String) -> String {
    let path = filePathInDocumentsDirectory(fileName: subPath)
    if !FileManager.default.fileExists(atPath: path) { //不存在就创建文件夹
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("createDirectory failed at path: \(path) error: \(error.localizedDescription)")
        }
    }
//    return path.appending("/\(fileName)")
    return URL(string: path)!.appendingPathComponent(fileName).absoluteString
}

/// document链接
///
/// - returns: 返回一个URL
func documentsURL() -> URL {
    return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
}

/// 缓存路径
///
/// - returns: 返回一个字符串
func cachesPath() -> String {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
}

/// 缓存链接
///
/// - returns: 返回一个URL
func cachesURL() -> URL {
    return FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
}

/// library路径
///
/// - returns: 返回一个字符串
func libraryPath() -> String {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
}
/// library链接
///
/// - returns: 返回一个URL
func libraryURL() -> URL {
    return FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
}

/// 应用程序包名字
///
/// - returns: 返回一个字符串
func appBundleName() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
}

/// 应用程序标识
///
/// - returns: 返回一个字符串
func appBundleID() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
}

/// 应用程序版本 Version
///
/// - returns: 返回一个字符串
func appVersion() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}

/// 应用程序构建版本  Build 更新即增加的数字
///
/// - returns: 返回一个字符串
func appBuildVersion() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
}


//判断数组是否为空
public func ArrayIsNull(_ array:[AnyObject]?) ->Bool{
    if array?.count == 0 || array == nil {
        return true
    }
    return false
}


//将时间戳转化为日期/时间
public func TransToTimeStamp(time:NSNumber?,format:String) -> String{
    let timeStampString = time
    let _interval = timeStampString?.doubleValue
    let dateForm = NSDate.init(timeIntervalSince1970: _interval!)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateFormat = format
    let currentStr = dateFormatter.string(from: dateForm as Date)
    return currentStr
}


/// 自定义打印
/// - 需要在Build Setting --->  custom flags ---> Other Swift Flags ---->  Debug 里面添加-D DEBUG, 当发布release版本的时候不会打印, DEBUG模式才会输出!
/// - parameter items:        需要打印的参数
/// - parameter fileName:     文件名
/// - parameter functionName: 方法名
/// - parameter lineNumber:   行数
func HHLog(_ items: Any..., fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        var string = "时间: \(Date().stringForDateWithSQLDataFormatter()) 文件:\((fileName as NSString).lastPathComponent) 方法:\(functionName) [\(lineNumber)行] "
        for item in items {
            string.append(" \(item)")
        }
        print(string)
    #endif
}
