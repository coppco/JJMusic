//
//  HJButton.m
//  JJMusic
//
//  Created by coco on 16/2/17.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJButton.h"

@implementation HJButton

-(void)layoutSubviews {
    [super layoutSubviews];
    //图片
    CGPoint center = self.imageView.center;
    center.x = self.bounds.size.width / 2;
    center.y = self.imageView.frame.size.height / 2;
    self.imageView.center = center;
    
    //文字
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
