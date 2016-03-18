//
//  HJFavoriteController.m
//  JJMusic
//
//  Created by coco on 16/3/14.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJFavoriteController.h"

#import "HJMySongController.h"  //歌曲
#import "HJMyListController.h"  //列表
#import "HJDwonloadController.h"  //下载
#import "HJSettingController.h"  //设置
@interface HJFavoriteController ()

@end

@implementation HJFavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"player_backgroud"]];
    self.title = @"我的收藏";
    [self initSubView];
    [self initRightButton];
}
- (void)initRightButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.size = CGSizeMake(30, 30);
    [button addTarget:self action:@selector(gotoSetting) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:IMAGE(@"favorite_setting") forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)gotoSetting {
    HJSettingController *settingVC = [[HJSettingController alloc] init];
    settingVC.title = @"设置";
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)initSubView {
    UIImageView *topV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height * 0.3)];
    topV.image = [UIImage imageNamed:@"small_background"];
    [self.view addSubview:topV];
    
    UILabel *topL = [[UILabel alloc] initWithFrame:CGRectMake(10, topV.bottom + 10, self.view.width - 20, 40)];
    topL.text = @"My Favorate Music";
    topL.textColor = [UIColor whiteColor];
    topL.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:25];
    [self.view addSubview:topL];
    
    //两个按钮  收藏的歌曲和收藏的歌单
    UIButton *song = [UIButton buttonWithType:(UIButtonTypeCustom)];
    song.tag = 1024;
    [song addTarget:self action:@selector(myFavorite:) forControlEvents:(UIControlEventTouchUpInside)];
    [song setBackgroundImage:IMAGE(@"favorite_song") forState:(UIControlStateNormal)];
    [self.view addSubview:song];
    
    UIButton *list = [UIButton buttonWithType:(UIButtonTypeCustom)];
    list.tag = 2046;
    [list addTarget:self action:@selector(myFavorite:) forControlEvents:(UIControlEventTouchUpInside)];
    [list setBackgroundImage:IMAGE(@"favorite_list") forState:(UIControlStateNormal)];
    [self.view addSubview:list];
    
    UIButton *down = [UIButton buttonWithType:(UIButtonTypeCustom)];
    down.tag = 2048;
    [down addTarget:self action:@selector(myFavorite:) forControlEvents:(UIControlEventTouchUpInside)];
    [down setBackgroundImage:IMAGE(@"favorite_download") forState:(UIControlStateNormal)];
    [self.view addSubview:down];
    
    [song mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topL.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(self.view).offset((self.view.width - 180) / 4);
    }];
    
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topL.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(song.mas_right).offset((self.view.width - 180) / 4);
    }];
    
    [down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topL.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(list.mas_right).offset((self.view.width - 180) / 4);
    }];
    
    //文字
    UILabel *songL = [[UILabel alloc] init];
    songL.font = font(13);
    songL.text = @"我的歌曲";
    [self.view addSubview:songL];
    UILabel *listL = [[UILabel alloc] init];
    listL.font = font(13);
    listL.text = @"我的歌单";
    [self.view addSubview:listL];
    UILabel *downL = [[UILabel alloc] init];
    downL.font = font(13);
    downL.text = @"我的下载";
    [self.view addSubview:downL];
    
    [songL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(song).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(song.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    [listL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(list).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(list.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    [downL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(down).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(down.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:25];
    label.text = @"Talk is cheap, show me the code!";
    label.textColor = [UIColor orangeColor];
    label.textAlignment = 1;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.width - 6, 18));
    }];
    
}
- (void)myFavorite:(UIButton *)button {
    if (button.tag == 1024) {
        //收藏的歌曲
        HJMySongController *VC = [[HJMySongController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (button.tag == 2046) {
        //收藏的歌单
        HJMyListController *VC = [[HJMyListController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (button.tag == 2048) {
        //下载的歌曲
        HJDwonloadController *downVC = [[HJDwonloadController alloc] init];
        [self.navigationController pushViewController:downVC animated:YES];
    }
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
