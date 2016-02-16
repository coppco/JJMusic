//
//  CarouselView.h
//  JJMusic
//
//  Created by coco on 16/2/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//   轮播图

#import <UIKit/UIKit.h>

@interface CarouselView : UIView
HJpropertyStrong(NSArray *array);  //图片数组
HJpropertyCopy(void (^cellDidSelectAtIndexPath)(UICollectionView *view, NSIndexPath *indexPath));  //点击cell的点击事件
/**
 *  轮播图
 *
 *  @param frame    范围
 *  @param loop     是否轮播
 *  @param picArray 图片数组
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame loop:(BOOL)loop picture:(NSArray <NSString *>*)picArray;
/**
 *  轮播图
 *
 *  @param frame    范围
 *  @param loop     是否轮播
 *  @param picArray 图片数组
 *  @param block 点击cell的block
 *
 *  @return 
 */
-(instancetype)initWithFrame:(CGRect)frame loop:(BOOL)loop picture:(NSArray <NSString *>*)picArray cellSelect:(void (^)(UICollectionView *view, NSIndexPath *indexPath))block;
@end
