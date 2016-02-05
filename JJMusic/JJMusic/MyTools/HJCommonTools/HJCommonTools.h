//
//  AppDelegate.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//  crc32需要导入libz.tbd

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <CommonCrypto/CommonCrypto.h>//加密用到
#include <zlib.h>//crc32
#import "AppDelegate.h"

//常规加密的方式
typedef NS_ENUM(NSInteger, EncryptType) {
    EncryptTypeMD2,
    EncryptTypeMD4,
    EncryptTypeMD5,
    EncryptTypeSHA1,
    EncryptTypeSHA224,
    EncryptTypeSHA256,
    EncryptTypeSHA384,
    EncryptTypeSHA512
};
//时间戳类型
typedef NS_ENUM(NSInteger, TimestampTpye) {
    TimestampTpyeSecond,  //精确到秒
    TimestampTpyeMillisecond  //精确到毫秒
};
//拼音类型
typedef NS_ENUM(NSInteger, PinYinType) {
    PinYinTypePhoneticSymbol,  //带音标
    PinYinTypeOnly   //不带音标
};
//截图是否存相册和沙盒
typedef NS_ENUM(NSInteger, CaptureType) {
    CaptureTypeSandbox,  //沙盒   caches中
    CaptureTypePhotes,  //相册
    CaptureTypeBoth,  //沙盒和相册
    CaptureTypeNone  //不保存
};
//动画类型
typedef enum {
    AnimateTypeBig,  //放大
    AnimateTypeSmall,  //缩小
}AnimateType;
@interface HJCommonTools : NSObject
#pragma mark - 不带秘钥的加密的方法
/**
 *  加密 传入一个字符串和加密类型,返回加密后的字符串
 *
 *  @param encryptType 加密方式
 *  @param string      传入的需要加密的字符串
 *
 *  @return 返回一个按照加密方式加密的小写字符串
 */
+ (NSString *)returnAStringWithEncryptType:(EncryptType)encryptType forString:(NSString *)string;

/**
 *  加密
 *
 *  @param encryptType 加密方式
 *  @param data      传入的需要加密的数据
 *
 *  @return 返回一个按照加密方式加密的小写字符串
 */
+ (NSString *)returnAStringWithEncryptType:(EncryptType)encryptType forData:(NSData *)data;

/**
 *  加密
 *
 *  @param encryptType 加密方式
 *  @param string      传入的需要加密的字符串
 *
 *  @return 返回一个按照加密方式加密的data
 */
+ (NSData *)returnDataWithEncryptType:(EncryptType)encryptType forString:(NSString *)string;

/**
 *  加密
 *
 *  @param encryptType 加密方式
 *  @param data      传入的需要加密的数据
 *
 *  @return 返回一个按照加密方式加密的data
 */
+ (NSData *)returnDataWithEncryptType:(EncryptType)encryptType forData:(NSData *)data;

#pragma mark - crc32
//crc32, 需要导入libz.tbd
/**
 *  CRC32加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)returnCRC32StringForString:(NSString *)string;
/**
 *  CRC32加密
 *
 *  @param data 需要加密的数据
 *
 *  @return 返回加密后的字符串
 */
+ (NSString *)returnCRC32StringForData:(NSData *)data;

#pragma mark - 带秘钥的几种加密方法
/**
 *  @param hmacType HMAC加密方式
 *  @param key      秘钥
 *  @param data     要加密的data
 *
 *  @return 返回一个Hmac加密字符串
 */
+ (NSString *)returnAStringWithHmacType:(CCHmacAlgorithm)hmacType withKey:(NSString *)key forData:(NSData  *)data;
/**
 *  @param hmacType Hmac加密方式
 *  @param key      秘钥
 *  @param string   要加密的字符串
 *
 *  @return 返回一个Hmac加密字符串
 */
+ (NSString *)returnAStringWithHmacType:(CCHmacAlgorithm)hmacType withKey:(NSString *)key forString:(NSString *)string;

#pragma mark - 返回字符串size
/**
 *  给定一个Size, font  返回字符串的CGSize
 *  @param font          字体大小
 *  @param size          size范围
 *  @param lineBreakMode 分割样式
 *
 *  @return 返回一个CGSize
 */
+ (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode string:(NSString *)string;
/**
 *  根据固定的高度返回宽度(如固定30高度的字符串,根据字符串的长度改变控件的width)
 *
 *  @param font   字体大小
 *  @param height 字符串的固定高度
 *  @param string 字符串
 *
 *  @return 返回宽度width
 */
+ (CGFloat)widthForFont:(UIFont *)font height:(CGFloat)height string:(NSString *)string;
/**
 *  根据固定的宽度返回高度(如固定320高宽度的字符串,根据字符串的长度改变控件的height)
 *
 *  @param font   字体大小
 *  @param height 字符串的固定高度
 *  @param string 字符串
 *
 *  @return 返回高度height
 */
+ (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width string:(NSString *)string;

#pragma mark - NSString字符串
/**
 *   nil, @"", @" ", @"\n" 返回NO, 其他返回YES
 *  @param string 需要判断的字符串
 */
+ (BOOL)isNotBlankForString:(NSString *)string;
/**
 *  判断firststring是否包含secondstring
 *  iOS8 可以直接使用containsString:
 */
+ (BOOL)string:(NSString *)firstString containsString:(NSString *)secondString;
/**
 *  过滤特殊的字符串
 *
 *  @param string 需要过滤的字符串
 *
 *  @return 返回过滤后的字符串
 */
+ (NSString *)filterSpecialString:(NSString *)string;

/**
 *  把汉字转换为拼音,type分为带不带音标两种, 如果trimming是NO,转换完成后汉字之间有空格
 *
 *  @param type   拼音的类型,带不带音标
 *  @param trimming 是否去掉空格
 *  @param string 需要转换的字符串
 *
 *  @return
 */
+ (NSString *)transformPinYinType:(PinYinType)type trimmingWhitespace:(BOOL)trimming forString:(NSString *)string;
/**
 *  判断字符串是否包含汉字
 *
 *  @param string 字符串
 *
 *  @return
 */
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string;
/**
 *  反转字符串
 *
 *  @param string 需要反转的字符串
 *
 *  @return
 */
+ (NSString *)invertString:(NSString *)string;
#pragma mark - UIColor颜色
/**
 *  传入一个字符串,生成一个UIColor
 *
 *  @param hexString #666  #999999
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;
/**
 *  传入一个数字返回UIColor
 *
 *  @param rgbValue rgb数
 */
+ (UIColor *)colorFromRGBValue:(NSInteger)rgbValue;
/**
 *  从图片生成UIColor
 *
 *  @param image 图片
 *
 *  @return
 */
+ (UIColor *)colorFromImage:(UIImage *)image;
#pragma mark - 获取当前时间
/**
 *  获取当前时间, 默认2016年01月01日 00时00分00秒0000毫秒
 *
 *  @return 返回当前时间
 */
+ (NSString *)getCurrentDate;
#pragma mark - 获取时间戳字符串
/**
 *  返回一个从1970年计算的时间戳如:1453167670
 *
 *  @param type 时间戳类型,有10位(到秒)和13位(到毫秒)
 */
+ (NSString *)getTimestampWithType:(TimestampTpye)type;

#pragma mark - 时间戳转日期字符串
/**
 *传如一个10位或者13位时间戳(其他位数默认为当前时间)和日期格式(如@"yyyy:MM:dd HH:mm:ss"),返回按照日期格式生成的自1970计算的日期
 *
 *  @param timestamp     时间戳10位和13位
 *  @param dateFormatter 日期格式
 G  公元
 yy 年后两位 yyyy 年后四位
 M 1~12  MM  01~12两位不足补零 MMM 英文缩写   MMMM英文全写
 d 1~31 dd 01~31两位不足补零
 EEE 英文缩写   EEEE 英文全写
 aa  显示AM/PM
 H  0~23 (24小时制) HH 00~23两位不足补零(24小时制) K 0~12(12小时制) KK 00~12 两位不足补零(12小时制)
 m 显示0~59，1位数或2位数  mm显示00~59，不足2位数会补0
 s 显示0~59，1位数或2位数  ss显示00~59，不足2位数会补0  S 毫秒的显示
 zzzz：Pacific Daylight Time   Z / ZZ / ZZZ ：-0800   ZZZZ：GMT -08:00  v：PT vvvv：Pacific Time
 */
+ (NSString *)timestampTransformToDateStringWithTimestamp:(NSString *)timestamp formatter:(NSString *)dateFormatter;

#pragma mark - UIImage从颜色生成图片
/**
 *  从一个颜色color生成图片
 *  @param color 颜色
 *
 *  @return
 */
+ (UIImage *)imageFromUIColor:(UIColor *)color;
#pragma mark - 压缩图片
/**
 *  压缩图片到固定的大小
 *
 *  @param image 需要压缩的图片
 *  @param size  压缩后的图片大小
 *
 *  @return
 */
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  按照比例压缩图片 比例大于0 小于等于1 ,否则返回本身
 *
 *  @param image 需要压缩的图片
 *  @param ratio 比例    1 >= ratio  >= 0
 *
 *  @return
 */
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio;
#pragma mark - 添加水印
/**
 *  图片添加水印
 *
 *  @param img  需要添加水印的图片
 *  @param logo 水印logo
 *
 *  @return
 */
+ (UIImage *)imageAddLogo:(UIImage *)img text:(UIImage *)logo;
#pragma mark - 屏幕截图的几种方式
/**
 *  屏幕截图有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotWithCaptureType:(CaptureType)type;
/**
 *  屏幕截图没有状态栏
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageWithScreenshotNoStatusBarWithCaptureType:(CaptureType)type;
/**
 *  给一个view截图
 *
 *  @param type 图片保存位置
 *
 *  @return
 */
+ (UIImage *)imageForView:(UIView *)view withCaptureType:(CaptureType)type;
#pragma mark - 二维码和条形码相关
/**
 *  返回字符串的二维码图片
 */
+ (UIImage *)imageQRCodeWithString:(NSString *)string;

/**
 *  返回字符串的二维码图片
 *
 *  @param  width   指定宽度
 */
+ (UIImage *)imageQRCodeWithString:(NSString *)string width:(CGFloat)width;

/**
 *  返回字符串的二维码图片
 *
 *  @param  color   指定颜色
 */
+ (UIImage *)imageQRCodeWithString:(NSString *)string color:(UIColor *)color;

/**
 *  返回字符串的二维码图片
 *
 *  @param  width   指定宽度
 *  @param  color   指定颜色
 */
+ (UIImage *)imageQRCodeWithString:(NSString *)string width:(CGFloat)width color:(UIColor *)color;

/**
 *  返回字符串的条形码图片,字符串不能用汉字
 *  @param  string   字符串,不能有汉字
 */
+ (UIImage *)imageBarCodeWithString:(NSString *)string;

/**
 *  返回字符串的条形码图片,字符串不能用汉字
 *
 *  @param  size   指定大小
 */
+ (UIImage *)imageBarCodeWithString:(NSString *)string size:(CGSize)size;

/**
 *  返回字符串的条形码图片,字符串不能用汉字
 *
 *  @param  color   指定颜色
 */
+ (UIImage *)imageBarCodeWithString:(NSString *)string color:(UIColor *)color;

/**
 *  返回字符串的条形码图片,字符串不能用汉字
 *
 *  @param  width   指定大小
 *  @param  color   指定颜色
 */
+ (UIImage *)imageBarCodeWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color;

#pragma mark - 检测摄像头
/**
 *  检测摄像头
 *
 *  @return
 */
+ (BOOL)checkValidateCamera;
#pragma mark - 检查手机号码是否规范
/**
 *  检查是否为正确手机号码
 *
 *  @param phoneNumber 手机号
 *
 *  @return
 */
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;
#pragma mark - 检查邮箱地址格式
/**
 *  检查邮箱地址格式
 *
 *  @param EmailAddress 邮箱地址
 *
 *  @return
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress;
#pragma mark - 身份证相关
/**
 *  判断身份证是否合法
 *
 *  @param number 身份证号码
 *
 *  @return
 */
+ (BOOL)checkIdentityNumber:(NSString *)number;
/**
 *  从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 *
 *  @param number 身份证
 *
 *  @return
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number;
/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 *
 *  @param number 身份证
 *
 *  @return
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number;
/**
 *  从身份证获取籍贯信息,身份证格式不正确返回nil
 *
 *  @param number 身份证
 *
 *  @return
 */
+ (NSString *)getAddressFromIdentityNumber:(NSString *)number;
#pragma mark - 拨打电话
/**
 *  拨打电话,如果不提示则直接拨打电话,拨打前会判断手机号码正确不正确,不正确不会拨打电话
 *
 *  @param phoneNumber 电话号码
 *  @param prompt      是否提示
 *
 *  @return
 */
+ (BOOL)callTelNumber:(NSString *)phoneNumber isPrompt:(BOOL)prompt;
#pragma mark - JSON和字典、数组
/**
 *  JSON字符串转字典或者数组
 *
 *  @param string JSON字符串
 *
 *  @return 返回字典或者数组
 */
id JSONTransformToDictionaryOrArray(NSString *string);
/**
 *  字典或者数组转为字符串
 *
 *  @param object 字典或者数组
 *
 *  @return 返回字符串
 */
NSString *dictionaryOrArrayTransformToString(id object);
#pragma mark - NSUserDefault相关
/**
 *  从NSUserDefault取值
 *
 *  @param key key
 *
 *  @return
 */
id userDefaultGetValue(NSString *key);
/**
 *  存入NSUserDefault
 *
 *  @param object 值
 *  @param key    key
 */
void userDefaultSetValueKey(id object, NSString *key);
/**
 *  根据key移除key-value对
 *
 *  @param key key
 */
void userDefaultRemoveKey(NSString *key);
/**
 *  清空NSUserDefault
 */
void userDefaultClean();
#pragma mark - sandbox沙盒相关
/**
 *  Documents路径
 *
 *  @return
 */
NSString *pathDocuments();
/**
 *  Caches路径
 *
 *  @return
 */
NSString *pathCaches();
/**
 *  Documents/<文件名>
 *
 *  @param name 文件名
 *
 *  @return
 */
NSString *pathDocumentsFileName(NSString *name);
/**
 *  Documents/<子路径>/<文件名>
 *
 *  @param subPath 子路径
 *  @param name    文件名
 *
 *  @return
 */
NSString *pathDocumentsFilePathName(NSString *subPath, NSString *name);
/**
 *  Caches/<文件名>
 *
 *  @param name 文件名
 *
 *  @return
 */
NSString *pathCachesFileName(NSString *name);
/**
 *  Caches/<子路径>/<文件名>
 *
 *  @param subPath 子路径
 *  @param name    文件名
 *
 *  @return
 */
NSString *pathCachesFilePathName(NSString *subPath, NSString *name);
#pragma mark - Appdelegate
/**
 *  获取AppDelegate
 *
 *  @return
 */
AppDelegate *getApp();
/**
 *  获取window
 *
 *  @return
 */
UIWindow *getAppWindow();
#pragma mark - 快捷alloc方法
/**
 *  UILabel方法
 *
 *  @param title         标题
 *  @param frame         frame
 *  @param font          正常字体大小  不写默认17
 *  @param color         正常的颜色  不写默认是黑色
 *  @param textAlignment 对齐方式
 *  @param keyWords      关键字 在标题中的位置,若标题为空,
 *  @param keyWordsColor 关键字颜色
 *  @param keyWordsFont       关键字字体
 *  @param underLine     是否有下划线
 *
 *  @return
 */
+ (UILabel *)allocLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)textAlignment keyWords:(NSString *)keyWords keyWordsColor:(UIColor *)keyWordsColor keyWordsFont:(UIFont *)keyWordsFont underLine:(BOOL)underLine;
/**
 *  UIButton方法
 *
 *  @param rect            范围
 *  @param title           标题
 *  @param color           颜色
 *  @param font            字体大小
 *  @param normalImage     正常图片
 *  @param highImage     高亮图片
 *  @param normalBackImage 正常背景图片
 *  @param highBackImage 高亮背景图片
 *
 *  @return 
 */
+ (UIButton *)allocButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font normalImage:(UIImage *)normalImage highImage:(UIImage *)highImage normalBackImage:(UIImage *)normalBackImage highBackImage:(UIImage *)highBackImage;
/**
 *  UIImageView方法
 *
 *  @param image 图片
 *  @param frame 范围
 *  @param mode  图片填充样式
 *
 *  @return 
 */
+ (UIImageView *)allocImageViewWith:(UIImage *)image frame:(CGRect)frame contentMode:(UIViewContentMode)mode;

#pragma mark - 动画相关
/**
 *  抖动动画
 *
 *  @param view 哪个视图抖动
 */
+ (void)animationShakeForView:(UIView *)view;
/**
 *  慢慢变大或者变小的渐进动画
 *
 *  @param view   哪个视图做动画
 *  @param type   动画类型,放大或者缩小
 *  @param rotate 是否旋转一点
 *  @param  delegate  代理
 */
+ (void)animationGradualForView:(UIView *)view type:(AnimateType)type isRotateFow:(BOOL)rotate delegate:(id)delegate;

#pragma mark - 获取view的controller
/**
 *  获取view的Controller
 *
 *  @param view 视图
 *
 *  @return 
 */
+ (UIViewController *)getControllerForView:(UIView *)view;
@end






