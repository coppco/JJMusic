//
//  CheckNetworkStatus.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "CheckNetworkStatus.h"
#import "Reachability.h"

@interface CheckNetworkStatus ()
HJpropertyStrong(Reachability *reachability);  //网络监听
@end

@implementation CheckNetworkStatus
- (void)dealloc {
    self.reachability = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithNetworkCallBack:(networkCallBack)networkCallBack {
    self = [super init];
    if (self) {
        self.network = networkCallBack;
        [self beginCheckNetwork];
    }
    return self;
}
- (void)beginCheckNetwork {
    //添加观察者监控网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reachability startNotifier];
}
- (void)networkChanged:(NSNotification *)note  {
    if (self.network) {
        self.network([[self class] getCurrentNetworkFromReachability]);
    }
}
//从状态栏中获取网络状态
+ (NetworkType)getCurrentNetworkFromStatusBar {
    UIApplication *app = [UIApplication sharedApplication];
    if (!app.statusBarHidden) {
        NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
        NSNumber *dataNetworkItemView = nil;
        for (id subview in subviews) {
            if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                dataNetworkItemView = subview;
                break;
            }
        }
        NSInteger num = [[dataNetworkItemView valueForKey:@"dataNetworkType"] integerValue];
        // num = 0  无网络
        //     = 1  2G
        //     = 2  3G
        //     = 3  4G
        //     = 4  5G   暂不存在
        //     = 5  WIFI
        return num;
    } else {
        return [self getCurrentNetworkFromReachability];
    }
}
//从reachability获取网络状态:无网络、WIFI和蜂窝网络
+ (NetworkType)getCurrentNetworkFromReachability {
    Reachability *curReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [curReach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            return NetworkTypeNone;
            break;
        case ReachableViaWiFi:
            return NetworkTypeWIFI;
            break;
        case ReachableViaWWAN:
            return NetworkTypeCellular;
            break;
    }
}
@end
