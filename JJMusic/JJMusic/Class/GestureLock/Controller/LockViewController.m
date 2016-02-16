//
//  LockViewController.m
//  JJMusic
//
//  Created by coco on 16/2/2.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "LockViewController.h"
#import "MyLockView.h"  //田字形解锁图
#import "LockIndicatorView.h"  //指示图
#import "LockModel.h" //保存密码等
#define LockRetryTimes 5 // 最多重试几次

@interface LockViewController ()
HJpropertyAssign(int reTryTimes);  //重试次数

HJpropertyStrong(UILabel *tipsLabel);  //提示label
HJpropertyStrong(LockIndicatorView *indicatorView);//指示图
HJpropertyStrong(MyLockView *lockView);  //九宫格
HJpropertyStrong(UIButton *reStart);  //重新开始设置
HJpropertyStrong(UIButton *otherButon); //其他账号按钮
HJpropertyStrong(UIButton *forgetButton);  //忘记手势密码button

HJpropertyStrong(UIImageView *previousImageV); //上一界面截图
HJpropertyStrong(UIImageView *currentImageV); //本界面截图

HJpropertyCopy(NSString* passwordSaved); // 本地存储的密码
HJpropertyCopy(NSString* passwordOld); // 旧密码
HJpropertyCopy(NSString* passwordNew); // 新密码
HJpropertyCopy(NSString* passwordconfirm); // 确认密码
@end

@implementation LockViewController
- (instancetype)initWithType:(LockViewType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPreviousImage];
    self.reStart = [HJCommonTools allocButtonWithFrame:CGRectMake(0, 0, 40, 40) title:@"重设" titleColor:[UIColor redColor] font:font(15) normalImage:nil highImage:nil normalBackImage:nil highBackImage:nil];
    [self.reStart addTarget:self action:@selector(reStart:) forControlEvents:(UIControlEventTouchUpInside)];
    self.reStart.tag = 10000;
    self.reStart.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.reStart];
    switch (_type) {
        case LockViewTypeCreate:
        {
            _tipsLabel.text = @"绘制解锁图案";
        }
            break;
        case LockViewTypeCheck:
        {
            _tipsLabel.text = @"请输入解锁密码";
            self.otherButon.hidden = NO;
            self.forgetButton.hidden = NO;
            CGRect frame = self.tipsLabel.frame;
            frame.origin.y +=30;
            self.tipsLabel.frame = frame;
        }
            break;
        case LockViewTypeModify:
        {
            _tipsLabel.text = @"请输入原来的密码";
        }
            break;
        case LockViewTypeClean:
        {
            _tipsLabel.text = @"请输入密码以清除";
        }
            break;
    }
    //尝试机会
    self.reTryTimes = LockRetryTimes;
    self.passwordOld = nil;
    self.passwordNew = nil;
    self.passwordconfirm = nil;
    
    //本地保存的密码
    self.passwordSaved = [LockModel getPassword];
    XHJLog(@"本地密码%@", self.passwordSaved);
    if (_type == LockViewTypeCreate || _type == LockViewTypeModify) {
        self.indicatorView.hidden = NO;
    } else {
        self.indicatorView.hidden = YES;
    }
}
- (void)reStart:(UIButton *)button {
    switch (button.tag) {
        case 10000:
        {
            //重设手势密码
            self.passwordNew = nil;
            self.passwordconfirm = nil;
            [self updateTipsLabelWithTitle:@"绘制解锁图案"];
            [self.indicatorView reset]; //重置指示器
            self.reStart.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = ColorFromRGBA(13,52,89,1);
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化视图
    [self initSubviews];
}
- (void)initSubviews {
    //上一界面
    self.previousImageV = [HJCommonTools allocImageViewWith:nil frame:self.view.bounds contentMode:0];
    [self.view addSubview:self.previousImageV];
    //当前界面
    self.currentImageV = [HJCommonTools allocImageViewWith:nil frame:self.view.bounds contentMode:0];
    [self.view addSubview:self.currentImageV];
    
    CGFloat yy;
    //是否是模态进来的
    if (![self isPresent]) {
        yy = 10 + 64 ;
    } else {
        yy = 30;
    }
    //提示label
    self.tipsLabel = [HJCommonTools allocLabelWithTitle:@"请滑动创建手势密码" frame:CGRectMake(0, yy, ViewW(self.view), 30) font:font(16) color:ColorFromString(@"EE7600") alignment:1 keyWords:nil keyWordsColor:nil keyWordsFont:nil underLine:NO];
    [self.view addSubview:self.tipsLabel];
    //指示器
    self.indicatorView = [[LockIndicatorView alloc] initWithFrame:CGRectMake((ViewW(self.view) - 50) * 0.5, ViewMaxY(self.tipsLabel) + 10, 40, 40)];
    [self.view addSubview:self.indicatorView];
    //手势锁
    self.lockView = [[MyLockView alloc] initWithFrame:CGRectMake(0, ViewMaxY(self.indicatorView) + 20, ViewW(self.view), ViewW(self.view) - 72)];
    WeakObject(weakSelf);  //定义weak的self
    [self.lockView setCheckPassword:^(NSString *password) {
        XHJLog(@"密码:%@", password);
        [weakSelf lockPassword:password];
    }];
    [self.view addSubview:self.lockView];
    
    //other按钮
    self.otherButon = [HJCommonTools allocButtonWithFrame:CGRectMake(0, ViewH(self.view)- 35, ViewW(self.view) / 3, 30) title:@"登陆其他账号?" titleColor:[UIColor blueColor] font:font(16) normalImage:nil highImage:nil normalBackImage:nil highBackImage:nil];
    self.otherButon.hidden = YES;
    [self.view addSubview:self.otherButon];
    //忘记密码
    self.forgetButton = [HJCommonTools allocButtonWithFrame:CGRectMake(ViewW(self.view) / 3 * 2, ViewY(self.otherButon), ViewW(self.otherButon), ViewH(self.otherButon)) title:@"忘记手势密码?" titleColor:[UIColor blueColor] font:font(16) normalImage:nil highImage:nil normalBackImage:nil highBackImage:nil];
    self.forgetButton.hidden = YES;
    [self.view addSubview:self.forgetButton];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 判断密码 
- (void)lockPassword:(NSString *)password {
    switch (_type) {
        case LockViewTypeCheck:
        {
            //检查密码
            [self checkPassword:password];
        }
            break;
        case LockViewTypeCreate:
        {
            //创建密码
            [self createPassword:password];
        }
            break;
        case LockViewTypeModify:
        {
            [self modifyPassword:password];
        }
            break;
        case LockViewTypeClean:
        {
            [self cleanPassword:password];
        }
            break;
    }
}
//清除密码
- (void)cleanPassword:(NSString *)password {
    if ([self.passwordSaved isEqualToString:password]) {
        [LockModel saveLockPassword:nil];
        [self hide];
        alert(@"清除密码成功");
    }
}
//修改密码
- (void)modifyPassword:(NSString *)password {
    //验证旧密码
    if (self.passwordOld.length == 0 && [password isEqualToString:self.passwordSaved]) {
        self.passwordOld = password;
        [self updateTipsLabelWithTitle:@"请输入新密码"];
        [self.lockView clearStatus]; //清除状态
    } else if (self.passwordOld.length != 0) {
        [self createPassword:password];
    } else if(self.passwordOld.length == 0 && ![password isEqualToString:self.passwordSaved]) {
        //验证密码错误
        _reTryTimes--;
        if (_reTryTimes > 0) {
            [self showWrongMSG:STRFORMAT(@"手势密码错误,还可以输入%d次", _reTryTimes) password:password];
        } else {
            [self showWrongMSG:@"请重新登录" password:password];
            alert(STRFORMAT(@"你已经连续%d次输错密码,手势密码已关闭,请重新登录", LockRetryTimes));
        }
    }
}
//检查密码
- (void)checkPassword:(NSString *)password {
    //验证密码正确
    if ([password isEqualToString:self.passwordSaved]) {
            [self hide];
    } else {
        //验证密码错误
        _reTryTimes--;
        if (_reTryTimes > 0) {
            [self showWrongMSG:STRFORMAT(@"手势密码错误,还可以输入%d次", _reTryTimes) password:password];
        } else {
            [self showWrongMSG:@"请重新登录" password:password];
            alert(STRFORMAT(@"你已经连续%d次输错密码,手势密码已关闭,请重新登录", LockRetryTimes));
        }
    }
}
//创建密码
- (void)createPassword:(NSString *)password {
    if (password.length < 4) {
        [self showWrongMSG:@"至少连接4个点" password:password];
    } else if (self.passwordNew.length == 0 && self.passwordconfirm.length == 0) {
        //第一次输入密码
        self.passwordNew = password;
        [self.lockView clearStatus];  //清除手势状态
        [self updateTipsLabelWithTitle:@"请再次绘制解锁密码"];
        [self.indicatorView setPasswordString:password];  //指示器显示
    } else if (self.passwordNew.length != 0 && self.passwordconfirm.length == 0) {
        self.passwordconfirm = password;
        if ([self.passwordconfirm isEqualToString:self.passwordNew]) {
            //两次一致,成功创建密码
            [self.lockView clearStatus];
            [self.indicatorView reset];
            //保存密码
            [LockModel saveLockPassword:password];
            alert(@"手势创建成功");
        } else {
            //密码不一致
            self.passwordconfirm = nil;
            self.reStart.hidden = NO;
            [self showWrongMSG:@"与上一次密码输入不一致" password:password];
        }
    }
}
//显示错误信息
- (void)showWrongMSG:(NSString *)msg password:(NSString *)password {
    //提示颜色变化震动,手势锁颜色变化
    [self.lockView showErrorCircles:password];
    self.tipsLabel.text = msg;
    self.tipsLabel.textColor = [UIColor redColor];
    [HJCommonTools animationShakeForView:self.tipsLabel];
}
// 更新label提示信息
- (void)updateTipsLabelWithTitle:(NSString *)title {
    self.tipsLabel.text = title;
    self.tipsLabel.textColor = [UIColor blackColor];
}
/**
 *  判断是否是模态过来的
 *
 *  @return
 */
- (BOOL)isPresent {
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
//        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1] == self) {
//            //push方式
//            return NO;
//        }
        return NO;
    }
    else{
        //present方式
        return YES;
    }
}
//alertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_type == LockViewTypeCreate || _type == LockViewTypeModify || _type == LockViewTypeClean) {
        if (buttonIndex == 0) {
            if ([self isPresent]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    if (_type == LockViewTypeCheck) {
        if (buttonIndex == 0) {
            XHJLog(@"强制返回登录页面,置空手势密码");
            [self dismissViewControllerAnimated:YES completion:nil];
            [LockModel saveLockPassword:nil];
        }
    }
}
//检查密码成功后
- (void)hide {
    switch (_type) {
        case LockViewTypeCheck:
        {
        }
            break;
        case LockViewTypeCreate:
        case LockViewTypeModify:
        {
            [LockModel saveLockPassword:self.passwordNew];
        }
            break;
        case LockViewTypeClean:
        default:
        {
            [LockModel saveLockPassword:nil];
        }
            break;
    }
    [self getCurrentImge];
    //渐进动画
    [HJCommonTools animationGradualForView:self.view type:(AnimateTypeSmall) isRotateFow:YES delegate:self];
    
}
//获取当前界面截图
- (void)getCurrentImge {
    self.currentImageV.hidden = YES; // 默认是隐藏的
    self.currentImageV.image = [HJCommonTools imageForView:self.view withCaptureType:(CaptureTypeNone)];
}
//获取上一个界面截图
- (void)getPreviousImage {
    self.previousImageV.hidden = YES; // 默认是隐藏的
    self.previousImageV.image = [HJCommonTools imageForView:self.presentingViewController.view withCaptureType:(CaptureTypeNone)];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.currentImageV.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
