//
//  CheckNetworkStatus.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
/*
 *  检测网络状态
 */
#import <Foundation/Foundation.h>
//网络类型
typedef NS_ENUM(NSInteger, NetworkType) {
    NetworkTypeNone = 0,   //无网络  reachability和状态栏获取
    NetworkType2G,   //2G   状态栏获取
    NetworkType3G,   //3G   状态栏获取
    NetworkType4G,   //4G   状态栏获取
    NetworkType5G,   //5G, 预留不存在    状态栏获取
    NetworkTypeWIFI,   //WIFI      reachability和状态栏获取
    NetworkTypeCellular  //蜂窝网络    reachability获取
};
//回调block
typedef void(^networkCallBack)(NetworkType networkType);

@interface CheckNetworkStatus : NSObject
HJpropertyCopy(networkCallBack network);  //回调block
#pragma mark - 对网络状态实时监控
/**
 *  可以对网络实现实时监控, 最好使用实例变量
 *
 *  @param networkCallBack 状态改变的时候的回调函数
 *
 */
- (instancetype)initWithNetworkCallBack:(networkCallBack)networkCallBack;

#pragma mark - 获取当前网络状态
/**
 *  从状态栏获取网络状态,如果状态栏隐藏则从reachability获取
 *
 *  @return 返回网络类型
 */
+ (NetworkType)getCurrentNetworkFromStatusBar;
/**
 *  从reachability获取网络状态:无网络、WIFI和蜂窝网络
 *
 *  @return 返回网络类型
 */
+ (NetworkType)getCurrentNetworkFromReachability;
@end
