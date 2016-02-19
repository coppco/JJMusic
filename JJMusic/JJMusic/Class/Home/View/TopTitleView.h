//
//  TopTitleView.h
//  JJMusic
//
//  Created by coco on 16/2/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTitleView : UIView
HJpropertyAssign(NSInteger selectIndex);  //选择index
HJpropertyCopy(void (^buttonClick)(NSInteger index)); //点击button的block
//初始化
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

//button点击方法
- (void)buttonHasClick:(UIButton *)button;
@end
