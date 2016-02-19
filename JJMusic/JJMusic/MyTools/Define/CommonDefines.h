//
//  CommonDefines.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#ifndef CommonDefines_h
#define CommonDefines_h

/*==================坐标相关==================*/
#define ViewH(view) view.frame.size.height
#define ViewW(view) view.frame.size.width
#define ViewX(view) view.frame.origin.x
#define ViewY(view) view.frame.origin.y
//获取view的最大x
#define ViewMaxX(view) CGRectGetMaxX(view.frame)
//获取view的最大y
#define ViewMaxY(view) CGRectGetMaxY(view.frame)

//获取当前屏幕的bounds
#define KMainScreenBounds ([UIScreen mainScreen].bounds)

//获取当前屏幕的高度
#define KMainScreenHeight ([UIScreen mainScreen].bounds.size.height)

//获取当前屏幕的宽度
#define KMainScreenWidth  ([UIScreen mainScreen].bounds.size.width)

/*==================字符串拼接==================*/
#define STRFORMAT(FORMAT, ...) [NSString stringWithFormat:FORMAT, ##__VA_ARGS__]

/*==================Property==================*/
// 通用 Property 宏定义
#define HJpropertyAssign(__v__)         @property (nonatomic, assign)       __v__
#define HJpropertyCopy(__v__)           @property (nonatomic, copy)         __v__
#define HJpropertyWeak(__v__)           @property (nonatomic, weak)         __v__
#define HJpropertyStrong(__v__)         @property (nonatomic, strong)       __v__

/*==================设备型号==================*/
#define ISIPHONE_3 (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 1.0)
#define ISIPHONE_4 (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 2.0)
#define ISIPHONE_5 CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(320, 568))
#define ISIPHONE_6 CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(375, 667))
#define ISIPHONE_6P CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(414, 736))
/*==================系统版本==================*/
#define __IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define ISIOS_5_0 ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0)
#define ISIOS_6_0 ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
#define ISIOS_7_0 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define ISIOS_8_0 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define ISIOS_9_0 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

/*==================UIColor==================*/
//字符串转color
#define ColorFromString(x) [HJCommonTools colorFromHexCode:x]
//清除背景色
#define ColorClear [UIColor clearColor]
//带有RGBA的颜色设置
#define ColorFromRGBA(R, G, B, A) ([UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)])
#define ColorFromRGB(R, G, B) RGBA(R,G,B,1.0f)
// rgb颜色转换（16进制->10进制）
#define ColorFromRGBValue(rgbValue) \
[HJCommonTools colorFromRGBValue:(rgbValue)] \

/*==================UIFont对象==================*/
#define font(x) [UIFont systemFontOfSize:x]
#define fontWeight(x,y) [UIFont systemFontOfSize:x weight:y];

/*==================UIImage对象==================*/
//性能高于后者
#define IMAGEFILE(A) \
[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]] \

#define IMAGE(A) [UIImage imageNamed:A]

/*==================PATH==================*/
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] \
/*==================WEAK,定义weakSelf==================*/
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

/*========================NSLog=======================*/
#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"当前时间:%s \t%s:%d　\t%s\n\n", [HJCommonTools getCurrentDate].UTF8Sting,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define XHJLog(FORMAT, ...) NSLog(@"%@:%d行   \n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define XHJLog(FORMAT, ...) nil
#endif

#define alert(msg) {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]; [alert show];}

#endif /* CommonDefines_h */
