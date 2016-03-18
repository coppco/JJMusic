//
//  HJMySongController.m
//  JJMusic
//
//  Created by coco on 16/3/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJMySongController.h"
#import "MyFavouriteMusicDB.h"  //数据库
#import "HJSongModel.h"
#import "HUDTool.h"
#import <UIImageView+WebCache.h>

@interface HJMySongController ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(UITableView *tableView);
HJpropertyStrong(NSMutableArray *array);  //数组
HJpropertyStrong(ErrorTipsView *errorView);  //显示提示视图
@end

@implementation HJMySongController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"player_backgroud")];
    self.title = @"我的歌曲";
    self.array = [MyFavouriteMusicDB getAllMusic].mutableCopy;
    if (0 != self.array.count) {
        [self initTableView];
    } else {
        [self initErrorView];
    }
}
- (void)initErrorView {
    self.errorView = [[ErrorTipsView alloc] initWithFrame:self.view.bounds title:@"提示" subTitle:@"你还没有收藏的音乐!" image:@"noFavoriteData" btnTitle:@"点击去添加" btnClick:^(id object) {
        
    }];
    [self.view addSubview:self.errorView];
}
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    self.editButtonItem.title = @"编辑";
    self.editButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
    if (self.editing) {
        self.editButtonItem.title = @"取消";
    } else {
        self.editButtonItem.title = @"编辑";
    }
}
- (void)editingFavorite:(UIBarButtonItem *)sender {
    self.tableView.editing = YES;
}
#pragma mark - UITableViewDatasource 和UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:indentify];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HJSongModel *model = self.array[indexPath.row];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.textLabel.text = model.songinfo.title;
    cell.detailTextLabel.text = model.songinfo.author;
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    cell.imageView.layer.cornerRadius = 5;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.songinfo.artist_500_500] placeholderImage:IMAGE(@"placeHold")];
    return cell;
}
//实现编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //从数据库删除数据
        HJSongModel *model = self.array[indexPath.row];
        [MyFavouriteMusicDB deleteOneMusic:model.songinfo.song_id];
         //数组删除数据
         [self.array removeObjectAtIndex:indexPath.row];
         //表视图删除数据
         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        if (self.array.count == 0) {
            self.navigationItem.rightBarButtonItem = nil;
            [self initErrorView];
        }
    }
}
//编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中
     [getApp() playerViewAppear:nil];
    getApp().playerView.isFavoritePlayer = YES;
    getApp().playerView.songModel = self.array[indexPath.row];
    getApp().playerView.content = self.array;
}
@end
