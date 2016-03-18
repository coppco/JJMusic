//
//  HJSearchSingerController.m
//  JJMusic
//
//  Created by coco on 16/3/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSearchSingerController.h"
#import "SingerModel.h"  //歌手信息
#import <UIImageView+WebCache.h>
#import "HJSelectView.h"
#import "HJSingerController.h"  //歌手详情页面

@interface HJSearchSingerController ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(UITableView *tableView);  //表视图
HJpropertyStrong(NSMutableArray *artist); //歌手列表
HJpropertyStrong(HJSelectView *selectView);  //选择视图
HJpropertyCopy(NSString *headTitle);  //表头标题
HJpropertyStrong(ErrorTipsView *errorView);  //错误视图
@end

@implementation HJSearchSingerController
- (void)setIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        _indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:6];
    } else if (indexPath.section == 2) {
        _indexPath = [NSIndexPath indexPathForRow:indexPath.row +1 inSection:3];
    } else if (indexPath.section == 3) {
        _indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:7];
    } else if (indexPath.section == 4) {
        _indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:60];
    } else if (indexPath.section == 5) {
        _indexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:5];
    }
}
- (HJSelectView *)selectView {
    if (_selectView == nil) {
        _selectView = [[HJSelectView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _selectView.alpha = 0;
        WeakSelf(myWeak);
        [_selectView setClicked:^(NSString *title) {
            myWeak.artist = [NSMutableArray array];
            myWeak.headTitle  = title;
            [myWeak loadData];
        }];
        [self.view addSubview:_selectView];
    }
    return _selectView;
}
- (ErrorTipsView *)errorView {
    if (_errorView == nil) {
        _errorView = [[ErrorTipsView alloc] initWithFrame:self.view.bounds title:@"提示" subTitle:@"没有查询到歌手信息" image:@"NoData" btnTitle:@"点击重新选择" btnClick:^(id object) {
            
            [self selectCategory:nil];
        }];
        _errorView.alpha = 0;
        [self.view addSubview:_errorView];
    }
    return _errorView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.artist = [NSMutableArray array];
    self.headTitle = @"热门";
    [self initRightButton];
    [self initTableView];
    [self loadData];
}

- (void)initRightButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.size = CGSizeMake(30, 30);
    [button addTarget:self action:@selector(selectCategory:) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:IMAGE(@"singer_white_paixu") forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)selectCategory:(UIButton *)button {
    [self.view bringSubviewToFront:self.selectView];
    if (self.selectView.alpha) {
        [HJCommonTools animationCATransitionForView:self.selectView duration:0.2 type:(HJAnimationTypePageCurl) direction:(DirectionTypeTop)];
        self.selectView.alpha = 0 ;
    } else {
        self.selectView.alpha =1 ;
        [HJCommonTools animationCATransitionForView:self.selectView duration:0.2 type:(HJAnimationTypePageUnCurl) direction:(DirectionTypeBottom)];
    }
}
//加载数据
- (void)loadData {
    self.errorView.alpha = 0;
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    NSString *count = [NSString stringWithFormat:@"%lu", (unsigned long)self.artist.count];
    NSString *area = [NSString stringWithFormat:@"%ld", (long)_indexPath.section];
    NSString *sex = [NSString stringWithFormat:@"%ld", (long)_indexPath.row];
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSingerSearch(count, area, sex, self.headTitle) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        [HUDTool hideHUD];
        [self.tableView.mj_footer endRefreshing];
        NSArray *artist = [SingerModel arrayOfModelsFromDictionaries:responseObject[@"artist"]];
        [self.artist addObjectsFromArray:artist];
        if (0 != self.artist.count) {
            self.errorView.alpha = 0;
            [self.tableView reloadData];
        } else {
            self.errorView.alpha = 1;
        }
    } failedBlock:^(NSError *error) {
        [HUDTool hideHUD];
         [self.tableView.mj_footer endRefreshing];
        self.errorView.alpha = 1;
    }];
}
//加载数据
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), ViewH(self.view)) style:(UITableViewStylePlain)];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.view addSubview:_tableView];
    [self.view bringSubviewToFront:self.selectView];
}
#pragma mark - UITableViewDataSource 和 UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _artist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SingerModel *model = _artist[indexPath.row];
    cell.imageView.layer.cornerRadius = 10;
    cell.imageView.layer.masksToBounds = YES;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_middle] placeholderImage:IMAGE(@"placeHold")];
    cell.textLabel.text = model.name;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.headTitle;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJSingerController *singetVC = [[HJSingerController alloc] init];
    singetVC.singer = self.artist[indexPath.row];
    [self.navigationController pushViewController:singetVC animated:YES];
}
@end
