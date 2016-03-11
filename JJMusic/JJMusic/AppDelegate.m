//
//  AppDelegate.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "LockViewController.h"
#import "LockModel.h"
#import <RongIMKit/RongIMKit.h> //融云
#import <AVFoundation/AVFoundation.h>
#import "HJLastMusicDB.h"  //数据库
#import "HJListDetailModel.h" //model
@interface AppDelegate ()<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    _playerView = [[HJPlayerView alloc] initWithFrame:CGRectMake(0, ViewH(self.window), ViewW(self.window), ViewH(self.window))];
    [self.window addSubview:self.playerView];
    
    _playerB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _playerB.frame = CGRectMake(10, ViewH(self.window) - 50 - 10, 50, 50);
    [_playerB addTarget:self action:@selector(playerViewAppear:) forControlEvents:(UIControlEventTouchUpInside)];
    [_playerB setBackgroundImage:IMAGE(@"playerHome") forState:(UIControlStateNormal)];
    [self.window addSubview:_playerB];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_playerB addGestureRecognizer:pan];
    //后台播放
    AVAudioSession *Session = [AVAudioSession sharedInstance];
    [Session setActive:YES error:nil];
    [Session setCategory:AVAudioSessionCategoryPlayback error:nil];
    XHJLog(@"%@", pathDocuments());
//    [self shareThirdParty];  //三方注册
    [self enterApp];
     return YES;
}
- (void)playerViewAppear:(UIButton *)button {
    [self.window bringSubviewToFront:self.playerView];
    [UIView animateWithDuration:0.5 animations:^{
        button.userInteractionEnabled = NO;
        _playerView.userInteractionEnabled = NO;
        _playerView.Y = 0;
    } completion:^(BOOL finished) {
        button.userInteractionEnabled = YES;
        _playerView.userInteractionEnabled = YES;
        if (_playerView.songID.length == 0) {
            //从数据库里面取
            NSArray *array = [HJLastMusicDB getLastMusic];
            if (array.count == 2) {
                _playerView.songID = array[0];
                NSArray *array1 = [NSKeyedUnarchiver unarchiveObjectWithData:array[1]];
                _playerView.content = [ListSongModel arrayOfModelsFromDictionaries:array1].mutableCopy;
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你还没有选择歌曲,是否试听推荐歌曲?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }
        }
    }];
}
//推荐歌曲
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    if (buttonIndex == 0) {
        [_playerView selfDown:nil];
    } else {
        _playerView.songID = @"1261400";
    }
}
- (void)pan:(UIPanGestureRecognizer *)pan {
    if (UIGestureRecognizerStateChanged == pan.state) {
        CGPoint point = [pan locationInView:self.window];
        if (point.x >= 25 && point.x <= ViewW(self.window) - 25 && point.y >= 25 && point.y <= ViewH(self.window) - 25) {
            //            _playerB.transform = CGAffineTransformMakeTranslation(point.x, point.y);
            _playerB.center = point;
        }
    } else if (UIGestureRecognizerStateEnded == pan.state){
        if (_playerB.center.x >= ViewW(self.window) / 2) {
            [UIView animateWithDuration:0.3 animations:^{
                _playerB.center = CGPointMake(ViewW(self.window) - 25, _playerB.center.y);
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                _playerB.center = CGPointMake(25, _playerB.center.y);
            }];
        }
    }
}
- (void)enterApp {
    if (!userDefaultGetValue(DidLoad)) {
        //第一次进入,进入导航页
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    } else {
        //非首次进入
        HomeViewController *home = [[HomeViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:home];
    }
    [self.window makeKeyAndVisible];
}
- (void)shareThirdParty {
    [[RCIM sharedRCIM] initWithAppKey:kRongYunAppKey]; //融云注册
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].currentUserInfo =[[RCUserInfo alloc] initWithUserId:@"654321" name:@"MSN" portrait:@"http://musicdata.baidu.com/data2/pic/115286282/115286282.jpg"];
    [[RCIM sharedRCIM] connectWithToken:kToken2 success:^(NSString *userId) {
//        XHJLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
//        XHJLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        XHJLog(@"token错误");
    }];
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    if ([userId isEqualToString:@"123456"]) {
        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:@"123456" name:@"城市美" portrait:@"http://musicdata.baidu.com/data2/pic/5fa9257008fe6dc86e47ac443d253235/246668443/246668443.jpg"];
        completion(user);
    } else {
//        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:@"654321" name:@"MSN" portrait:@"http://musicdata.baidu.com/data2/pic/115286282/115286282.jpg"];
//        completion(user);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([LockModel getPassword].length != 0) {
        [self showLockViewController:LockViewTypeCheck];
    }
}
- (void)showLockViewController:(LockViewType)type {
    if (self.window.rootViewController.presentingViewController == nil) {
        LockViewController *lvc = [[LockViewController alloc] initWithType:type];
        lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.window.rootViewController  presentViewController:lvc animated:YES completion:nil];
    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
