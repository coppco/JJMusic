//
//  RecommendCell.m
//  JJMusic
//
//  Created by coco on 16/2/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "RecommendCell.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "RModel.h"  //推荐model
#import "HJListViewController.h"  //详情页面
//场景电台
@interface SceneView : UIView
HJpropertyStrong(AllScene *allScene);

HJpropertyStrong(UIButton *button);
HJpropertyStrong(UILabel *label);
@end
@implementation SceneView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setAllScene:(AllScene *)allScene {
    _allScene = allScene;
    CGFloat KH = 25;
    CGFloat width = (ViewW(self) - 2 * begin_X  - 3 * KH) / 4;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i <= allScene.action.count - 1;i++) {
        CGFloat x = begin_X + (KH + width) * i;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, width)];
        button.layer.cornerRadius = 20;
        Scene *scene = allScene.action[i];
        [button sd_setImageWithURL:[NSURL URLWithString:scene.icon_ios] forState:(UIControlStateNormal)];
        [button setBackgroundColor:[UIColor redColor]];
        button.tag = i;
        [self addSubview:button];
        
        UILabel *label = [HJCommonTools allocLabelWithTitle:scene.scene_name frame:CGRectMake(x, ViewMaxY(button) + 5, width, 20) font:font(15) color:[UIColor blackColor] alignment:1 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
        label.adjustsFontSizeToFitWidth = YES; //字体大小适应宽度
        [self addSubview:label];
    }
}
@end

@interface ListCell : UICollectionViewCell
HJpropertyStrong(UIImageView *imageV);
HJpropertyStrong(UILabel *titleL);

HJpropertyStrong(id diy);  //歌单推荐
@end
@implementation ListCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleL = [HJCommonTools allocLabelWithTitle:@"" frame:CGRectZero font:font(12) color:[UIColor blackColor] alignment:0 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
        [self.contentView addSubview:_imageV];
        [self.contentView addSubview:_titleL];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(10, 0, ViewW(self.contentView) - 20, ViewH(self.contentView) - 20);
    _titleL.frame = CGRectMake(10, ViewMaxY(_imageV), ViewW(_imageV), 40);
    _titleL.numberOfLines = 0;
    
}
- (void)setDiy:(id)diy {
    _diy = diy;
    
    if ([diy isKindOfClass:[Diy class]]) {
        Diy *dd = (Diy *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic]];
        _titleL.text = dd.title;
    }
    if ([diy isKindOfClass:[Album class]]) {
        Album *dd = (Album *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic_big]];
        _titleL.text = dd.title;
    }
    if ([diy isKindOfClass:[Radio class]]) {
        Radio *dd = (Radio *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic]];
        _titleL.text = dd.title;
    }
    if ([diy isKindOfClass:[Mix_2 class]]) {
        Mix_2 *dd = (Mix_2 *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic]];
        _titleL.text = dd.title;
    }
    if ([diy isKindOfClass:[King class]]) {
        King *dd = (King *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic_big]];
        _titleL.text = dd.title;
    }
    if ([diy isKindOfClass:[Recsong class]]) {
        Recsong *dd = (Recsong *)diy;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:dd.pic_premium]];
        _titleL.text = STRFORMAT(@"%@-%@", dd.title, dd.author);
    }
}

@end
//歌单推荐
@interface ListView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
HJpropertyStrong(UICollectionView *collectionView);
HJpropertyStrong(UICollectionViewFlowLayout *layout);
HJpropertyStrong(UIView *imageLabel);  //图片和label

HJpropertyStrong(NSArray *diy);
@end

@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = ColorClear;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册单元格
        [_collectionView registerClass:[ListCell class] forCellWithReuseIdentifier:@"ListCell"];
        [self addSubview:_collectionView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _layout.itemSize = CGSizeMake(ViewW(self) / 3 - 10, ViewW(self) / 3 - 10);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 27;
    _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView.frame = self.bounds;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _diy.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    cell.diy = _diy[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if ([_diy[indexPath.item] isKindOfClass:[Diy class]]) {
        //歌单
        HJListViewController *ListVC = [[HJListViewController alloc] init];
        ListVC.list_id = [_diy[indexPath.item] listid];
        [self.viewController.navigationController pushViewController:ListVC animated:YES];
    }
}
- (void)setDiy:(NSArray *)diy {
    _diy = diy;
    [_collectionView reloadData];
}
@end

@interface RecommendCell ()
HJpropertyAssign(RType)type;
HJpropertyStrong(RModel *)model;

//都有
HJpropertyStrong(UILabel *titleL); //标题
HJpropertyStrong(UIButton *moreB);  //更多

//场景
HJpropertyStrong(SceneView *sceneView);
//歌单  新碟上架
HJpropertyStrong(ListView *listView);

@end

@implementation RecommendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleL = [HJCommonTools allocLabelWithTitle:@"" frame:CGRectZero font:font(15) color:[UIColor blackColor] alignment:1 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
        [self.contentView addSubview:_titleL];
        
        _moreB = [HJCommonTools allocButtonWithFrame:CGRectZero title:@"more" titleColor:[UIColor blackColor] font:font(15) normalImage:nil highImage:nil normalBackImage:nil highBackImage:nil];
        _moreB.layer.borderColor = [UIColor blackColor].CGColor;
        _moreB.layer.borderWidth = 0.5;
        [self.contentView addSubview:_moreB];
        
        _sceneView = [[SceneView alloc] initWithFrame:CGRectZero];
        _listView = [[ListView alloc] initWithFrame:CGRectMake(0, 0, 100, 0)];
        [self.contentView addSubview:_sceneView];
        [self.contentView addSubview:_listView];
        _listView.hidden = YES;
        _sceneView.hidden = YES;
        _moreB.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleL.frame = CGRectMake((ViewW(self) - 180) / 2, 10, 180, 25);
    switch (_type) {
        case RTypeScene:  //场景
        {
            _sceneView.hidden = NO;
            _listView.hidden = YES;
            _moreB.hidden = NO;
            _sceneView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), (ViewW(self) - 2 * begin_X - 90) / 4 + 25);
            _sceneView.allScene = _model.scene;
            self.titleL.text = @"场景电台";
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_sceneView) + 20, 100, 25);
        }
            break;
        case RTypeList:  //歌单推荐 
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = NO;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 270);
            _listView.diy = _model.diy;
            self.titleL.text = @"歌单推荐";
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_listView) + 20, 100, 25);
        }
            break;
            case RTypeAlbum:  //新碟
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = NO;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 270);
            _listView.diy = _model.album;
            self.titleL.text = @"新碟上架";
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_listView) + 20, 100, 25);
        }
            break;
        case RTypeLeBo:  //乐播
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = NO;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 270);
            _listView.diy = _model.radio;
            self.titleL.text = @"乐播节目";
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_listView) + 20, 100, 25);
        }
            break;
        case RTypeOne:  //一个人
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = YES;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 270);
            _listView.diy = _model.mix_2;
            self.titleL.text = @"一个人的时候听";
        }
            break;
        case RTypeKing:  //百度King榜
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = NO;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 130);
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_listView) + 20, 100, 25);
            _listView.diy = _model.king;
            self.titleL.text = @"百度King榜";
        }
            break;
        case RTypeSong:  //推荐歌曲
        {
            _sceneView.hidden = YES;
            _listView.hidden = NO;
            _moreB.hidden = NO;
            _listView.frame = CGRectMake(0, ViewMaxY(_titleL) + 10, ViewW(self), 130);
            _moreB.frame = CGRectMake((ViewW(self) - 100) / 2, ViewMaxY(_listView) + 20, 100, 25);
            _listView.diy = [NSArray arrayWithObjects:_model.recsong[0], _model.recsong[1], _model.recsong[2], nil];
            self.titleL.text = @"今日推荐歌曲";
        }
            break;
    }
}
- (void)setRModel:(RModel *)RModel type:(RType)type {
    _model = RModel;
    _type = type;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
