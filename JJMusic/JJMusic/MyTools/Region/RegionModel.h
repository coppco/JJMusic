//
//  RegionModel.h
//  JJMusic
//
//  Created by coco on 16/1/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionModel : NSObject
HJpropertyCopy(NSString *ID);  //id号
HJpropertyCopy(NSString *name);  //名称
HJpropertyCopy(NSString *parentid);  //上一级
HJpropertyCopy(NSString *zipcode);  //邮编
HJpropertyCopy(NSString *pinyin);  //拼音
HJpropertyCopy(NSString *level);  //层级
HJpropertyCopy(NSString *sort);  //
@end
