//
//  GuideViewController.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "GuideViewController.h"
#define kNum 4
@interface GuideViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
HJpropertyStrong(UICollectionView *collectionView); //集合视图
HJpropertyStrong(UIPageControl *pageController);  //分页控制器
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载子视图
    [self initSubView];
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
    _collectionView.backgroundColor = ColorClear;
    [self.view addSubview:_collectionView];
    
    _pageController = [[UIPageControl alloc] init];
    [self.view addSubview:_pageController];
    [_pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ViewW(self.view), 50));
        make.center.mas_equalTo(CGPointMake(ViewW(self.view) / 2, ViewH(self.view) - 60));
    }];
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
