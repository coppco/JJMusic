//
//  HJListViewController.m
//  JJMusic
//
//  Created by coco on 16/3/3.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJListViewController.h"
#import "RModel.h"
#import "DiyModel.h"  //歌单推荐model
#import <UIImageView+WebCache.h>
#import "HJListDetailModel.h"  //model
#import "HJSongModel.h"  //歌曲信息
#import "HJFavoriteListDB.h"  //数据库
@interface HJListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HJListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    if (self.list_id.length != 0) {
        [self loadListData];  //加载数据
    }
    if (nil != self.detailModel) {
        [self initTableView];
        [self setSubView];
    }
}
- (void)setSubView {
    self.title = self.detailModel.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_detailModel.pic_w700] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //从图片中获取主色调
            self.view.backgroundColor = [HJCommonTools colorPrimaryFromImage:image];
    }];
    self.titleDownL.text = self.detailModel.title;
    self.tagL.text = STRFORMAT(@"标签:  %@", self.detailModel.tag);
    self.descL.text = STRFORMAT(@"介绍:  %@", self.detailModel.desc);
}
- (void)loadListData {
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kMusicListDetail(_list_id) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        [HUDTool hideHUD];
        self.detailModel = [[HJListDetailModel alloc] initWithDictionary:responseObject error:nil];
        if (self.detailModel) {
            [self initTableView];
            [self setSubView];
        } else {
            
        }
    } failedBlock:^(NSError *error) {
        [HUDTool hideHUD];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY >= -64) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailModel.content.count;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return STRFORMAT(@"%lu首歌曲",(unsigned long)self.detailModel.content.count);
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    label.text = STRFORMAT(@"%lu首歌曲",(unsigned long)self.detailModel.content.count);
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button addTarget:self action:@selector(favorite:) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:IMAGE(@"favorite_list") forState:(UIControlStateSelected)];
    [button setBackgroundImage:IMAGE(@"favorite_list_cancel") forState:(UIControlStateNormal)];
    button.frame = CGRectMake(self.view.width - 30 - 10, 0, 30, 30);
    if (0 != self.list_id.length) {
        if ([HJFavoriteListDB isFavorite:self.list_id]) {
            button.selected = YES;
        }
    } else {
        if ([HJFavoriteListDB isFavorite:self.detailModel.listid]) {
            button.selected = YES;
        }
    }
    [view addSubview:button];
    [view addSubview:label];
    return view;
}
- (void)favorite:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        //收藏操作
        //添加到数据库
        [HJFavoriteListDB addOneList:self.detailModel];
        [HUDTool showTextTipsHUDWithTitle:@"收藏成功" delay:0.6];
    } else {
        //取消收藏
        [HJFavoriteListDB deleteOneList:self.detailModel.listid];
        [HUDTool showTextTipsHUDWithTitle:@"取消收藏" delay:0.6];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    cell.textLabel.text = [self.detailModel.content[indexPath.row] title];
    cell.detailTextLabel.text = [self.detailModel.content[indexPath.row] author];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [getApp() playerViewAppear:nil];
    getApp().playerView.isFavoritePlayer = NO;
    getApp().playerView.songID = [self.detailModel.content[indexPath.row] song_id];
    getApp().playerView.content = self.detailModel.content;
}
@end
