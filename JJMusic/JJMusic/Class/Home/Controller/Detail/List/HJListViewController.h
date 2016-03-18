//
//  HJListViewController.h
//  JJMusic
//
//  Created by coco on 16/3/3.
//  Copyright © 2016年 XHJ. All rights reserved.
//   歌单等

#import "HJBaseListController.h"

@interface HJListViewController : HJBaseListController
HJpropertyCopy(NSString *list_id);  //歌单id
HJpropertyStrong(HJListDetailModel * detailModel);
@end
