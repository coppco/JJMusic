//
//  HUDTool.h
//  JJMusic
//
//  Created by coco on 16/2/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HUDTool : NSObject

//=======================提示框和加载框==============//
/**
 *  在window上显示文字提示框,延迟消失
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showTextTipsHUDWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  在一个view上显示加载框 默认菊花转
 *
 *  @param view  需要显示加载框的视图,当view时keywindow的时候无法点击
 *  @param title 标题
 */
+(void)showLoadingHUDInView:(UIView *)view title:(NSString *)title;
/**
 *  在一个view上显示加载框 样式是一直转的圆弧
 *
 *  @param view   需要显示加载框的视图,当view时keywindow的时候无法点击
 *  @param title 标题
 */
+ (void)showLoadingHUDCustomViewInView:(UIView *)view title:(NSString *)title;
/**
 *  显示自定义图片的提示框, 延时消失
 *
 *  @param image 图片名称
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showCustomViewImage:(NSString *)image title:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  显示完成图片的提示框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showCustomDoneViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  显示微笑图片的提示框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showCustomSmileViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  显示错误图片的提示框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showCustomWrongViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  显示沮丧图片的提示框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */
+ (void)showCustomDepressionViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  显示感叹号图片的提示框
 *
 *  @param title 标题
 *  @param delay 延迟时间
 */

+ (void)showCustomExclamationViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
/**
 *  隐藏HUD
 */
+ (void)hideHUD;


- (void)showTipsOnView:(UIView *)view title:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageName btnTitle:(NSString *)btnTitle btnClick:(void (^)(id))btnClick;

@end

@interface ErrorTipsView : UIView
@property (nonatomic,readonly) UIImageView *errorImg;  //图片
@property (nonatomic,readonly) UILabel *errorTitle,*errorSubtitle;  //文字
@property (nonatomic,strong)UIButton *btn;  //按钮

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageName btnTitle:(NSString *)btnTitle btnClick:(void (^)(id))btnClick;
@end
