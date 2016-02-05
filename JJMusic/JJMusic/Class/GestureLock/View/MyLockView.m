//
//  MyLockView.m
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "MyLockView.h"
#define marginValue 36   //边缘
@interface MyLockView ()
/**
 *  存放itemView的数组
 */
HJpropertyStrong(NSMutableArray *itemViewsArray);
/**
 *  临时密码
 */
HJpropertyCopy(NSMutableString *tempPWD);
HJpropertyAssign(BOOL isWrongColor);  //错误颜色
HJpropertyAssign(BOOL isDrawing);  //正在画画
HJpropertyStrong(NSTimer *timer);


@end

@implementation MyLockView
#pragma mark - 初始化方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //九宫格
        self.backgroundColor = ColorClear;
        [self initLockItemViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //九宫格
        self.backgroundColor = ColorClear;
        [self initLockItemViews];
    }
    return self;
}
#pragma mark - 添加九宫格
- (void)initLockItemViews {
    for (int i = 0; i < 9; i++) {
        LockItemView *itemView = [[LockItemView alloc] init];
        [self addSubview:itemView];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //宽
    CGFloat itemViewWH = (self.frame.size.width - 4 * marginValue) / 3.0f;
    
    //相当于for-in, 但是可以得到下标,以及控制停止
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LockItemView class]]) {
            NSUInteger row = idx % 3;  //行
            NSUInteger col = idx / 3;  //列
            CGFloat x = marginValue * (row + 1) + row * itemViewWH;
            CGFloat y = marginValue * (col) + col * itemViewWH;
            CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
            //设置tag值
            obj.tag = idx;
            obj.frame = frame;
        }
    }];
}
#pragma mark - getter方法
- (NSMutableArray *)itemViewsArray {
    if (_itemViewsArray == nil) {
        _itemViewsArray = [NSMutableArray array];
    }
    return _itemViewsArray;
}
- (NSMutableString *)tempPWD {
    if (_tempPWD == nil) {
        _tempPWD = [NSMutableString string];
    }
    return _tempPWD;
}
#pragma mark - drawRect方法 绘制线条
- (void)drawRect:(CGRect)rect {
    //设置为空直接返回
    if (_itemViewsArray == nil || _itemViewsArray.count == 0) {
        return;
    }
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加路径
    CGContextAddRect(ctx, rect);
    
    //添加圆形路径  注释这部分去掉可以从中心点开始
    //遍历所有的itemVeiw
    [_itemViewsArray enumerateObjectsUsingBlock:^(LockItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGContextAddEllipseInRect(ctx, obj.frame);
    }];
    //裁剪
    CGContextEOClip(ctx);
    
    
    //新建路径: 线条
    CGMutablePathRef pathM = CGPathCreateMutable();
    
    //设置上下文属性
    //1.设置线条颜色
    _isWrongColor ? [[UIColor redColor] set] : [CoreLockCircleLineSelectedCircleColor set];
    
    //线条转角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 5.0f);
    
    //遍历所有的itemView
    [_itemViewsArray enumerateObjectsUsingBlock:^(LockItemView *itemView, NSUInteger idx, BOOL *stop) {
        
        CGPoint directPoint = itemView.center;
        
        if(idx == 0){//第一个
            
            //添加起点
            CGPathMoveToPoint(pathM, NULL, directPoint.x, directPoint.y);
            
        }else{//其他
            
            //添加路径线条
            CGPathAddLineToPoint(pathM, NULL, directPoint.x, directPoint.y);
        }
    }];
    
    //将路径添加到上下文
    CGContextAddPath(ctx, pathM);
    
    //渲染路径
    CGContextStrokePath(ctx);
    
    //释放路径
    CGPathRelease(pathM);
}
#pragma mark - touch方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _isDrawing = NO;
    // 如果是错误色才重置(timer重置过了)
    if (_isWrongColor) {
        [self clearStatus];
    }
    //解锁处理方法
    [self lockWithtouches:touches];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _isDrawing = YES;
    //解锁处理方法
    [self lockWithtouches:touches];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //手势结束
    [self gestureEnd];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //手势结束
    [self gestureEnd];
}
#pragma mark - 手势结束
/*
 *  手势结束,判断字符串
 */
-(void)gestureEnd{
    _isDrawing = NO;
    if (self.checkPassword) {
        self.checkPassword(self.tempPWD);
    }
    //重置
//    [self clearStatus];
}
- (void)clearStatus {
    
    if (!_isDrawing) {
        self.userInteractionEnabled = YES;
        _isWrongColor = NO;
        for (LockItemView *itemView in self.itemViewsArray) {
            itemView.selected = NO;
            itemView.wrong = NO;
            //清空方向
            itemView.direction = 0;
        }
        //清空数组所有对象
        [self.itemViewsArray removeAllObjects];
        //再绘制
        [self setNeedsDisplay];
        //清空密码
        self.tempPWD = nil;
    }
}
#pragma mark - 显示错误信息
- (void)showErrorCircles:(NSString *)string {
    _isWrongColor = YES;
    for (LockItemView *view in self.itemViewsArray) {
        view.wrong = YES;
    }
    [self setNeedsDisplay];
    [self timerUpdate];
}
- (void)timerUpdate{
    _timer = nil;
    self.userInteractionEnabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(clearStatus)
                                            userInfo:nil
                                             repeats:NO];
}
#pragma mark - 解锁处理方法
- (void)lockWithtouches:(NSSet<UITouch *> *)touches {
    //取出触摸点
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    LockItemView *view = [self lockItemViewWithLocation:loc];
    //如果为空就返回
    if (view == nil) {
        return;
    }
    //如果已经存在也返回
    if ([self.itemViewsArray containsObject:view]) {
        return;
    }
    //添加
    [self.itemViewsArray addObject:view];
   
    //记录密码

    [self.tempPWD appendFormat:@"%ld", (long)view.tag];

    //计算方向：每添加一次itemView就计算一次
    [self calDirect];
    
    //item处理
    [self itemHandel:view];
}
/**
 *  根据点取出LockItemView
 *
 *  @param location 点
 *
 *  @return
 */
- (LockItemView *)lockItemViewWithLocation:(CGPoint)location {
    LockItemView *lockItemView = nil;
    for (LockItemView *subview in self.subviews) {
        if (!CGRectContainsPoint(subview.frame, location)) {
            continue;
        }
        lockItemView = subview;
    }
    return lockItemView;
}
/**
 *  itemView处理
 *
 *  @param itemView itemView
 */
-(void)itemHandel:(LockItemView *)itemView{
    
    //选中
    itemView.selected = YES;
    
    //绘制
    [self setNeedsDisplay];
}
/*
 *  计算方向：每添加一次itemView就计算一次
 */
-(void)calDirect{
    
    NSUInteger count = _itemViewsArray.count;
    
    if(_itemViewsArray == nil || count <= 1) return;
    
    //取出最后一个对象
    LockItemView *last_1_ItemView = _itemViewsArray.lastObject;
    
    //倒数第二个
    LockItemView *last_2_ItemView =_itemViewsArray[count -2];
    
    //计算倒数第二个的位置
    CGFloat last_1_x = last_1_ItemView.frame.origin.x;
    CGFloat last_1_y = last_1_ItemView.frame.origin.y;
    CGFloat last_2_x = last_2_ItemView.frame.origin.x;
    CGFloat last_2_y = last_2_ItemView.frame.origin.y;
    
    //倒数第一个itemView相对倒数第二个itemView来说
    //正上
    if(last_2_x == last_1_x && last_2_y > last_1_y) {
        last_2_ItemView.direction = LockItemDirectionUp;
    }
    
    //正左
    if(last_2_y == last_1_y && last_2_x > last_1_x) {
        last_2_ItemView.direction = LockItemDirectionLeft;
    }
    
    //正下
    if(last_2_x == last_1_x && last_2_y < last_1_y) {
        last_2_ItemView.direction = LockItemDirectionDown;
    }
    
    //正右
    if(last_2_y == last_1_y && last_2_x < last_1_x) {
        last_2_ItemView.direction = LockItemDirectionRight;
    }
    
    //左上
    if(last_2_x > last_1_x && last_2_y > last_1_y) {
        last_2_ItemView.direction = LockItemDirectionLeftUp;
    }
    
    //右上
    if(last_2_x < last_1_x && last_2_y > last_1_y) {
        last_2_ItemView.direction = LockItemDirectionRightUp;
    }
    
    //左下
    if(last_2_x > last_1_x && last_2_y < last_1_y) {
        last_2_ItemView.direction = LockItemDirectionLeftDown;
    }
    
    //右下
    if(last_2_x < last_1_x && last_2_y < last_1_y) {
        last_2_ItemView.direction = LockItemDirectionRightDown;
    }
    
}
@end
