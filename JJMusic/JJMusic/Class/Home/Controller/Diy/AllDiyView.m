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
#import "KxMenu.h"  //
#import "HJPickView.h"

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
HJpropertyStrong(NSDictionary *titleDic);
HJpropertyStrong(HJPickView *pickView);  //选择视图
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
        //设置区头大小
        layout.headerReferenceSize = CGSizeMake(KMainScreenWidth, 44);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = ColorClear;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册单元格
        [_collectionView registerClass:[DiyCell class] forCellWithReuseIdentifier:@"DiyCell"];
        //注册头视图
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.tag = 9900;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = CGRectMake(20, 0, 100, 44);
            [button setImage:IMAGE(@"button_down") forState:(UIControlStateNormal)];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [button addTarget:self action:@selector(chooseDiy:) forControlEvents:(UIControlEventTouchUpInside)];
            [button setTitle:@"全部歌单" forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [view addSubview:button];
        });
        return view;
    }
    return nil;
}
- (void)chooseDiy:(UIButton *)sender {
    if (_pickView == nil) {
        _pickView = [[HJPickView alloc] initWithFrame:CGRectZero cancel:^{
            
        } done:^(NSString *title) {
            if (self.headerClick) {
                UIView *view = [self.collectionView viewWithTag:9900];
                for (UIView *vvv in view.subviews) {
                    if ([vvv isKindOfClass:[UIButton class]]) {
                        [((UIButton *)vvv) setTitle:title forState:(UIControlStateNormal)];
                    }
                }
                self.headerClick(title);
            }
        } dict:self.titleDic];
    }
    [_pickView showInView:self];
}

- (NSDictionary *)titleDic {
    if (_titleDic == nil) {
        _titleDic = @{@"全部":@[@"全部"],
                      @"精选推荐":@[@"音乐专题"],
                      @"语种":@[@"粤语", @"韩语", @"日语",@"欧美", @"华语"],
                      @"风格":@[@"民谣", @"摇滚", @"流行", @"古典", @"轻音乐", @"中国风", @"古风", @"爵士", @"电子", @"说唱", @"乡村", @"R&B", @"英伦", @"金属", @"朋克", @"世界音乐"],
                      @"场景":@[@"运动", @"驾驶", @"地铁", @"工作", @"学习", @"夜晚", @"下午茶", @"午休", @"傍晚", @"清晨", @"咖啡厅", @"酒吧", @"夜店", @"旅行", @"校园"],
                      @"情感":@[@"思念", @"喜悦", @"怀旧", @"浪漫", @"伤感", @"激情", @"励志", @"治愈", @"性感", @"寂寞", @"安静", @"感动", @"想哭"],
                      @"主题":@[@"KTV", @"对唱", @"新歌榜", @"DJ", @"爱情", @"90后", @"80后", @"新歌抢先听", @"婚礼", @"毕业", @"经典", @"老歌", @"怀旧", @"中国好声音", @"儿歌", @"小清新", @"动漫", @"原声",@"百度音乐人"]
                      };
    }
    return _titleDic;
}
@end
