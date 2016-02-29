//
//  UIView+HJFrame.h
//  JJMusic
//
//  Created by coco on 16/2/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
////弹窗位置
//typedef NS_ENUM(NSInteger, PostionType) {
//    PostionTypeTop,  //上方
//    PostionTypeCenter,  //中心
//    PostionTypeBottom  //下方
//};
@interface UIView (HJFrame)
/*属性可以设置值也可以获取属性值*/
@property (nonatomic, assign)CGFloat X;  //x
@property (nonatomic, assign)CGFloat Y;  //y
@property (nonatomic, assign)CGFloat width;  //宽
@property (nonatomic, assign)CGFloat height;  //高
@property (nonatomic, assign)CGFloat centerX;  //中心点X
@property (nonatomic, assign)CGFloat centerY;  //中心点Y
@property (nonatomic, assign)CGPoint origin;   //原点
@property (nonatomic, assign)CGSize size;   //大小
/*只可以获取值*/
@property (nonatomic, assign)CGFloat left;  //最左边x
@property (nonatomic, assign)CGFloat right;  //最右边x + width
@property (nonatomic, assign)CGFloat top;  //最上边 y
@property (nonatomic, assign)CGFloat bottom;  //最下边y+height
/**
 *  获取view的controller, 可能为nil
 */
@property (nonatomic, strong)UIViewController *viewController;
/**
 获取一个快照
 */
- (UIImage *)snapshotImage;
//
//#pragma mark - 提示部分
///**
// *  弹出提示框
// *
// *  @param title       标题
// *  @param postionType 提示框的位置
// */
//- (void)showMessageWithTitle:(NSString *)title postion:(PostionType)postionType;
//
@end
