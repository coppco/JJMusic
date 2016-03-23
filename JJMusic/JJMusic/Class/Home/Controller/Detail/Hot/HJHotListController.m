//
//  HJHotListController.m
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJHotListController.h"
#import "HJHotListDetailMoel.h"
#import <UIImageView+WebCache.h>

@interface HJHotListController ()
HJpropertyStrong(HJHotListDetailMoel *model);
HJpropertyStrong(NSMutableArray *song_idArray);
@end

@implementation HJHotListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self loadData];
}
- (void)setSubView {
    self.title = self.model.billboard.name;
    if ([_type isEqualToString:@"100"]) {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:@"http://hiphotos.baidu.com/ting/pic/item/a8ec8a13632762d021d3c1e2a6ec08fa503dc6fa.png"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //从图片中获取主色调
            self.view.backgroundColor = [HJCommonTools colorPrimaryFromImage:image];
        }];
    } else {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:_model.billboard.pic_s640] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //从图片中获取主色调
            self.view.backgroundColor = [HJCommonTools colorPrimaryFromImage:image];
        }];
    }
    self.titleDownL.text = self.model.billboard.name;
    self.tagL.text = STRFORMAT(@"标签:  %@", self.model.billboard.name);
    self.descL.text = STRFORMAT(@"介绍:  %@", self.model.billboard.comment);
}
- (void)loadData {
    [HUDTool showLoadingHUDCustomViewInView:self.view title:@"正在加载"];
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kMusicHotDetail(self.type) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        
        [HUDTool hideHUD];
        self.model = [[HJHotListDetailMoel alloc] initWithDictionary:responseObject error:nil];
        if (self.model) {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
            [self initTableView];
            [self setSubView];
            self.song_idArray = [NSMutableArray array];
            for (HotListModel *model11 in self.model.song_list) {
                [self.song_idArray addObject:model11.song_id];
            }
        } else {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            self.errorView = [[ErrorTipsView alloc] initWithFrame:self.view.bounds title:@"提示" subTitle:@"没有找到数据" image:@"NoData" btnTitle:@"返回" btnClick:^(id object) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [self.view addSubview:self.errorView];
        }
    } failedBlock:^(NSError *error) {
        [HUDTool hideHUD];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.errorView = [[ErrorTipsView alloc] initWithFrame:self.view.bounds title:@"你的网络似乎不好哦" subTitle:@"请检查你的网络是否正常" image:@"error_msg_t" btnTitle:@"点击重试" btnClick:^(id object) {
            [self loadData];
        }];
        [self.view addSubview:self.errorView];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.song_list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    HotListModel *model = _model.song_list[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.author;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), 40)];
    label.text = STRFORMAT(@"%lu首歌曲",(unsigned long)self.model.song_list.count);
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [getApp() playerViewAppear:nil];
    getApp().playerView.songID = [self.model.song_list[indexPath.row] song_id];
    getApp().playerView.content = self.song_idArray;
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
