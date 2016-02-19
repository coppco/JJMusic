//
//  KSong.h
//  JJMusic
//
//  Created by coco on 16/2/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface KSong : JSONModel
HJpropertyCopy(NSString *query);// gender,
HJpropertyCopy(NSString *value);// 1,
HJpropertyCopy(NSString *desc);// 女歌手
@end
