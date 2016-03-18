//
//  HUDTool.m
//  JJMusic
//
//  Created by coco on 16/2/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HUDTool.h"
#import <MBProgressHUD.h>
#import "MulticolorView.h"  //不同颜色圆弧
#define HUD_DEFAULT_DELAY 1.0f  //默认隐藏时间
#define kHUD_BUNDLE @"HUDImage.bundle"
#define kHudFileName(file) [kHUD_BUNDLE stringByAppendingPathComponent:file]

@interface HUDTool ()
@property (nonatomic, strong)ErrorTipsView *errTipsView;
@end

static MBProgressHUD *sharedHud = nil;
@implementation HUDTool
+ (MBProgressHUD *)shareHud {
    //关联objc_getAssociatedObject
//    MBProgressHUD *hud = objc_getAssociatedObject(self, _cmd);
//    if (!hud) {
//        hud = [[MBProgressHUD alloc] init];
//        objc_setAssociatedObject(self, _cmd, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedHud) {
            //这里只是初始化为windows的bounds,并没有添加到window上面
            sharedHud = [[MBProgressHUD alloc] initWithWindow:getAppWindow()];
        }
    });
    return sharedHud;
}
//显示文字提示框
+ (void)showTextTipsHUDWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [self shareHud];
    [hud removeFromSuperview];
    hud.mode = MBProgressHUDModeText;  //只显示文字
    hud.labelText = title;
    hud.customView = nil;
    [hud.customView removeFromSuperview];
    [getAppWindow() addSubview:hud];
    [getAppWindow() bringSubviewToFront:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:delay <= 0 ? HUD_DEFAULT_DELAY : delay];
    //延迟移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay <= 0 ? HUD_DEFAULT_DELAY : delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [[self shareHud] removeFromSuperview];
    });
}
//显示加载框
+ (void)showLoadingHUDInView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = [self shareHud];
    [hud removeFromSuperview];
    hud.mode = MBProgressHUDModeIndeterminate;  //指示
    hud.labelText = title;
    hud.customView = nil;
    [hud.customView removeFromSuperview];
    hud.frame = view.bounds;
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    [hud show:YES];
}
//加载框是一个不同颜色的圆弧
+ (void)showLoadingHUDCustomViewInView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = [self shareHud];
    [hud removeFromSuperview];
    hud.mode = MBProgressHUDModeCustomView;  //指示
    MulticolorView *multicolorView = [[MulticolorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    hud.customView = multicolorView;
    [multicolorView startAnimation];
    hud.labelText = title;
    hud.frame = view.bounds;
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    [hud show:YES];
}
//显示带图片的提示框, 延时消失
+ (void)showCustomViewImage:(NSString *)image title:(NSString *)title delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [self shareHud];
    [hud removeFromSuperview];
    hud.mode = MBProgressHUDModeCustomView;  //自定义视图
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    hud.customView = imageV;
    hud.labelText = title;
    [getAppWindow() addSubview:hud];
    [getAppWindow() bringSubviewToFront:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:delay <= 0 ? HUD_DEFAULT_DELAY : delay];
    //延迟移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay <= 0 ? HUD_DEFAULT_DELAY : delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [[self shareHud] removeFromSuperview];
    });
}
//四个图片提示框
+ (void)showCustomDepressionViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    [self showCustomViewImage:kHudFileName(@"37x-Weep@2x.png") title:title delay:delay];
}
+ (void)showCustomDoneViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    [self showCustomViewImage:kHudFileName(@"37x-Checkmark@2x.png") title:title delay:delay];
}
+ (void)showCustomSmileViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
     [self showCustomViewImage:kHudFileName(@"37x-Smile@2x.png") title:title delay:delay];
}
+ (void)showCustomWrongViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    [self showCustomViewImage:kHudFileName(@"37x-Wrong@2x.png") title:title delay:delay];
}
+ (void)showCustomExclamationViewWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    [self showCustomViewImage:kHudFileName(@"37x-ExclamationMark@2x.png") title:title delay:delay];
}
//隐藏
+ (void)hideHUD {
    [[self shareHud] hide:YES];
    [[self shareHud] removeFromSuperview];
}

- (void)showTipsOnView:(UIView *)view title:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageName btnTitle:(NSString *)btnTitle btnClick:(void (^)(id))btnClick {
    _errTipsView = [[ErrorTipsView alloc] initWithFrame:view.bounds title:title subTitle:subTitle image:imageName btnTitle:btnTitle btnClick:btnClick];
    [view addSubview:_errTipsView];
    [view bringSubviewToFront:_errTipsView];
}
@end

@interface ErrorTipsView ()
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, copy)NSString *btnTitle;
@property (nonatomic, copy)void (^btnClick)(id);
@end

@implementation ErrorTipsView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)imageName btnTitle:(NSString *)btnTitle btnClick:(void (^)(id))btnClick {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"error_msg_bg"]];
        _title = title;
        _subTitle = subTitle;
        _btnTitle = btnTitle;
        _imageName = imageName;
        _btnClick = btnClick;
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    float y = (self.frame.size.height - 220)/2;
    
    _errorImg = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:_imageName];
    _errorImg.image = image;
//    _errorImg.frame = CGRectMake(self.frame.size.width/2-image.size.width/2, y, image.size.width, image.size.height);
    _errorImg.frame = CGRectMake((self.width - 150) / 2, y, 150, 150);
//        _errorImg.frame = CGRectMake(self.frame.size.width/2-102.5/2, y, 102.5, 137/2);
    [self addSubview:_errorImg];
    
    _errorTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _errorImg.frame.size.height+_errorImg.frame.origin.y+20, self.frame.size.width-20, 25)];
    _errorTitle.font = font(14);
    _errorTitle.textAlignment = 1;
    _errorTitle.textColor = [UIColor blackColor];
    _errorTitle.text = _title;
    _errorTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_errorTitle];
    
    _errorSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _errorTitle.frame.size.height+_errorTitle.frame.origin.y, self.frame.size.width-20, 20)];
    _errorSubtitle.font = font(12);
    _errorSubtitle.textAlignment = 1;
    _errorSubtitle.text = _subTitle;
    _errorSubtitle.textColor = [UIColor grayColor];
    _errorSubtitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_errorSubtitle];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(self.frame.size.width/2-100/2, _errorSubtitle.frame.size.height+_errorSubtitle.frame.origin.y+20,100, 32);
    _btn.layer.cornerRadius = 3.0;
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = [UIColor grayColor].CGColor;
    [_btn setTitle:_btnTitle forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = font(13);
    //    [_btn setBackgroundImage:[UIImage imageNamed:ERROR_BTN] forState:UIControlStateNormal];
    //    [_btn setBackgroundImage:[UIImage imageNamed:@"loadHight.png"] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}
- (void)btnClick:(UIButton *)sender
{
    if (_btnClick) {
        _btnClick(@(sender.tag));
    }
}

@end
