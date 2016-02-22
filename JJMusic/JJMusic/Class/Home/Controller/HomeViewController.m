//
//  HomeViewController.m
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HomeViewController.h"
#import "LockViewController.h"  //手势锁
#import <RongIMKit/RongIMKit.h>  //融云

#import "TopTitleView.h"
#import "RecommendView.h"  //推荐
#import "RModel.h"

#import "AllDiyView.h"  //歌单
#import "DiyModel.h"

#import "MusicListView.h" //榜单
#import "MuiscList.h"

#import "SingerView.h"//歌手
#import "SingerModel.h"

#import "RadioView.h" //电台
#import "LeboModel.h"
#import "RedRadio.h"

#import "KSongView.h" //K歌
#import "KSong.h"
#import "KPeople.h"
@interface HomeViewController ()<UIScrollViewDelegate>
HJpropertyStrong(NSMutableArray *titleArray);  //上面title数组
HJpropertyStrong(TopTitleView *topTitleView);  //上面视图
HJpropertyStrong(RecommendView *recommendV);  //推荐
HJpropertyStrong(AllDiyView *allDiyView);  //歌单
HJpropertyStrong(MusicListView *musicListView);  //榜单
HJpropertyStrong(SingerView *singerView);  //歌手
HJpropertyStrong(RadioView *radioView);  //电台
HJpropertyStrong(KSongView *kSongView);  //K歌
//滚动视图
HJpropertyStrong(UIScrollView *scrollView);

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = YES;
    self.title = @"乐库";
    [self initNavigation];
    [self initTitleView];
}
- (void)initNavigation {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"设置" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(gotoSetting) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)gotoSetting {
//    LockViewController *LVC = [[LockViewController alloc] initWithType:(LockViewTypeCreate)];
////    [self presentViewController:LVC animated:YES completion:nil];
//    [self.navigationController pushViewController:LVC animated:YES];
    
    //启用聊天界面
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"123456";
    //设置聊天会话界面要显示的标题
    chat.title = @"与城市美聊天";
    
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)initTitleView {
    self.titleArray = [NSMutableArray arrayWithObjects:@"推荐", @"歌单", @"榜单", @"歌手", @"电台", @"K歌", nil];
    self.topTitleView = [[TopTitleView alloc] initWithFrame:CGRectMake(0, 64, ViewW(self.view), 40) titleArray:self.titleArray];
    WeakSelf(weak);
    [self.topTitleView setButtonClick:^(NSInteger tag) {
        [weak.scrollView setContentOffset:CGPointMake((tag - 9980) * weak.scrollView.frame.size.width, 0) animated:YES];
        [weak refreshData:tag - 9980];
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
    //下拉刷新
    _recommendV.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadMusicRecommendData];
    }];
    //主动进入刷新状态
    [_recommendV.tableView.mj_header beginRefreshing];
    
    _allDiyView = [[AllDiyView alloc] initWithFrame:CGRectMake(KMainScreenWidth, 0, KMainScreenWidth, ViewH(_scrollView))];
    //下拉刷新
    _allDiyView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadListData];
    }];
    [_scrollView addSubview:_allDiyView];
    
    _musicListView = [[MusicListView alloc] initWithFrame:CGRectMake(KMainScreenWidth * 2, 0, KMainScreenWidth, ViewH(_scrollView))];
    //下拉刷新
    _musicListView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadMusicListData];
    }];
    [_scrollView addSubview:_musicListView];
    
    _singerView = [[SingerView alloc] initWithFrame:CGRectMake(KMainScreenWidth * 3, 0, KMainScreenWidth, ViewH(_scrollView))];
    //下拉刷新
    _singerView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadSingerData];
    }];
    [_scrollView addSubview:_singerView];
    
    _radioView = [[RadioView alloc] initWithFrame:CGRectMake(KMainScreenWidth * 4, 0, KMainScreenWidth, ViewH(_scrollView))];
    //下拉刷新
    _radioView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRadioData];
    }];
    [_scrollView addSubview:_radioView];
    
    _kSongView = [[KSongView alloc] initWithFrame:CGRectMake(KMainScreenWidth * 5, 0, KMainScreenWidth, ViewH(_scrollView))];
    //下拉刷新
    _kSongView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadKSongData];
    }];
    [_scrollView addSubview:_kSongView];
}
- (void)refreshData:(NSInteger)tag {
    WeakSelf(weak);
    if (tag == 0) {
        if (weak.recommendV.recommend == nil) {
            [weak.recommendV.tableView.mj_header beginRefreshing];
        }
    }
    if (tag == 1) {
        if (weak.allDiyView.array.count == 0) {
            [weak.allDiyView.collectionView.mj_header beginRefreshing];
        }
    }
    if (tag == 2) {
        if (weak.musicListView.array.count == 0) {
            [weak.musicListView.collectionView.mj_header beginRefreshing];
        }
    }
    if (tag  == 3) {
        if (weak.singerView.array.count == 0) {
            [weak.singerView.tableView.mj_header beginRefreshing];
        }
    }
    if (tag  == 4) {
        if (!_radioView.isLoad) {
            [weak.radioView.collectionView.mj_header beginRefreshing];
        }
    }
    if (tag == 5) {
        if (_kSongView.array.count == 0) {
            [weak.kSongView.tableView.mj_header beginRefreshing];
        }
    }
}
#pragma mark - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滚动了
    NSInteger page = scrollView.contentOffset.x / ViewW(scrollView);
    UIButton *button = [_topTitleView viewWithTag:9980 + page];
    [_topTitleView buttonHasClick:button];
}
//获取推荐页面数据
- (void)loadMusicRecommendData {
    [HttpHandleTool requestWithType:HJNetworkTypeGET URLString:kMusicRecommend params:CUID showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        RModel *model = [[RModel alloc] initWithDictionary:responseObject error:nil];
        _recommendV.recommend = model;
        
        //结束刷新状态
        [_recommendV.tableView.mj_header endRefreshing];
        
    } failedBlock:^(NSError *error) {
        //结束刷新状态
        [_recommendV.tableView.mj_header endRefreshing];
    }];
}
//获取歌单数据
- (void)loadListData {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSongList params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        NSArray *array = [DiyModel arrayOfModelsFromDictionaries:responseObject[@"content"]];
        
        _allDiyView.array = array;
        
        //结束刷新
        [_allDiyView.collectionView.mj_header endRefreshing];
    } failedBlock:^(NSError *error) {
        //结束刷新
        [_allDiyView.collectionView.mj_header endRefreshing];
    }];
}

//获取榜单数据
- (void)loadMusicListData {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kMusicList params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        NSArray *array = [MuiscList arrayOfModelsFromDictionaries:responseObject[@"content"]];
        _musicListView.array = array;
        //结束刷新
        [_musicListView.collectionView.mj_header endRefreshing];
    } failedBlock:^(NSError *error) {
        //结束刷新
        [_musicListView.collectionView.mj_header endRefreshing];
    }];
}

//获取歌手信息
- (void)loadSingerData {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSinger params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        NSArray *array = [SingerModel arrayOfModelsFromDictionaries:responseObject[@"artist"]];
        _singerView.array = array;
        //结束刷新
        [_singerView.tableView.mj_header endRefreshing];
    } failedBlock:^(NSError *error) {
        //结束刷新
        [_singerView.tableView.mj_header endRefreshing];
    }];
}

//获取电台数据
- (void)loadRadioData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kRedRadio params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
            _radioView.isLoad = YES;
            _radioView.redRadioArray = [RedRadio arrayOfModelsFromDictionaries:responseObject[@"result"][@"list"]];
            
            //结束刷新
            [_radioView.collectionView.mj_header endRefreshing];
        } failedBlock:^(NSError *error) {
            //结束刷新
            [_radioView.collectionView.mj_header endRefreshing];
        }];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kLeBo params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
            _radioView.isLoad = YES;
            _radioView.leBoArray = [LeboModel arrayOfModelsFromDictionaries:responseObject[@"result"][@"taglist"]];
            //结束刷新
            [_radioView.collectionView.mj_header endRefreshing];
        } failedBlock:^(NSError *error) {
            //结束刷新
            [_radioView.collectionView.mj_header endRefreshing];
        }];
    });
}

//获取K歌数据
- (void)loadKSongData {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kPeopleMusic params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        _kSongView.array = [KPeople arrayOfModelsFromDictionaries:responseObject[@"result"][@"items"]];
        //结束刷新
        [_kSongView.tableView.mj_header endRefreshing];
    } failedBlock:^(NSError *error) {
        //结束刷新
        [_kSongView.tableView.mj_header endRefreshing];
    }];
}
@end






