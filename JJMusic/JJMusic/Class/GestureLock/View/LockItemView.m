//
//  LockItemView.m
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//  使用Quartz 2D绘制

#import "LockItemView.h"

@interface LockItemView  ()
/**
 *  外环rect
 */
HJpropertyAssign(CGRect calRect);
/**
 *  选中的实心圆rect
 */
HJpropertyAssign(CGRect selectedRect);
/**
 *  角度
 */
HJpropertyAssign(CGFloat angle);
@end

@implementation LockItemView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorClear;
    }
    return self;
}

//重新绘制
- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //上下文旋转
    [self transFormCtx:ctx rect:rect];
    
    //上下文属性设置
    [self propertySetting:ctx];
    
    //外环:区分选中和非选中
    [self circleNormal:ctx rect:rect];
    
    //选中情况下. 绘制
    if (_selected) {
        //实心圆绘制
        [self circleSelected:ctx rect:rect];
        
        //三角形：方向标识
        [self directFlag:ctx rect:rect];
    }
}
/*
 *  三角形：方向标识
 */
-(void)directFlag:(CGContextRef)ctx rect:(CGRect)rect {
    
    if(self.direction == 0) return;
    
    //新建路径：三角形
    CGMutablePathRef trianglePathM = CGPathCreateMutable();
    
    CGFloat marginSelectedCirclev = 4.0f;
    CGFloat w =8.0f;
    CGFloat h =5.0f;
    CGFloat topX = rect.origin.x + rect.size.width * .5f;
    CGFloat topY = rect.origin.y +(rect.size.width *.5f - h - marginSelectedCirclev - self.selectedRect.size.height *.5f);
    
    CGPathMoveToPoint(trianglePathM, NULL, topX, topY);
    
    //添加左边点
    CGFloat leftPointX = topX - w *.5f;
    CGFloat leftPointY =topY + h;
    CGPathAddLineToPoint(trianglePathM, NULL, leftPointX, leftPointY);
    
    //右边的点
    CGFloat rightPointX = topX + w *.5f;
    CGPathAddLineToPoint(trianglePathM, NULL, rightPointX, leftPointY);
    
    //将路径添加到上下文中
    CGContextAddPath(ctx, trianglePathM);
    
    //绘制圆环
    CGContextFillPath(ctx);
    
    //释放路径
    CGPathRelease(trianglePathM);
}
/**
 *  实心圆: 选中
 *
 *  @param ctx  上下文
 *  @param rect 范围
 */
- (void)circleSelected:(CGContextRef)ctx rect:(CGRect)rect {
    //新建路径: 
    CGMutablePathRef circlePath = CGPathCreateMutable();
    
    //绘制圆形
    CGPathAddEllipseInRect(circlePath, NULL, self.selectedRect);
    if (_wrong) {
        [[UIColor redColor] set];
    } else {
        [CoreLockCircleLineSelectedColor set];
    }
    
    //将路径添加到上下文中
    CGContextAddPath(ctx, circlePath);
  
    //绘制圆环  CGContextFillPath实心圆
    CGContextFillPath(ctx);
    
    //释放路径
    CGPathRelease(circlePath);
}
/**
 *  外环: 普通
 *
 *  @param ctx  上下文
 *  @param rect 范围
 */
- (void)circleNormal:(CGContextRef)ctx rect:(CGRect)rect {
    //新建路径:外环
    CGMutablePathRef loopPath = CGPathCreateMutable();
    
    //添加一个圆环路径
    CGRect calRect = self.calRect;
    CGPathAddEllipseInRect(loopPath, NULL, calRect);
    if (_selected  && !_wrong) {
        [[CoreLockCircleLineSelectedCircleColor colorWithAlphaComponent:0.1] set];
    }
    if (_wrong) {
        [[[UIColor redColor] colorWithAlphaComponent:0.1] set];
    }
    
    //将路径添加到上下文中
    CGContextAddPath(ctx, loopPath);
    
    //绘制圆环  CGContextStrokePath空心圆  CGContextFillPath实心圆
    if (_selected) {
        CGContextFillPath(ctx);
    } else {
        CGContextStrokePath(ctx);
    }
    
    //释放路径
    CGPathRelease(loopPath);
}
/**
 *  上下文属性设置
 *
 *  @param ctx 上下文
 */
- (void)propertySetting:(CGContextRef)ctx {
    //设置线宽
    CGContextSetLineWidth(ctx, CoreLockArcLineW);
    
    //设置颜色
    UIColor *color = nil;
    if (_selected) {
        color = CoreLockCircleLineSelectedColor;
    } else {
        color = CoreLockCircleLineNormalColor;
    }
    if (_wrong) {
        color = [UIColor redColor];
    }
    [color set];
}
/**
 *  上下文旋转
 *
 *  @param ctx  上下文
 *  @param rect rect范围
 */
- (void)transFormCtx:(CGContextRef)ctx rect:(CGRect)rect {
    if (0 == self.direction) {
        return;
    }
    CGFloat translateXY = rect.size.width * 0.5f;
    //平移
    CGContextTranslateCTM(ctx, translateXY, translateXY);
    CGContextRotateCTM(ctx, self.angle);
    
    //再平移回来
    CGContextTranslateCTM(ctx, -translateXY, -translateXY);
}
//选择变蓝色
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    [self setNeedsDisplay];
}
//错误变红色
- (void)setWrong:(BOOL)wrong {
    _wrong = wrong;
    [self setNeedsDisplay];
}
-(CGRect)calRect{
    
    if(CGRectEqualToRect(_calRect, CGRectZero)){
        
        CGFloat lineW = CoreLockArcLineW;
        
        CGFloat sizeWH = self.bounds.size.width - lineW;
        CGFloat originXY = lineW *.5f;
        
        //添加一个圆环路径
        _calRect = (CGRect){CGPointMake(originXY, originXY),CGSizeMake(sizeWH, sizeWH)};
        
    }
    
    return _calRect;
}

-(CGRect)selectedRect{
    
    if(CGRectEqualToRect(_selectedRect, CGRectZero)){
        
        CGRect rect = self.bounds;
        
        CGFloat selectRectWH = rect.size.width * CoreLockArcWHR;
        
        CGFloat selectRectXY = rect.size.width * (1 - CoreLockArcWHR) *.5f;
        
        _selectedRect = CGRectMake(selectRectXY, selectRectXY, selectRectWH, selectRectWH);
    }
    
    return _selectedRect;
}

- (void)setDirection:(LockItemDirection)direction {
    _direction = direction;
    self.angle = M_PI_4 * (direction - 1);
    
    [self setNeedsDisplay];
}
@end
