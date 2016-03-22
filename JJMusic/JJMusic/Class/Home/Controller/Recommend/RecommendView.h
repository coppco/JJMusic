//
//  RecommendView.h
//  JJMusic
//
//  Created by coco on 16/2/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RModel;
@interface RecommendView : UIView
HJpropertyStrong(UITableView *tableView);  //表视图
HJpropertyStrong(RModel *recommend);
@property (nonatomic, copy)void (^moreBlock)(NSIndexPath *indexPath);
@end
