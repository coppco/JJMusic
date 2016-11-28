//
//  AppDelegate.swift
//  JJMusic
//
//  Created by coco on 16/10/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var playBottomView: AppBottomView = {
        let object = AppBottomView.shared
        return object
    }()

    internal lazy var playerView: PlayerView = {
        return PlayerView.shared
    }()

    /// 监控网络状态
    var manger: NetworkReachabilityManager? = {
        let object = NetworkReachabilityManager(host: "http://www.baidu.com")
        return object
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MyNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        window?.addSubview(playBottomView)
        //设置这个 然后图片渲染模式为alwaysTemplate, 那么之控件的颜色都是这个颜色
        window?.tintColor = navigationColor
        playBottomView.snp.makeConstraints {[unowned self] (make) in
            make.right.left.bottom.equalTo(self.window!)
            make.height.equalTo(44)
        }
        self.playerView.frame = CGRect(x: 0, y: kMainScreenHeight, width: kMainScreenWidth, height: kMainScreenHeight)
        window?.addSubview(self.playerView)
        setBackPlay()
        observeNetworking()
        return true
    }
    /// 监听网络变化
    private func observeNetworking() {
        self.manger?.listener = { status in
            print(status)
            switch status {
            case .notReachable:  //无网络状态
                PromptView.show(message: "网络似乎已经断开, 请检测网络")
                break
            case .unknown:  //未知
                PromptView.show(message: "未知网络,请检查网络状态")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):  //WIFI
                PromptView.show(message: "当前网络状态为WIFI")
                break
            case .reachable(NetworkReachabilityManager.ConnectionType.wwan): //2G/3G/4G
                PromptView.show(imageName: "bt_home_login_normal", message: "当前网络状态是2G/3G/4G")
                break
            }
        }
        self.manger?.startListening()
    }
    
    /// 设置后台播放, 必须设置不然没声音
    private func setBackPlay() {
        //target ---> Capabilities ---> Background Models 勾选第一项
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayback, with: [AVAudioSessionCategoryOptions.allowBluetooth, AVAudioSessionCategoryOptions.mixWithOthers])
        try? session.setActive(true)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        //可以接受远程控制
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //取消远程控制
        UIApplication.shared.endReceivingRemoteControlEvents()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        ImageCache.default.clearMemoryCache()
        PromptView.show(message: "收到内存警告了")
    }

    override func remoteControlReceived(with event: UIEvent?) {
        
    }

}

