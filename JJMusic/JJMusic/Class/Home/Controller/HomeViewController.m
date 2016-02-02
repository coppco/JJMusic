//
//  HomeViewController.m
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HomeViewController.h"
#import "TopTitleView.h"
@interface HomeViewController ()
HJpropertyStrong(NSMutableArray *titleArray);  //上面title数组
HJpropertyStrong(TopTitleView *topTitleView);  //上面视图
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = YES;
    self.title = @"乐库";
    [self initTitleView];
    [self loadMusicRecommendData];
    // Do any additional setup after loading the view.
}
- (void)initTitleView {
    self.titleArray = [NSMutableArray arrayWithObjects:@"推荐", @"歌单", @"榜单", @"歌手", @"电台", @"K歌", nil];
    self.topTitleView = [[TopTitleView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), 40) titleArray:self.titleArray];
    [self.view addSubview:self.topTitleView];
}
- (void)loadMusicRecommendData {
//    NSDictionary *dic = @{@"method":@"baidu.ting.plaza.index", @"version":@"5.5.4", @"from":@"ios", @"channel":@"appstore", @"operator":@"0"};
//    method=baidu.ting.plaza.index&version=5.5.4&from=ios&channel=appstore&operator=0
    [HttpHandleTool requestWithType:HJNetworkTypeGET URLString:kMusicRecommend params:nil showHUD:NO inView:nil successBlock:^(id responseObject) {
        
    } failedBlock:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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