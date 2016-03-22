//
//  HJSingerController.h
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJBaseListController.h"
#import "SingerModel.h"  //歌手信息
@interface HJSingerController : HJBaseListController
HJpropertyStrong(SingerModel *singer);  //歌手ID
@end
