//
//  LockIndicatorView.m
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//  

#import "LockIndicatorView.h"
/** 圆线宽 */
#define CoreLockArcLineW  1.0f
/*
 *  圆环颜色
 */
#define CoreLockCircleLineSelectedColor ColorFromRGBA(34,178,246,1)

@interface LockIndicatorView ()
HJpropertyStrong(NSMutableArray *array);
@end

@implementation LockIndicatorView
- (void)setPasswordString:(NSString *)string {
    if (string.length <= 0 || string.length > 9 || [string containsString:@"9"]) {
        return;
    }
    for (int i = 0; i < string.length; i++) {
        NSInteger value = [[string substringWithRange:NSMakeRange(i, 1)] integerValue];
        self.array[value] = @YES;
    }
    //重新绘制
    [self setNeedsDisplay];
}
- (void)reset {
    for (int i = 0; i < self.array.count; i++) {
        self.array[i] = @NO;
    }
    //重新绘制
    [self setNeedsDisplay];
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.array = [NSMutableArray arrayWithObjects:@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
        self.backgroundColor = ColorClear;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置属性
    CGContextSetLineWidth(ctx, CoreLockArcLineW);
    //设置线条颜色
//    [CoreLockCircleLineSelectedColor set];
    
    
    CGFloat marginV = 3.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (rect.size.width - marginV * 2 - padding*2) / 3;
    //添加圆形路径
    for (NSUInteger i=0; i<9; i++) {
        //新建路径
        CGMutablePathRef pathM =CGPathCreateMutable();
        
        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        
        CGFloat rectY = (rectWH + marginV) * col + padding;
        
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        
        CGPathAddEllipseInRect(pathM, NULL, rect);
        //添加路径
        CGContextAddPath(ctx, pathM);
        
        //绘制路径
        if ([self.array[i] boolValue]) {
            [CoreLockCircleLineSelectedColor setFill];
            CGContextFillPath(ctx);
        } else {
            [[UIColor blackColor] setStroke];
            CGContextStrokePath(ctx);
        }
        //释放路径
        CGPathRelease(pathM);
    }
}
@end
