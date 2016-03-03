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

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
