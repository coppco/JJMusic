//
//  HJPlayerView.m
//  JJMusic
//
//  Created by coco on 16/3/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerView.h"
#import "HJPlayerBottomView.h"
#import "HJMusicTool.h"  //播放器
#import "HJSongModel.h"  //model
@interface HJPlayerView ()<UIScrollViewDelegate>
HJpropertyStrong(UIButton *backButton);  //隐藏按钮
HJpropertyStrong(UIImageView *backImageV);  //背景图片
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UILabel *autherL);  //歌手名字
HJpropertyStrong(UIButton *changeB);  //切换音质
HJpropertyStrong(UIScrollView *scrollView);  //滚动视图
HJpropertyStrong(UIPageControl *pageControll);//分页控制
HJpropertyStrong(HJPlayerBottomView *)bottomView;  //按钮滑块等
HJpropertyStrong(HJSongModel *model);

//scrollView添加的内容
HJpropertyStrong(UIImageView *imageV);  //第一页
HJpropertyStrong(UIView *lyricV);  //只有两行的
HJpropertyStrong(UIView *lyricVs);  //第三个歌词  填满scrollview
HJpropertyStrong(UIView *listView);//
@end

@implementation HJPlayerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    self.backImageV = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backImageV.image = [UIImage imageNamed:@"player_backgroud"];
    [self addSubview:self.backImageV];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.backButton setBackgroundImage:IMAGE(@"player_down") forState:(UIControlStateNormal)];
    [self.backButton addTarget:self action:@selector(down:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.left.equalTo(self).insets(UIEdgeInsetsMake(15, 30, 0, 0));
    }];
    //标题
    self.titleL = [[UILabel alloc] init];
    self.titleL.textColor = [UIColor whiteColor];
    self.titleL.text = @"爱你的365天";
    [self.titleL sizeToFit];
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton);
        make.left.equalTo(self.backButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    //切换音质
    self.changeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.changeB.layer.cornerRadius = 5;
    self.changeB.layer.borderWidth = 1;
    self.changeB.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.changeB setTitle:@"超高" forState:(UIControlStateNormal)];
    self.changeB.titleLabel.font = font(11);
    [self.changeB setImage:IMAGE(@"player_change") forState:(UIControlStateNormal)];
    [self addSubview:self.changeB];
    [self.changeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.left.equalTo(self.titleL.mas_left);
        make.top.equalTo(self.titleL.mas_bottom).offset(2);
    }];
    //歌手
    self.autherL = [[UILabel alloc] init];
    self.autherL.text = @"Hans Zimmer";
    self.autherL.textColor = [UIColor whiteColor];
    [self.autherL sizeToFit];
    [self addSubview:_autherL];
    [self.autherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeB);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.equalTo(self.changeB.mas_right).offset(5);
    }];
    
    self.bottomView = [[HJPlayerBottomView alloc] init];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self), ViewH(self) * 0.25));
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self);
    }];
    
    //    page
    self.pageControll = [[UIPageControl alloc] init];
    self.pageControll.numberOfPages = 4;
    [self.pageControll addTarget:self action:@selector(page:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:self.pageControll];
    [self.pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    //滚动视图
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.autherL.mas_bottom).offset(3);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self.pageControll.mas_top);
    }];
}
//page方法
- (void)page:(UIPageControl *)page {
    [self.scrollView setContentOffset:CGPointMake(ViewW(_scrollView) * page.currentPage, 0) animated:YES];
}
//UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / ViewW(scrollView);
    _pageControll.currentPage = page;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //第一页图片
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewW(_scrollView), ViewH(_scrollView))];
    [_scrollView addSubview:view];
    
    self.imageV = [[UIImageView alloc] initWithImage:IMAGE(@"player_record")];
    self.imageV.backgroundColor = [UIColor redColor];
    self.imageV.frame = CGRectMake(ViewW(view) / 2 - ViewW(view) * 0.35, ViewH(view) /2 - ViewW(view) * 0.35, ViewW(view) * 0.7, ViewW(view) * 0.7);
    self.imageV.layer.cornerRadius = ViewW(_imageV) / 2;
    self.imageV.layer.borderWidth = 2;
    self.imageV.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:1].CGColor;
    [view addSubview:self.imageV];
    
    //设置scrollview的范围
    self.scrollView.contentSize = CGSizeMake(ViewW(self) * 4, 0);
}
- (void)down:(UIButton *)button {
    [UIView animateWithDuration:0.4 animations:^{
        self.userInteractionEnabled = NO;
        self.center = CGPointMake(ViewW(self) / 2, ViewH(self) / 2 * 3);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
#pragma mark - 播放方法
- (void)playMusicWith:(HJSongModel *)model {
    _model = model;
    [[HJMusicTool sharedMusicPlayer] playWithURL:((SongURL *)model.url[0]).file_link];
}
@end
