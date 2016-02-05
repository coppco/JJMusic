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
    //设置导航栏背景颜色
    //方法1⃣️  有点问题. controller.view的frame
//        [self.navigationController.navigationBar setBackgroundImage:[HJCommonTools imageFromUIColor:ColorFromString(@"#FFDEAD")] forBarMetrics:(UIBarMetricsDefault)];
//    self.navigationController.navigationBar.translucent = NO;  //设置导航栏不透明
    //方法2⃣️  有导航栏Y需要增加64
    self.navigationController.navigationBar.barTintColor = ColorFromString(@"#FFDEAD");
    
    
    //去掉导航条分割线
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //设置导航栏标题字体和颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    

    _backButton.showsTouchWhenHighlighted = YES;
    _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _backButton.frame = CGRectMake(0, 0, 50, 50);
    [_backButton addTarget:self action:@selector(close:) forControlEvents:(UIControlEventTouchUpInside)];
    [_backButton setImage:IMAGE(@"back") forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
}
//返回
- (void)close:(UIButton *)button {
    //判断模态还是push过来的,模态过来的controller不会放在self.navigationController.viewControllers数组中
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
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
