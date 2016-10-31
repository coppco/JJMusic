
//
//  XCHudTool.m
//  甲乙
//
//  Created by 王 晓超 on 13-3-25.
//  Copyright (c) 2013年 王 晓超. All rights reserved.
//
 
#import "XCHudTool.h"
#import "MBProgressHUD.h"


#define kHudBundleName @"HUDImage.bundle"
#define kHudFileName(file) [kHudBundleName stringByAppendingPathComponent:file]

@implementation XCHudTool
static XCHudTool *hudTool;
static MBProgressHUD *hud = nil;
static BOOL isAddHud;

- (MBProgressHUD *)sharedManager
{

	@synchronized(hud)
    {
		if(!hud)
        {
			hud = [[MBProgressHUD alloc]
                   initWithWindow:[UIApplication sharedApplication].keyWindow];
            hud.userInteractionEnabled = YES;
            isAddHud = NO;
		}
	}
	return hud;
}

+ (XCHudTool *)sharedHud
{
    if (hudTool == nil)
    {
        hudTool = [[XCHudTool alloc] init];
    }
    return hudTool;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}



- (void)keyboardWillShow
{
    _keyBoardShow =YES;
}
- (void)keyboardWillHide
{
    _keyBoardShow = NO;
}


- (void)removeHudWindow
{
    [[self sharedManager] removeFromSuperview];
    isAddHud = NO;
}
- (void)addHudWindow:(MBProgressHUD *)hudMsg
{
    if (isAddHud == NO)
    {
        UIWindow *window = nil;
        if (_keyBoardShow == NO)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        else
            window = [[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1];
        [window addSubview:hudMsg];
        [window bringSubviewToFront:hudMsg];
        isAddHud = YES;
    }
}
- (void)showTextHud:(NSString *)text
{
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudWindow:hudMsg];
    
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.labelText = text;
    [hudMsg show:YES];
}
- (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudWindow:hudMsg];
    
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kHudFileName(@"37x-Checkmark.png")]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
- (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudWindow:hudMsg];
    
//    hudMsg.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kHudFileName(@"37x-Wrong.png")]] autorelease];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    hudMsg.labelFont = [UIFont boldSystemFontOfSize:11];
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
- (void)showSmileHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudWindow:hudMsg];
    
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kHudFileName(@"37x-Smile.png")]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

- (void)addHudInView:(MBProgressHUD *)hudMsg inView:(UIView *)inView
{
    if (isAddHud == NO)
    {
        [inView addSubview:hudMsg];
        [inView bringSubviewToFront:hudMsg];
        isAddHud = YES;
    }
}

- (void)showTextHud:(NSString *)text inView:(UIView *)inView
{
    
    //这样初始化会添加到当前view上，不能对view山的视图进行操作，但可以返回，中断请求
    MBProgressHUD *hudMsg =  [self sharedManager];
    [self addHudInView:hudMsg inView:inView];
    
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.labelText = text;
    hudMsg.labelFont = [UIFont systemFontOfSize:11];
    [hudMsg show:YES];
}
- (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay inView:(UIView *)inView
{
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudInView:hudMsg inView:inView];
    
    hudMsg.customView = [[UIImageView alloc] initWithImage:nil];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    hudMsg.labelFont = [UIFont boldSystemFontOfSize:11];
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
- (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay inView:(UIView *)inView
{
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudInView:hudMsg inView:inView];
    
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kHudFileName(@"37x-Wrong.png")]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
- (void)showSmileHud:(NSString *)text delay:(NSTimeInterval)dalay inView:(UIView *)inView
{
    MBProgressHUD *hudMsg = [self sharedManager];
    [self addHudInView:hudMsg inView:inView];
    
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kHudFileName(@"37x-Smile.png")]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}


- (void)hideHud
{
    [[self sharedManager] hide:YES];
    [self removeHudWindow];
}


@end
