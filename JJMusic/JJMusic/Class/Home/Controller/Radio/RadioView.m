//
//  RadioView.m
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "RadioView.h"
#import "LeboModel.h"
#import "RedRadio.h"
#import <UIImageView+WebCache.h>

@interface RedLeBoCell : UICollectionViewCell
HJpropertyStrong(id model);

HJpropertyStrong(UIImageView *imageV);  //图片
HJpropertyStrong(UILabel *titleL); //标题
HJpropertyStrong(UILabel *listionL);  //听众
@end

@implementation RedLeBoCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageV.layer.cornerRadius = 5;
        self.titleL = [[UILabel alloc] initWithFrame:CGRectZero];
        self.listionL = [[UILabel alloc] initWithFrame:CGRectZero];
        
        self.titleL.textAlignment = 1;
        self.listionL.textAlignment = 2;
        self.listionL.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        self.listionL.font = font(13);
        
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_titleL];
        [self.contentView addSubview:_listionL];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
        _imageV.frame = CGRectMake(0, 0, ViewW(self.contentView), ViewW(self.contentView));
        _titleL.frame = CGRectMake(0, ViewMaxY(_imageV), ViewW(self.contentView), 20);
        _listionL.frame = CGRectMake(0, ViewMaxY(_titleL), ViewW(self.contentView), 20);
}
-(void)setModel:(id)model {
    _model = model;
    if ([model isKindOfClass:[LeboModel class]]) {
        _listionL.hidden = YES;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:((LeboModel *)_model).tag_pic]];
        _titleL.text = ((LeboModel *)_model).tag_name;
        _listionL.text = STRFORMAT(@"%@人收听", ((LeboModel *)_model).name);
    } else {
        _listionL.hidden = NO;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:((RedRadio *)_model).thumb]];
        _titleL.text = ((RedRadio *)_model).name;
        _listionL.text = STRFORMAT(@"%@人收听", ((RedRadio *)_model).listen_num);
        if (((RedRadio *)_model).listen_num.length == 0) {
            _listionL.hidden = YES;
        }
    }
}
@end

@interface RadioView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation RadioView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((ViewW(self) - 40) / 3, (ViewW(self) - 40) / 3 + 40);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = ColorClear;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[RedLeBoCell class] forCellWithReuseIdentifier:@"RedLeBoCell"];
        [self addSubview:_collectionView];
    }
    return self;
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _redRadioArray.count + 2;
    } else {
        return _leBoArray.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RedLeBoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RedLeBoCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RedRadio *model = [[RedRadio alloc] init];
            model.name = @"红心电台";
            cell.model = model;
        } else if (indexPath.row == 1){
            RedRadio *model = [[RedRadio alloc] init];
            model.name = @"私人频道";
            cell.model = model;
        } else {
            cell.model = _redRadioArray[indexPath.item - 2];
        }
    } else {
        cell.model = _leBoArray[indexPath.item];
    }
    return cell;
}
- (void)setRedRadioArray:(NSArray *)redRadioArray {
    _redRadioArray = redRadioArray;
    [_collectionView reloadData];
}
- (void)setLeBoArray:(NSArray *)leBoArray {
    _leBoArray = leBoArray;
    [_collectionView reloadData];
}
@end
