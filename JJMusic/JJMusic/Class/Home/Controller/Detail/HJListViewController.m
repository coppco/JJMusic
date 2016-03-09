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

@interface HJListViewController ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(UIImageView *)imageV;  //上方图片
HJpropertyStrong(UIButton *closeB);  //返回按钮
HJpropertyStrong(UITableView *tableView);

HJpropertyStrong(UILabel *titleUpL);  //上面的标题

//下面的几个label
HJpropertyStrong(UILabel *titleDownL);  //标题
HJpropertyStrong(UILabel *tagL);  //标签
HJpropertyStrong(UILabel *descL); //介绍
HJpropertyStrong(HJListDetailModel * detailModel);
@end

@implementation HJListViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated {
    //super写在后面
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
- (NSString *)getValueForKey:(NSString *)key {
    SEL sel = NSSelectorFromString(key); //获取引用方法  getter方法
    if ([_model respondsToSelector:sel]) {
        return [_model performSelector:sel]; //获取对象值
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = [self getValueForKey:@"title"];
    [self initSubView];
    [self loadListData];  //加载数据
}
- (void)initSubView {
    self.imageV = [[UIImageView alloc] init];
    [self.view addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self.view), ViewH(self.view) * 0.6));
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.imageV.contentMode = UIViewContentModeScaleToFill;
    NSString *urlString = nil;
    if ([_model isKindOfClass:[Diy class]]) {
        urlString = [self getValueForKey:@"pic"];
    } else if ([_model isKindOfClass:[DiyModel class]]) {
        urlString = [self getValueForKey:@"pic_w300"];
    }
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //从图片中获取主色调
        self.view.backgroundColor = [HJCommonTools colorPrimaryFromImage:image];
    }];
    
    //标题  标签  说明
    _titleDownL = [[UILabel alloc] init];
    _titleDownL.text = [self getValueForKey:@"title"];
    _titleDownL.textColor = [UIColor whiteColor];
    [_titleDownL sizeToFit];
    [self.view addSubview:_titleDownL];
    [_titleDownL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(20);
        make.left.equalTo(self.imageV.mas_left).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    _tagL = [[UILabel alloc] init];
    _tagL.font = font(13);
    _tagL.numberOfLines = 0;
    _tagL.textColor = [UIColor whiteColor];
    _tagL.text = STRFORMAT(@"标签:   %@",[self getValueForKey:@"tag"]);
   
    [self.view addSubview:_tagL];
    [_tagL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(60);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        [_tagL sizeToFit];
    }];
    
    _descL = [[UILabel alloc] init];
    _descL.numberOfLines = 0;
    [self.view addSubview:_descL];
    _descL.textColor = [UIColor whiteColor];
    _descL.font = font(13);
    _descL.text = STRFORMAT(@"介绍:   %@", [self getValueForKey:@"desc"]);
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagL.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        [_descL sizeToFit];
    }];
    _closeB.showsTouchWhenHighlighted = YES;
    _closeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _closeB.frame = CGRectMake(10, 25, 50, 50);
    [_closeB addTarget:self action:@selector(close:) forControlEvents:(UIControlEventTouchUpInside)];
    [_closeB setImage:IMAGE(@"back") forState:(UIControlStateNormal)];
    [self.view addSubview:self.closeB];
}
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), ViewH(self.view)) style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(ViewH(self.view) * 0.3, 0, 0, 0);
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    [button addTarget:self action:@selector(down:) forControlEvents:(UIControlEventTouchUpInside)];
    _tableView.tableHeaderView = button;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [self.view bringSubviewToFront:_closeB];
}
- (void)down:(UIButton *)button {
    if (button.selected == NO) {
        [self.tableView setContentOffset:CGPointMake(0, -(ViewH(self.view) - 60)) animated:YES];
        
        button.selected = YES;
    } else {
        [self.tableView setContentOffset:CGPointMake(0, - 0.3 *ViewH(self.view)) animated:YES];
        button.selected = NO;
    }
}
- (void)loadListData {
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kMusicListDetail([self getValueForKey:@"listid"]) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        [HUDTool hideHUD];
        self.detailModel = [[HJListDetailModel alloc] initWithDictionary:responseObject error:nil];
        if (self.detailModel) {
            [self initTableView];
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
    CGFloat offsetY = _tableView.contentOffset.y;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), 40)];
    label.text = STRFORMAT(@"%lu首歌曲",(unsigned long)self.detailModel.content.count);
    label.backgroundColor = [UIColor whiteColor];
    return label;
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
    getApp().playerView.songID = [self.detailModel.content[indexPath.row] song_id];
    getApp().playerView.content = self.detailModel.content;
}
@end
