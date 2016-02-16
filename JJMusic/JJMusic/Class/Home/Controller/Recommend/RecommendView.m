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
    //设置边框
    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self addSubview:_tableView];
    
    //轮播图
    _carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 200) loop:YES picture:nil cellSelect:^(UICollectionView *view, NSIndexPath *indexPath) {
        
    }];
    [self addSubview:_carouselView];
}
- (void)setRecommend:(RModel *)recommend {
    _recommend = recommend;

    
    //轮播图赋值
    NSMutableArray *array = [NSMutableArray array];
    for (Focus *focus in _recommend.focus) {
        [array addObject:focus.randpic_iphone6];
    }
    _carouselView.array = array;
}
#pragma mark - UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    return cell;
}
@end
