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

@interface HJListViewController ()
HJpropertyStrong(UIImageView *)imageV;  //上方图片
HJpropertyStrong(UIButton *closeB);  //返回按钮
HJpropertyStrong(UITableView *tableView);

//下面的几个label
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UILabel *tagL);  //标签
HJpropertyStrong(UILabel *descL); //介绍
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
    [self initSubView];
}
- (void)initSubView {
    self.imageV = [[UIImageView alloc] init];
    [self.view addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self.view), ViewH(self.view) * 0.6));
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.imageV.contentMode = UIViewContentModeScaleToFill;
    XHJLog(@"%@", _model);
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
    _titleL = [[UILabel alloc] init];
    _titleL.text = [self getValueForKey:@"title"];
    [_titleL sizeToFit];
    [self.view addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(20);
        make.left.equalTo(self.imageV.mas_left).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    _tagL = [[UILabel alloc] init];
    _tagL.numberOfLines = 0;
    _tagL.text = STRFORMAT(@"标签:   %@",[self getValueForKey:@"desc"]);
    [_tagL sizeToFit];
   
    [self.view addSubview:_tagL];
    [_tagL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(10);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 15, 0, 0));
        make.height.mas_equalTo(_tagL.frame.size.height);
        NSLog(@"%f", _tagL.frame.size.height);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), ViewH(self.view))];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(ViewH(self.view) * 0.3, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    
    _closeB.showsTouchWhenHighlighted = YES;
    _closeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _closeB.frame = CGRectMake(10, 25, 50, 50);
    [_closeB addTarget:self action:@selector(close:) forControlEvents:(UIControlEventTouchUpInside)];
    [_closeB setImage:IMAGE(@"back") forState:(UIControlStateNormal)];
    [self.view addSubview:self.closeB];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
