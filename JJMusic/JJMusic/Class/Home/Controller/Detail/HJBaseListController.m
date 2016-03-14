//
//  HJBaseListController.m
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJBaseListController.h"

@interface HJBaseListController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation HJBaseListController
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
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    //标题  标签  说明
    _titleDownL = [[UILabel alloc] init];
    _titleDownL.textColor = [UIColor whiteColor];
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = _tableView.contentOffset.y;
    if (offsetY >= -64) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

@end
