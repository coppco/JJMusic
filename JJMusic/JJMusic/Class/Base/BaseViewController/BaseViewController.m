//
//  BaseViewController.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
}
//初始化导航栏
- (void)initNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[HJCommonTools imageFromUIColor:ColorFromString(@"#FFDEAD")] forBarMetrics:(UIBarMetricsDefault)];
    _backButton.showsTouchWhenHighlighted = YES;
    _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _backButton.frame = CGRectMake(0, 0, 50, 50);
    [_backButton setImage:IMAGE(@"back") forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
