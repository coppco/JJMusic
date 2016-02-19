//
//  RedRadio.h
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RedRadio : JSONModel
HJpropertyCopy(NSString *name);// 华语,
HJpropertyCopy(NSString *channelid);// 32,
HJpropertyCopy(NSString *thumb);// 图片
HJpropertyCopy(NSString *ch_name);// public_yuzhong_huayu,
HJpropertyCopy(NSString *value);// 1,
HJpropertyCopy(NSString *cate_name);// yuzhong,
HJpropertyCopy(NSString *cate_sname);// 语种频道,
HJpropertyCopy(NSString *listen_num);// 21369
@end
