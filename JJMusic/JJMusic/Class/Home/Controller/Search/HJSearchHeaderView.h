//
//  HJSearchHeaderView.h
//  JJMusic
//
//  Created by coco on 16/3/22.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SearchHeaderType) {
    SearchHeaderTypeSong = 99,
    SearchHeaderTypeAlbum,
    SearchHeaderTypeArtist
};

@interface HJSearchHeaderView : UIView
HJpropertyStrong(NSArray *array);
HJpropertyAssign(SearchHeaderType open);  //控制开关的
+ (instancetype)searchHeaderView;
HJpropertyCopy(void (^clickBlock)(SearchHeaderType type));  //button点击block
@end
