//
//  RecommendView.m
//  JJMusic
//
//  Created by coco on 16/2/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "RecommendView.h"
#import "CarouselView.h"  //轮播图
#import "RModel.h" //model
#import "RecommendCell.h"  //cell
@interface RecommendView ()<UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(CarouselView *carouselView);
@end

@implementation RecommendView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ColorClear;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;  //分割线样式
    //设置边框
//    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self addSubview:_tableView];
    
    //轮播图
    _carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 200) loop:YES picture:nil cellSelect:^(UICollectionView *view, NSIndexPath *indexPath) {
        
    }];
    _tableView.tableHeaderView = _carouselView;
}
- (void)setRecommend:(RModel *)recommend {
    _recommend = recommend;

    //轮播图赋值
    NSMutableArray *array = [NSMutableArray array];
    for (Focus *focus in _recommend.focus) {
        [array addObject:focus.randpic_iphone6];
    }
    _carouselView.array = array;
    
    [_tableView reloadData];
}
#pragma mark - UITableViewDelegate 和 UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 5) {
        return 200;
    }
    if (indexPath.row == 0 || indexPath.row == 6) {
        return 240;
    }
    return 370;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recommend.module.count - 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"cell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[RecommendCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //cell不能选择
    }
    
    if (indexPath.row == 0) {
        [cell setRModel:_recommend type:RTypeSong];
    }else if (indexPath.row == 1) {
        [cell setRModel:_recommend type:RTypeScene];
    }else if (indexPath.row == 2) {
        [cell setRModel:_recommend type:RTypeList];
    }else if (indexPath.row == 3) {
        [cell  setRModel:_recommend type:RTypeAlbum];
    }else if (indexPath.row == 4) {
        [cell  setRModel:_recommend type:RTypeLeBo];
    }else if (indexPath.row == 5) {
        [cell  setRModel:_recommend type:RTypeOne];
    }else if (indexPath.row == 6) {
        [cell  setRModel:_recommend type:RTypeKing];
    }
    return  cell;
}

@end
