//
//  HJSingleModel.h
//  JJMusic
//
//  Created by coco on 16/3/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HJHotListDetailMoel.h"  //
@interface HJSingleModel : JSONModel
HJpropertyCopy(NSArray <HotListModel>*songlist);
HJpropertyCopy(NSString *songnums);
HJpropertyCopy(NSString *havemore);
HJpropertyCopy(NSString *error_code);
@end
