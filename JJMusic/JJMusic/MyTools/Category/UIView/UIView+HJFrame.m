//
//  UIView+HJFrame.m
//  JJMusic
//
//  Created by coco on 16/2/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "UIView+HJFrame.h"

//#define DisPlayTime  1.5       //弹窗显示存在时间
//static UILabel *messageLabel = nil;
@implementation UIView (HJFrame)
//- (UILabel *)sharedLabel {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (!messageLabel) {
//            messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.window.width, 0)];
//            messageLabel.backgroundColor = [UIColor blackColor];
//            messageLabel.textColor = [UIColor whiteColor];
//            messageLabel.textAlignment = NSTextAlignmentCenter;
//            messageLabel.layer.cornerRadius = 5;
//            messageLabel.layer.masksToBounds = YES;
//            messageLabel.numberOfLines = 0;
//            messageLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
//            messageLabel.hidden = YES;
//            [self.window addSubview:messageLabel];
//        }
//    });
//    return messageLabel;
//}
//   x坐标
- (CGFloat)X {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)X {
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
//  y坐标
- (CGFloat)Y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)Y {
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
//width 宽
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
//height  高
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
//centerX  中心点X
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
//centerY  中心点Y
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
//left  最左边
- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}
- (void)setLeft:(CGFloat)left {}
//right 最右边
- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}
- (void)setRight:(CGFloat)right {}
//top 最上边
- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}
-(void)setTop:(CGFloat)top {}
//bottom 最下边
- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}
- (void)setBottom:(CGFloat)bottom {}
//origin
- (CGPoint)origin {
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
//size
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
//viewcontroller
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)setViewController:(UIViewController *)viewController {}
//快照
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
////提示部分
//- (void)showMessageWithTitle:(NSString *)title postion:(PostionType)postionType {
//    CGFloat messageY;
//    switch (postionType) {
//        case PostionTypeTop:
//            messageY = 100;
//            break;
//        case PostionTypeCenter:
//            messageY = self.window.height/2-12.5;
//            break;
//        case PostionTypeBottom:
//            messageY = self.window.height-100;
//            break;
//        default:
//            break;
//    }
//    [self sharedLabel];
//    messageLabel.hidden = NO;
//    messageLabel.text = title;
//    [messageLabel sizeToFit];
//    messageLabel.frame = CGRectMake(self.window.center.x-messageLabel.width/2, messageY, messageLabel.width, messageLabel.height);
//    [UIView animateWithDuration:0.15 animations:^{
//        messageLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            messageLabel.transform = CGAffineTransformMakeScale(1, 1);
//        }];
//    }];
//    [self hiddenMessage:messageLabel];
//}
////隐藏label
//- (void)hiddenMessage:(UILabel *)messageLable{
//    __block UILabel *label = messageLable;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DisPlayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.1 animations:^{
//            label.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        } completion:^(BOOL finished) {
//            label.hidden = YES;;
//        }];
//    });
//}
@end
