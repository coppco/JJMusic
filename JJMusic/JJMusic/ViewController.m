//
//  ViewController.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HUDTool.h"
#import "MulticolorView.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [session GET:@"http://yinyueshiting.baidu.com/data2/music/42491191/42491191.mp3?xcode=26802dd9d19d6ce32a1779a2a81a9c08" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        NSString *_tempPath = pathDocumentsFileName(@"111.mp3");
        if ([[NSFileManager defaultManager] fileExistsAtPath:_tempPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
            
        } else {
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
        }
        
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:_tempPath];
        
        [handle writeData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
//    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:@"http://yinyueshiting.baidu.com/data2/music/42491191/42491191.mp3?xcode=26802dd9d19d6ce32a1779a2a81a9c08" params:nil showHUD:NO inView:nil cache:NO successBlock:^(id responseObject) {
//        XHJLog(@"成功");
//    } failedBlock:^(NSError *error) {
//        XHJLog(@"失败");
//    }];
//    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    button1.frame = CGRectMake(50, 250, 50, 50);
//    [button1 setTitle:@"测试" forState:(UIControlStateNormal)];
//    [button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [self.view addSubview:button1];
//    
//    [button1 addTarget:self action:@selector(hehe1) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    button.frame = CGRectMake(50, 450, 50, 50);
//    [button setTitle:@"测试" forState:(UIControlStateNormal)];
//    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [self.view addSubview:button];
//    
//    [button addTarget:self action:@selector(hehe) forControlEvents:(UIControlEventTouchUpInside)];
//    MulticolorView *view = [[MulticolorView alloc] initWithFrame:CGRectMake(50, 550, 40, 40)];
//    [view startAnimation];
//    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)hehe1 {
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    [self performSelector:@selector(hhhhhh) withObject:nil afterDelay:4];
}
- (void)hehe {
    [HUDTool showCustomSmileViewWithTitle:@"微笑" delay:2];
}
- (void)hhhhhh {
    [HUDTool hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
