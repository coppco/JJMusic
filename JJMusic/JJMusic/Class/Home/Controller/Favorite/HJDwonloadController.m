//
//  HJDwonloadController.m
//  JJMusic
//
//  Created by coco on 16/3/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJDwonloadController.h"
#import "HJDownloadDB.h"  //数据库
#import <UIImageView+WebCache.h>

@interface HJDwonloadController ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(NSMutableArray *array);
HJpropertyStrong(UITableView *tableView);
HJpropertyStrong(ErrorTipsView *errorView);
@end

@implementation HJDwonloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"player_backgroud")];
    self.title = @"我下载的歌曲";
    self.array = [HJDownloadDB getAllDownloadSong].mutableCopy;
    if (0 != self.array.count) {
        [self initTableView];
    } else {
        [self initErrorView];
    }
}
- (void)initErrorView {
    self.errorView = [[ErrorTipsView alloc] initWithFrame:self.view.bounds title:@"提示" subTitle:@"你还没有下载的音乐!" image:@"noFavoriteData" btnTitle:@"点击去添加" btnClick:^(id object) {
        
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
    NSDictionary *dict = self.array[indexPath.row];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.textLabel.text = dict[@"song_title"];
    cell.detailTextLabel.text = dict[@"song_author"];
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    cell.imageView.layer.cornerRadius = 5;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:((HJSongModel *)dict[@"song_data"]).songinfo.artist_500_500] placeholderImage:IMAGE(@"placeHold")];
    return cell;
}
//实现编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //从数据库删除数据
        NSDictionary *dict = self.array[indexPath.row];
        [HJDownloadDB deleteOneDownloadSongWithSong_id:dict[@"song_id"]];
        //文件删除数据
        [[NSFileManager defaultManager] removeItemAtPath:dict[@"song_path"] error:nil];
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
    NSDictionary *dict = self.array[indexPath.row];
    getApp().playerView.songModel = dict[@"song_data"];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dic in self.array) {
        [arrayM addObject:dic[@"song_data"]];
    }
    getApp().playerView.content = arrayM;
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
