//
//  CarouselView.m
//  JJMusic
//
//  Created by coco on 16/2/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "CarouselView.h"
#import <UIImageView+WebCache.h>
@interface CarouselView ()<UICollectionViewDataSource, UICollectionViewDelegate>
//集合视图
HJpropertyStrong(UICollectionView) *collectionView;
//分页控制器
HJpropertyStrong(UIPageControl *)pageControl;
//NSTimer
HJpropertyStrong(NSTimer *timer);

//保存的数据

HJpropertyAssign(BOOL loop);
@end

@implementation CarouselView
- (instancetype)initWithFrame:(CGRect)frame loop:(BOOL)loop picture:(NSArray<NSString *> *)picArray {
    self = [super initWithFrame:frame];
    if (self) {
        _array = picArray;
        self.loop = loop;
        [self initSubView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame loop:(BOOL)loop picture:(NSArray<NSString *> *)picArray cellSelect:(void (^)(UICollectionView *view, NSIndexPath *index))block {
    self = [super initWithFrame:frame];
    if (self) {
        _array = picArray;
        self.loop = loop;
        self.cellDidSelectAtIndexPath = block;
        [self initSubView];
    }
    return self;
}
- (void)setArray:(NSArray *)array {
    _array = array;
    _pageControl.numberOfPages = array.count;
    [_collectionView reloadData];
}
- (void)initSubView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //水平方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(ViewW(self), ViewH(self));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self), ViewH(self)) collectionViewLayout:layout];
    //注册单元格
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = ColorClear;
    [self addSubview:_collectionView];
    
    if (_loop) {
        [self startTimer];
    }
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = self.array.count;
    _pageControl.pageIndicatorTintColor = [UIColor greenColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [_pageControl addTarget:self action:@selector(imageChange:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self), 20));
        make.left.right.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    //    _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(ViewW(self.view) / 2 - 50, ViewH(self.view) - 30, 100, 20)];
    //    _pageController.numberOfPages = kNum;
    //    [self.view addSubview:_pageController];
}
//初始化NSTimer
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    //添加运行循环
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//pageControl 方法
- (void)imageChange:(UIPageControl *)page {
    [_collectionView setContentOffset:CGPointMake(KMainScreenWidth * page.currentPage, 0) animated:YES];
}
//nstimer方法
- (void)timer:(id)sender {
    NSInteger page = _pageControl.currentPage + 1;
    _pageControl.currentPage = (page == self.array.count ? 0 : page);
    //添加动画
    [HJCommonTools animationCATransitionForView:_collectionView duration:1 type:HJAnimationTypeReveal direction:(DirectionTypeRight)];
    [_collectionView setContentOffset:CGPointMake(KMainScreenWidth * _pageControl.currentPage, 0) animated:NO];
}
#pragma mark - UICollecionViewDelegate 和 UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
    if ([self.array[indexPath.row] hasPrefix:@"http"] ) {
        [imageV sd_setImageWithURL:self.array[indexPath.row] placeholderImage:nil];
    } else {
        imageV.image = IMAGE(self.array[indexPath.row]);
    }
    cell.backgroundView = imageV;
    return cell;
}
//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellDidSelectAtIndexPath) {
        self.cellDidSelectAtIndexPath(collectionView, indexPath);
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //停止时钟，停止后就不能在使用，如果要启用时钟，需要重新实例化
    [self.timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / ViewW(_collectionView);
    _pageControl.currentPage = page;
    //启动时钟
    [self startTimer];
}

@end
