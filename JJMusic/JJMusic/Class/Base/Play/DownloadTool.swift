//
//  DownloadTool.swift
//  JJMusic
//
//  Created by coco on 16/11/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation
import AVFoundation
class DownloadTool: NSURLConnection{
    /// 请求
    fileprivate lazy var pendngRquestM: [AVAssetResourceLoadingRequest] = [AVAssetResourceLoadingRequest]()

}

extension DownloadTool: AVAssetResourceLoaderDelegate {
    
    ///1️⃣ 必须返回Yes，如果返回NO，则resourceLoader将会加载出现故障的数据,这里会出现很多个loadingRequest请求， 需要为每一次请求作出处理
    ///
    /// - parameter resourceLoader: 资源管理器
    /// - parameter loadingRequest: 每一个小块数据的请求
    ///
    /// - returns: 必须返回TRUE
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        self.pendngRquestM.append(loadingRequest)
        self.dealLoadingRequese(request: loadingRequest)
        return true
    }
    // 2️⃣
    fileprivate func dealLoadingRequese(request: AVAssetResourceLoadingRequest) {
        _ = request.request.url
    }
}
