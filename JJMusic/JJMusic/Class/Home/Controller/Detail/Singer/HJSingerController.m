//
//  HJSingerController.m
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSingerController.h"
#import "HJSingleModel.h"  //单曲model
#import <UIImageView+WebCache.h>

@interface HJSingerController ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(NSMutableArray *songList);
@end

@implementation HJSingerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.songList = [NSMutableArray array];
    [self setSubView];
    [self initTableView];
    [self loadData];
    //添加上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadData];
    }];
    
}
- (void)loadData {
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    NSString *ting_uid = _singer.ting_uid;
    NSString *count = [NSString stringWithFormat:@"%lu", (unsigned long)self.songList.count];
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSingerSingleDetail(ting_uid, count) params:nil showHUD:YES inView:nil cache:YES successBlock:^(id responseObject) {
        HJSingleModel *singleModel = [[HJSingleModel alloc] initWithDictionary:responseObject error:nil];
        [self.songList addObjectsFromArray:singleModel.songlist];
        [HUDTool hideHUD];
        //结束刷新

            [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];

    } failedBlock:^(NSError *error) {
        [HUDTool hideHUD];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), ViewH(self.view)) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(ViewH(self.view) * 0.3, 0, 0, 0);
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    [button addTarget:self action:@selector(down:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tableView.tableHeaderView = button;
//    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.closeB];
}
- (void)setSubView {
    self.title = self.singer.name;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_singer.avatar_big] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //从图片中获取主色调
        self.view.backgroundColor = [HJCommonTools colorPrimaryFromImage:image];
    }];
    
    self.titleDownL.text = self.singer.name;
    self.tagL.text = STRFORMAT(@"标签:  %@", self.singer.name);
    self.descL.text = STRFORMAT(@"介绍:  %@", self.singer.country);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    HotListModel *model = _songList[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.author;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), 40)];
    label.text = STRFORMAT(@"%lu首歌曲",(unsigned long)self.songList.count);
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [getApp() playerViewAppear:nil];
    getApp().playerView.isFavoritePlayer = NO;
    getApp().playerView.songID = [self.songList[indexPath.row] song_id];
    getApp().playerView.content = self.songList;
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