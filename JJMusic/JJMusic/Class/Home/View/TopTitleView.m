//
//  TopTitleView.m
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "TopTitleView.h"

@interface TopTitleView ()
HJpropertyStrong(UILabel *shortLabel);  //下面的短label

@end

@implementation TopTitleView
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat beginX = begin_X;
        CGFloat spaceWidth = 10;  //button的间隔
        //button的宽
        CGFloat width = (frame.size.width - 2 * begin_X - spaceWidth * (titleArray.count - 1)) / titleArray.count;
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = CGRectMake(beginX + (width + spaceWidth) * i, 0, width, frame.size.height);
            [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            button.titleLabel.font = font(15);
            button.tag = 9980 + i;
            button.exclusiveTouch = YES;  //排他
            [button addTarget:self action:@selector(buttonHasClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:button];
        }
        UILabel *line = [HJCommonTools allocLabelWithTitle:nil frame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1) font:nil color:nil alignment:0 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
        line.backgroundColor = [UIColor redColor];
        [self addSubview:line];
        
        //初始状态
        [self initStatus];
    }
    return self;
}
- (void)initStatus {
    UIButton *button = [self viewWithTag:9980];
    self.selectIndex = button.tag;
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    CGFloat width = [HJCommonTools widthForFont:button.titleLabel.font height:button.titleLabel.frame.size.height string:button.currentTitle];
    self.shortLabel = [HJCommonTools allocLabelWithTitle:@"" frame:CGRectMake(ViewX(button) + (ViewW(button) - width) / 2, ViewMaxY(button) - 3, width, 3) font:nil color:nil alignment:0 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
    self.shortLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:self.shortLabel];
}
//button点击
- (void)buttonHasClick:(UIButton *)button {
    if (button.tag != self.selectIndex) {
        //变换颜色
        UIButton *selectButton = [self viewWithTag:self.selectIndex];
        [selectButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        //改变位置
        CGFloat width = [HJCommonTools widthForFont:button.titleLabel.font height:button.titleLabel.frame.size.height string:button.currentTitle];
        [UIView animateWithDuration:0.2 animations:^{
            self.shortLabel.frame = CGRectMake(ViewX(button) + (ViewW(button) - width) / 2, ViewMaxY(button) - 3, width, 3);
        }];
        self.selectIndex = button.tag;
        //执行了点击buttonblock
        if (self.buttonClick) {
            self.buttonClick(button.tag);
        }
    }
}

@end
