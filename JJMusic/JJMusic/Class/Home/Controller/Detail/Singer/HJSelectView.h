//
//  HJSelectView.h
//  JJMusic
//
//  Created by coco on 16/3/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJSelectView : UIView
/**
 *  点击时候的block
 */
HJpropertyCopy(void (^clicked)(NSString *title));
@end
