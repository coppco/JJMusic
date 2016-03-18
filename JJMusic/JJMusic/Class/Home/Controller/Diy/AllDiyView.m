//
//  AllDiyView.m
//  JJMusic
//
//  Created by coco on 16/2/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "AllDiyView.h"
#import <UIImageView+WebCache.h>
#import "DiyModel.h"  //model
#import "HJListViewController.h"  //详情页面

@interface DiyCell : UICollectionViewCell
HJpropertyStrong(UIImageView *imageV);
HJpropertyStrong(UILabel *titleL);

HJpropertyStrong(DiyModel *model);
@end

@implementation DiyCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleL = [HJCommonTools allocLabelWithTitle:@"" frame:CGRectZero font:font(13) color:[UIColor blackColor] alignment:0 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
         _titleL.numberOfLines = 0;
        [_titleL sizeToFit];
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_titleL];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(15, 0, ViewW(self.contentView) - 30, ViewH(self.contentView) - 30);
    _titleL.frame = CGRectMake(0, ViewMaxY(_imageV), ViewW(self.contentView), 40);
    
}

-(void)setModel:(DiyModel *)model {
    _model = model;
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.pic_300]];
    _titleL.text = model.title;
    
}
@end

@interface AllDiyView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation AllDiyView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.array = [NSMutableArray array];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ViewW(self) / 3 - 10, ViewW(self) / 3 - 10);
        layout.minimumInteritemSpacing = 3;
        layout.minimumLineSpacing = 27;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = ColorClear;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册单元格
        [_collectionView registerClass:[DiyCell class] forCellWithReuseIdentifier:@"DiyCell"];
        [self addSubview:_collectionView];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiyCell" forIndexPath:indexPath];
    cell.model = _array[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DiyModel *model = _array[indexPath.item];
    HJListViewController *ListVC = [[HJListViewController alloc] init];
    ListVC.list_id = model.listid;
    [self.viewController.navigationController pushViewController:ListVC animated:YES];
}
//- (void)setArray:(NSMutableArray *)array {
//    _array = array;
//    
//    [_collectionView reloadData];
//}
@end
