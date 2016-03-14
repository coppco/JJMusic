//
//  MusicListView.m
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "MusicListView.h"
#import "MuiscList.h"
#import <UIImageView+WebCache.h>
#import "HJHotListController.h"
#define k_x 15
#define k_h 20
#define k_v 4
@interface MusicListCell : UICollectionViewCell
HJpropertyStrong(MuiscList *model);

//公共组件
HJpropertyStrong(UIImageView *imageV);  //大图片
HJpropertyStrong(UILabel *firstL);
HJpropertyStrong(UILabel *secondL);
HJpropertyStrong(UILabel *thirdL);
HJpropertyStrong(UILabel *fourthL);
@end

@implementation MusicListCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.firstL = [[UILabel alloc] initWithFrame:CGRectZero];
        self.secondL = [[UILabel alloc] initWithFrame:CGRectZero];
        self.thirdL = [[UILabel alloc] initWithFrame:CGRectZero];
        self.fourthL = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_firstL];
        [self.contentView addSubview:_secondL];
        [self.contentView addSubview:_thirdL];
        [self.contentView addSubview:_fourthL];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(k_x, k_x, ViewH(self.contentView) - 2 * k_x, ViewH(self.contentView) - 2 * k_x);
    _firstL.frame = CGRectMake(ViewMaxX(_imageV) + k_h, ViewY(_imageV) + k_v, ViewW(self.contentView) - ViewMaxX(_imageV) - k_h - k_x, (ViewH(_imageV) - k_v * 5) / 4);
    _secondL.frame = CGRectMake(ViewX(_firstL), ViewMaxY(_firstL) + k_v, ViewW(_firstL), ViewH(_firstL));
    _thirdL.frame = CGRectMake(ViewX(_secondL), ViewMaxY(_secondL) + k_v, ViewW(_secondL), ViewH(_secondL));
    _fourthL.frame = CGRectMake(ViewX(_thirdL), ViewMaxY(_thirdL) + k_v, ViewW(_thirdL), ViewH(_thirdL));
}
- (void)setModel:(MuiscList *)model {
    _model = model;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_s192]];
    if (model.musicList.count > 0) {
        _firstL.attributedText = [HJCommonTools labelAttributedText:STRFORMAT(@"1  %@-%@", ((ListContent *)model.musicList[0]).title, ((ListContent *)model.musicList[0]).author) font:font(12) color:[UIColor blackColor] alignment:1 keyWords:@"1" keyWordsColor:[UIColor redColor] keyWordsFont:[UIFont fontWithName:@"SnellRoundhand-Black" size:13] underLine:NO];
    }
    if (model.musicList.count > 1) {
        _secondL.attributedText = [HJCommonTools labelAttributedText:STRFORMAT(@"2  %@-%@", ((ListContent *)model.musicList[1]).title, ((ListContent *)model.musicList[1]).author) font:font(12) color:[UIColor blackColor] alignment:1 keyWords:@"2" keyWordsColor:[UIColor redColor] keyWordsFont:[UIFont fontWithName:@"SnellRoundhand-Black" size:13] underLine:NO];
    }
    if (model.musicList.count > 2) {
        _thirdL.attributedText = [HJCommonTools labelAttributedText:STRFORMAT(@"3 %@-%@", ((ListContent *)model.musicList[2]).title, ((ListContent *)model.musicList[2]).author) font:font(12) color:[UIColor blackColor] alignment:1 keyWords:@"3" keyWordsColor:[UIColor redColor] keyWordsFont:[UIFont fontWithName:@"SnellRoundhand-Black" size:13] underLine:NO];
    }
    if (model.musicList.count > 3) {
        _fourthL.attributedText = [HJCommonTools labelAttributedText:STRFORMAT(@"4  %@-%@", ((ListContent *)model.musicList[3]).title, ((ListContent *)model.musicList[3]).author) font:font(12) color:[UIColor blackColor] alignment:1 keyWords:@"4" keyWordsColor:[UIColor redColor] keyWordsFont:[UIFont fontWithName:@"SnellRoundhand-Black" size:13] underLine:NO];
    }
}
@end

@interface MusicListView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation MusicListView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ViewW(self), 100);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 2, 0);
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册单元格
        [_collectionView registerClass:[MusicListCell class] forCellWithReuseIdentifier:@"MusicListCell"];
        [self addSubview:_collectionView];
    }
    return self;
}
- (void)setArray:(NSArray *)array {
    _array = array;
    
    [_collectionView reloadData];
}
#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MusicListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _array[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    HJHotListController *ListVC = [[HJHotListController alloc] init];
    ListVC.type = [(MuiscList *)(_array[indexPath.row]) type];
    [self.viewController.navigationController pushViewController:ListVC animated:YES];
}

@end
