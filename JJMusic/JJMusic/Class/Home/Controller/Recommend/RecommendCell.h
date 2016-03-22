//
//  RecommendCell.h
//  JJMusic
//
//  Created by coco on 16/2/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RModel;
@class HJIndexButton;
typedef NS_ENUM(NSInteger, RType) {
    RTypeScene,  //场景
    RTypeList,  //歌单
    RTypeAlbum,  //新碟
    RTypeSong, //推荐歌曲
    RTypeKing,  //king榜
    RTypeLeBo, //乐播
    RTypeOne  //一个人
};

@interface RecommendCell : UITableViewCell
@property (nonatomic, strong, readonly)HJIndexButton *moreB;
- (void)setRModel:(RModel *)RModel type:(RType)type;
@end
