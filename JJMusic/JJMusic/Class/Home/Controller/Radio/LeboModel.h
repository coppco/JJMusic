//
//  LeboModel.h
//  JJMusic
//
//  Created by coco on 16/2/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LeboModel : JSONModel

HJpropertyCopy(NSString *tagid);// 11373552,
HJpropertyCopy(NSString *tag_name);// 音乐故事,
HJpropertyCopy(NSString *tag_pic);// 图片
HJpropertyCopy(NSString <Optional>*name);
@end
