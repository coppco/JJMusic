//
//  HJBaseListController.h
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "BaseViewController.h"
#import "HUDTool.h"
@interface HJBaseListController : BaseViewController
HJpropertyStrong(UIImageView *)imageV;  //上方图片
HJpropertyStrong(UIButton *closeB);  //返回按钮
HJpropertyStrong(UITableView *tableView);

HJpropertyStrong(UILabel *titleUpL);  //上面的标题

//下面的几个label
HJpropertyStrong(UILabel *titleDownL);  //标题
HJpropertyStrong(UILabel *tagL);  //标签
HJpropertyStrong(UILabel *descL); //介绍

HJpropertyStrong(ErrorTipsView *errorView); //加载失败图
- (void)initTableView;
@end
