//
//  GuideViewController.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "GuideViewController.h"
#import "HomeViewController.h"
#define kNum 4   //引导图的数量
@interface GuideViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
HJpropertyStrong(UICollectionView *collectionView); //集合视图
HJpropertyStrong(UIPageControl *pageController);  //分页控制器
HJpropertyStrong(NSMutableArray *imageArray);  //图片数组
HJpropertyStrong(UIButton *enterButton);  //进入button
HJpropertyStrong(UIButton *skipButton);  //跳过button
@end

@implementation GuideViewController

- (void)viewDidLoad {
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置图片
    [self initImage];
    //加载子视图
    [self initSubView];
}
- (void)initImage {
    _imageArray = [NSMutableArray array];
    for (int i = 1; i <=kNum; i++) {
        if (ISIPHONE_3) {
            [_imageArray addObject:STRFORMAT(@"320*480-%d.jpg", i)];
        }
        if (ISIPHONE_4) {
            [_imageArray addObject:STRFORMAT(@"640*960-%d.jpg", i)];
        }
        if (ISIPHONE_5) {
            [_imageArray addObject:STRFORMAT(@"640*1136-%d.jpg", i)];
        }
        if (ISIPHONE_6) {
            [_imageArray addObject:STRFORMAT(@"750*1334-%d.jpg", i)];
        }
        if (ISIPHONE_6P) {
            [_imageArray addObject:STRFORMAT(@"1242*2208-%d.jpg", i)];
        }
    }
}
- (void)initSubView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //水平方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(ViewW(self.view), ViewH(self.view));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ViewW(self.view), ViewH(self.view)) collectionViewLayout:layout];
    //注册单元格
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
//    _collectionView.backgroundColor = ColorClear;
    [self.view addSubview:_collectionView];
    
    _pageController = [[UIPageControl alloc] init];
    _pageController.numberOfPages = kNum;
    _pageController.pageIndicatorTintColor = [UIColor greenColor];
    _pageController.currentPageIndicatorTintColor = [UIColor purpleColor];
    [_pageController addTarget:self action:@selector(imageChange:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_pageController];
    [_pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self.view), 20));
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
//    _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(ViewW(self.view) / 2 - 50, ViewH(self.view) - 30, 100, 20)];
//    _pageController.numberOfPages = kNum;
//    [self.view addSubview:_pageController];
    //跳过button
    _skipButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_skipButton setTitle:@"跳过" forState:(UIControlStateNormal)];
    _skipButton.layer.cornerRadius = 15;
    _skipButton.layer.borderWidth = 1;
    _skipButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _skipButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor;
    [_skipButton addTarget:self action:@selector(enter:) forControlEvents:(UIControlEventTouchUpInside)];
    [_skipButton setTitleColor:ColorFromString(@"#00BB00") forState:(UIControlStateNormal)];
    [self.view addSubview:_skipButton];
    [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    
    //开启button
    _enterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _enterButton.frame = CGRectMake(0, ViewH(self.view) - 70, ViewW(self.view), 40);
    [_enterButton setTitle:@"开启音乐之旅" forState:(UIControlStateNormal)];
    _enterButton.layer.cornerRadius = 15;
    _enterButton.layer.borderWidth = 1;
    _enterButton.backgroundColor = [UIColor redColor];
    _enterButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor;
    _enterButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    [_enterButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[_enterButton titleLabel] setFont:[UIFont systemFontOfSize:16]];
    [_enterButton addTarget:self action:@selector(enter:) forControlEvents:(UIControlEventTouchUpInside)];
//    _enterButton.hidden = YES;
//    [self.view addSubview:_enterButton];
}
//pageControl 方法
- (void)imageChange:(UIPageControl *)page {
    [_collectionView setContentOffset:CGPointMake(KMainScreenWidth * page.currentPage, 0) animated:YES];
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}
//进入App
- (void)enter:(UIButton *)button {
    userDefaultSetValueKey(@YES, isFirstLoad);
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    getAppWindow().rootViewController = homeVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollecionViewDelegate 和 UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kNum;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (![cell viewWithTag:9999]) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:IMAGEFILE(_imageArray[indexPath.row])];
        imageV.tag = 9999;
        imageV.userInteractionEnabled = YES;
        imageV.frame = self.view.bounds;
        [cell.contentView addSubview:imageV];
    } else {
        UIImageView *imageV = [cell viewWithTag:9999];
        if (indexPath.row == 3) {
            _enterButton.hidden = NO;
            [imageV addSubview:_enterButton];
        }
        if (indexPath.row == 1) {
            _enterButton.hidden = YES;
        }
        imageV.image = IMAGEFILE(_imageArray[indexPath.row]);
    }
    return cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / ViewW(_collectionView);
    _pageController.currentPage = page;
}
@end
