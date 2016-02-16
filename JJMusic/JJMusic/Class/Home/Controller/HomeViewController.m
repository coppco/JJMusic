//
//  HomeViewController.m
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HomeViewController.h"
#import "TopTitleView.h"
#import "RecommendView.h"  //推荐
#import "RModel.h"

@interface HomeViewController ()<UIScrollViewDelegate>
HJpropertyStrong(NSMutableArray *titleArray);  //上面title数组
HJpropertyStrong(TopTitleView *topTitleView);  //上面视图
HJpropertyStrong(RecommendView *recommendV);

//集合视图
HJpropertyStrong(UIScrollView *scrollView);

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = YES;
    self.title = @"乐库";
    [self initNavigation];
    [self initTitleView];
    [self loadMusicRecommendData];
}
- (void)initNavigation {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"设置" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(gotoSetting) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)gotoSetting {
//    LockViewController *LVC = [[LockViewController alloc] initWithType:(LockViewTypeModify)];
////    [self presentViewController:LVC animated:YES completion:nil];
//    [self.navigationController pushViewController:LVC animated:YES];
}
- (void)initTitleView {
    self.titleArray = [NSMutableArray arrayWithObjects:@"推荐", @"歌单", @"榜单", @"歌手", @"电台", @"K歌", nil];
    self.topTitleView = [[TopTitleView alloc] initWithFrame:CGRectMake(0, 64, ViewW(self.view), 40) titleArray:self.titleArray];
    [self.topTitleView setButtonClick:^(NSInteger tag) {

    }];
    [self.view addSubview:self.topTitleView];
    
    //滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ViewMaxY(_topTitleView), KMainScreenWidth, KMainScreenHeight - ViewMaxY(_topTitleView))];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = ColorClear;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_titleArray.count * KMainScreenWidth, ViewW(_scrollView));
    [self.view addSubview:_scrollView];
    
    _recommendV = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, ViewH(_scrollView))];
    [_scrollView addSubview:_recommendV];
}
- (void)loadMusicRecommendData {
    [HttpHandleTool requestWithType:HJNetworkTypeGET URLString:kMusicRecommend params:CUID showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        RModel *model = [[RModel alloc] initWithDictionary:responseObject error:nil];
        _recommendV.recommend = model;
        
    } failedBlock:^(NSError *error) {
        
    }];
}

@end
