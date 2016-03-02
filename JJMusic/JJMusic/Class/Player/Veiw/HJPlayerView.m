//
//  HJPlayerView.m
//  JJMusic
//
//  Created by coco on 16/3/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJPlayerView.h"
#import "HJPlayerBottomView.h"
@interface HJPlayerView ()
HJpropertyStrong(UIButton *backButton);  //隐藏按钮
HJpropertyStrong(UIImageView *backImageV);  //背景图片
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UILabel *autherL);  //歌手名字
HJpropertyStrong(UIButton *changeB);  //切换音质
HJpropertyStrong(UIScrollView *scrollView);  //滚动视图
HJpropertyStrong(UIPageControl *pageControll);//分页控制
HJpropertyStrong(HJPlayerBottomView *)bottomView;  //按钮滑块等
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
    self.backImageV.image = [UIImage imageNamed:@"mp3"];
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
    [self.autherL sizeToFit];
    [self addSubview:_autherL];
    [self.autherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeB);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.equalTo(self.changeB.mas_right).offset(5);
    }];
    
    self.bottomView = [[HJPlayerBottomView alloc] initWithFrame:CGRectMake(0, ViewH(self) - 190, ViewW(self), 190)];
    [self addSubview:self.bottomView];
}
- (void)down:(UIButton *)button {
    [UIView animateWithDuration:0.4 animations:^{
        self.userInteractionEnabled = NO;
        self.center = CGPointMake(ViewW(self) / 2, ViewH(self) / 2 * 3);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
@end
