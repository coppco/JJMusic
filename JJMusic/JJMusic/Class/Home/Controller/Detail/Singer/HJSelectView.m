//
//  HJSelectView.m
//  JJMusic
//
//  Created by coco on 16/3/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSelectView.h"

@interface HJSelectView ()<UICollectionViewDataSource, UICollectionViewDelegate>
HJpropertyStrong(NSArray *array);
HJpropertyStrong(UILabel *titleL);  //歌手首字母
HJpropertyStrong(UIButton *closeB);  //关闭button
HJpropertyStrong(UICollectionViewFlowLayout *layout);
HJpropertyStrong(UICollectionView *collectionView);  //集合视图
@end

@implementation HJSelectView
- (NSArray *)array {
    if (_array == nil) {
        _array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aToz.plist" ofType:nil]];
    }
    return _array;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    self.titleL = [[UILabel alloc] init];
    self.titleL.text = @"歌手首字母";
    self.titleL.backgroundColor = [UIColor whiteColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(self.height * 0.3, 0, 0, 0));
        make.height.mas_equalTo(30);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(0);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(1);
    }];
    self.closeB = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.closeB.backgroundColor = [UIColor whiteColor];
    [self.closeB setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self.closeB addTarget:self action:@selector(closeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.closeB setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self addSubview:self.closeB];
    [self.closeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(30);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor blackColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.closeB.mas_top).offset(0);
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(1);
    }];
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    //注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource  = self;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(line.mas_bottom).offset(0);
        make.bottom.equalTo(line1.mas_top).offset(0);
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeClick)];
//    [self addGestureRecognizer:tap];
}
- (void)closeClick {
    [HJCommonTools animationCATransitionForView:self duration:0.2 type:(HJAnimationTypePageCurl) direction:(DirectionTypeTop)];
    self.alpha = 0 ;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.collectionView.width;
    CGFloat height = self.collectionView.height;
    self.layout.itemSize = CGSizeMake((width - 2) / 4, (height - 2.5) / 7);
    self.layout.minimumInteritemSpacing = 0.5;
    self.layout.minimumLineSpacing = 0.5;
}
#pragma mark - UICollectionViewDataSource 和 UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.text = self.array[indexPath.item];
    label.textAlignment = 1;
    label.textColor = [UIColor blackColor];
    [cell.contentView addSubview:label];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    [self performSelector:@selector(performSelfMothed:) withObject:@(indexPath.row) afterDelay:0.2];
    
}
- (void)performSelfMothed:(NSNumber *)object {
    NSInteger row = [object integerValue];
    [self closeClick];
    if (self.clicked) {
        self.clicked(self.array[row]);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
@end
