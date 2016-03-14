//
//  SingerCell.m
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "SingerCell.h"
#import <UIImageView+WebCache.h>
#import "SingerModel.h"
#import "HJSingerController.h"

#define kkkkkH 0
@interface ImageLabel : UICollectionViewCell
HJpropertyStrong(UIImageView *imageV);
HJpropertyStrong(UILabel *titleL);
HJpropertyStrong(SingerModel *model);
@end
@implementation ImageLabel
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleL = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleL.textAlignment = 1;
        _titleL.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:13];
        
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_titleL];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(0, 0, ViewW(self.contentView), ViewW(self.contentView));
    _imageV.layer.cornerRadius = ViewW(_imageV) / 2; //圆角
    
    _titleL.frame = CGRectMake(0, ViewMaxY(_imageV), ViewW(self.contentView), 20);
}

- (void)setModel:(SingerModel *)model {
    _model = model;
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.avatar_middle]];
    _titleL.text = model.name;
}
@end

@interface SingerCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
HJpropertyStrong(UILabel *titleL);  //标题
HJpropertyStrong(UICollectionViewFlowLayout *layout);
HJpropertyStrong(UICollectionView *collectionView);
HJpropertyStrong(UIPageControl *pageControl);
@end

@implementation SingerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleL.text = @"热门歌手";
        _titleL.textAlignment = 1;
        _titleL.textColor = [UIColor blackColor];
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//垂直排列
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = ColorClear;
        _collectionView.pagingEnabled = YES;  //整页翻转
        _collectionView.bounces = YES;  //边界回弹
        _collectionView.showsHorizontalScrollIndicator = NO;  //水平滚动条
        //注册
        [_collectionView registerClass:[ImageLabel class] forCellWithReuseIdentifier:@"ImageLabel"];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [_pageControl addTarget:self action:@selector(page:) forControlEvents:(UIControlEventValueChanged)];
        [self.contentView addSubview:_titleL];
        [self.contentView addSubview:_collectionView];
        [self.contentView addSubview:_pageControl];
    }
    return self;
}
//pageControl方法
- (void)page:(UIPageControl *)page {
    [_collectionView setContentOffset:CGPointMake(page.currentPage * ViewW(_collectionView), 0) animated:YES];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleL.frame = CGRectMake(0, 10, ViewW(self.contentView), 30);
    _layout.itemSize = CGSizeMake((ViewW(self.contentView) - kkkkkH) / 4, (ViewW(self.contentView) - kkkkkH) / 4 + 20);
    
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
//    _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _collectionView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self.contentView), 2 * ((ViewW(self.contentView) - kkkkkH) / 4 + 20) + 10);
    _pageControl.frame = CGRectMake(0, ViewMaxY(_collectionView) + 10, ViewW(self.contentView), 20);
}

-(void)setArray:(NSArray *)array {
    _array = array;
    
    [_collectionView reloadData];
}
#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageLabel *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageLabel" forIndexPath:indexPath];
    cell.model = _array[indexPath.item];
    return cell;
}
- (void)awakeFromNib {
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJSingerController *singerVC = [[HJSingerController alloc] init];
    singerVC.singer = _array[indexPath.item];
    [self.viewController.navigationController pushViewController:singerVC animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / ViewW(_collectionView);
    _pageControl.currentPage = page;
}

@end
