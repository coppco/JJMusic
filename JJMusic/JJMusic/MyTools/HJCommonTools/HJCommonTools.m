//
//  AppDelegate.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJCommonTools.h"
#import "RegionSearch.h"
@implementation HJCommonTools
#pragma mark 常规加密方式
//根据加密方式和data返回加密后的字符串
+(NSString *)returnAStringWithEncryptType:(EncryptType)encryptType forData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSString *encryptString;
    switch (encryptType) {
        case EncryptTypeMD2:
        {
            unsigned char result[CC_MD2_DIGEST_LENGTH];
            CC_MD2(data.bytes, (CC_LONG)data.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case EncryptTypeMD4:
        {
            unsigned char result[CC_MD4_DIGEST_LENGTH];
            CC_MD4(data.bytes, (CC_LONG)data.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case EncryptTypeMD5:
        {
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(data.bytes, (CC_LONG)data.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case EncryptTypeSHA1:
        {
            unsigned char result[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1(data.bytes, (CC_LONG)data.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case EncryptTypeSHA224:
        {
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(data.bytes, (CC_LONG)data.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case EncryptTypeSHA256:
        {
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(data.bytes, (CC_LONG)data.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case EncryptTypeSHA384:
        {
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(data.bytes, (CC_LONG)data.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case EncryptTypeSHA512:
        {
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(data.bytes, (CC_LONG)data.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        default:
            return nil;
            break;
    }
    return encryptString;
}
//根据加密方式和字符串返回加密后的字符串
+(NSString *)returnAStringWithEncryptType:(EncryptType)encryptType forString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self returnAStringWithEncryptType:encryptType forData:data];
}
//根据加密方式和data返回加密后的data
+ (NSData *)returnDataWithEncryptType:(EncryptType)encryptType forData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSData *encryptData;
    switch (encryptType) {
        case EncryptTypeMD2:
        {
            unsigned char result[CC_MD2_DIGEST_LENGTH];
            CC_MD2(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeMD4:
        {
            unsigned char result[CC_MD4_DIGEST_LENGTH];
            CC_MD4(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeMD5:
        {
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeSHA1:
        {
            unsigned char result[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeSHA224:
        {
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeSHA256:
        {
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeSHA384:
        {
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
        }
            break;
        case EncryptTypeSHA512:
        {
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(data.bytes, (CC_LONG)data.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
        }
            break;
        default:
            return nil;
            break;
    }
    return encryptData;
}
//根据加密方式和string返回加密后的data
+(NSData *)returnDataWithEncryptType:(EncryptType)encryptType forString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self returnDataWithEncryptType:encryptType forData:data];
}
#pragma mark crc32
+ (NSString *)returnCRC32StringForString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self returnCRC32StringForData:data];
}
+ (NSString *)returnCRC32StringForData:(NSData *)data {
    if (!data) {
        return nil;
    }
    uLong result = crc32(0, [data bytes], (uInt)data.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}
#pragma mark 带秘钥的加密方式
//根据秘钥和data返回hmac加密的字符串
+ (NSString *)returnAStringWithHmacType:(CCHmacAlgorithm)hmacType withKey:(NSString *)key forData:(NSData *)data {
    if (!data) {
        return nil;
    }
    size_t size;
    switch (hmacType) {
        case kCCHmacAlgMD5:
            size = CC_MD5_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA1:
            size = CC_SHA1_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA224:
            size = CC_SHA224_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA256:
            size = CC_SHA256_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA384:
            size = CC_SHA384_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA512:
            size = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            return nil;
            break;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(hmacType, cKey, strlen(cKey), data.bytes, data.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}
//根据秘钥和string返回hmac加密的字符串
+ (NSString *)returnAStringWithHmacType:(CCHmacAlgorithm)hmacType withKey:(NSString *)key forString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self returnAStringWithHmacType:hmacType withKey:key forData:data];
}
#pragma mark 返回字符串size
+ (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode string:(NSString *)string {
    if (!font || !string) {
        return CGSizeZero;
    }
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    if (!font) {
        attr[NSFontAttributeName] = font;
    }
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
    return rect.size;
}
//根据高度返回字符串的宽度
+ (CGFloat)widthForFont:(UIFont *)font height:(CGFloat)height string:(NSString *)string {
    return [self sizeForFont:font size:CGSizeMake(CGFLOAT_MAX, height) mode:NSLineBreakByWordWrapping string:string].width;
}
//根据宽度返回字符串的高度
+ (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width string:(NSString *)string {
    return [self sizeForFont:font size:CGSizeMake(width, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping string:string].height;
}
#pragma mark 字符串
//判断字符串是否为空
+ (BOOL)isNotBlankForString:(NSString *)string {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < string.length; ++i) {
        unichar c = [string characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}
//判断字符串是否包含
+ (BOOL)string:(NSString *)firstString containsString:(NSString *)secondString {
    if (secondString == nil) {
        return NO;
    }
    return [firstString rangeOfString:secondString].location != NSNotFound;
}
//过滤特殊字符串
+ (NSString *)filterSpecialString:(NSString *)string {
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+,.;':|/@!? "];
    //stringByTrimmingCharactersInSet只能去掉首尾的特殊字符串
    return [[[string componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
//汉字转换为拼音
+ (NSString *)transformPinYinType:(PinYinType)type trimmingWhitespace:(BOOL)trimming forString:(NSString *)string {
    if (!string) {
        return nil;
    }
    //先转换为带音标的字符串
    NSMutableString *pinyin = [NSMutableString stringWithString:string];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    if (type == PinYinTypePhoneticSymbol) {
        if (trimming) {
            return [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        return pinyin;
    } else if (type == PinYinTypeOnly) {
        //再转为不带音标字符串
        NSMutableString *pinyinPhoneticSymbol = [NSMutableString stringWithString:pinyin];
        CFStringTransform((__bridge CFMutableStringRef)(pinyinPhoneticSymbol), NULL, kCFStringTransformStripCombiningMarks, NO);
        if (trimming) {
            return [pinyinPhoneticSymbol stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        return pinyinPhoneticSymbol;
    } else {
        return nil;
    }
}
//判断字符串时候包含汉字
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string {
    for (int i = 0; i < string.length; i++) {
        int a = [string characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fff) {
            return YES;
        }
    }
    return NO;
}
//反转字符串
+ (NSString *)invertString:(NSString *)string {
    NSMutableString *invertString = [[NSMutableString alloc] init];
    NSInteger charIndex = [string length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [invertString appendString:[string substringWithRange:subStrRange]];
    }
    return invertString;
}
#pragma mark UIColor
//从字符串获取颜色
+ (UIColor *)colorFromHexCode:(NSString *)hexString {
    if (!hexString) {
        return [UIColor clearColor];
    }
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
//从RGB值获取颜色
+ (UIColor *)colorFromRGBValue:(NSInteger)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}
//从图片转到颜色
+ (UIColor *)colorFromImage:(UIImage *)image {
    if (image == nil) {
        return [UIColor clearColor];
    } else {
        return [UIColor colorWithPatternImage:image];
    }
}
static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;       // s
    else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;     // between yellow & magenta
    else if( g == max )
        *h = 2 + ( b - r ) / delta; // between cyan & yellow
    else
        *h = 4 + ( r - g ) / delta; // between magenta & cyan
    *h *= 60;               // degrees
    if( *h < 0 )
        *h += 360;
}
//从图片获取主色调
+ (UIColor *)colorPrimaryFromImage:(UIImage *)image {
    if (image == nil) {
        return [UIColor clearColor];
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(40, 40);
//    CGSize thumbSize = image.size;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    NSArray *MaxColor=nil;
    // NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    float maxScore=0;
    for (int x=0; x<thumbSize.width*thumbSize.height; x++) {
        int offset = 4*x;
        
        int red = data[offset];
        int green = data[offset+1];
        int blue = data[offset+2];
        int alpha =  data[offset+3];
        
        if (alpha<25)continue;
        
        float h,s,v;
        RGBtoHSV(red, green, blue, &h, &s, &v);
        
        float y = MIN(abs(red*2104+green*4130+blue*802+4096+131072)>>13, 235);
        y= (y-16)/(235-16);
        if (y>0.9) continue;
        
        float score = (s+0.1)*x;
        if (score>maxScore) {
            maxScore = score;
        }
        MaxColor=@[@(red),@(green),@(blue),@(alpha)];
    }
    CGContextRelease(context);
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}
#pragma mark - 获取当前时间
+ (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒SSSS毫秒"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}
#pragma mark - 获取时间戳字符串
+ (NSString *)getTimestampWithType:(TimestampTpye)type {
    return (type == TimestampTpyeSecond ? [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]] : [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000]);
}
#pragma mark - 时间戳转日期字符串
+ (NSString *)timestampTransformToDateStringWithTimestamp:(NSString *)timestamp formatter:(NSString *)dateFormatter{
    if (!timestamp) {
        return nil;
    }
    NSTimeInterval interval = (timestamp.length == 10 ? [timestamp doubleValue] : (timestamp.length == 13 ? [timestamp doubleValue] * 0.001 : [[NSDate date] timeIntervalSince1970])); //时间间隔
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval]; //nsdate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];  //nsdateformatter对象
    if (!dateFormatter) {
        dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:dateFormatter];
    return [formatter stringFromDate:date];
}
#pragma mark - UIImage
//从颜色生成图片
+ (UIImage *)imageFromUIColor:(UIColor *)color {
    if (!color) {
        color = [UIColor blackColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 压缩图片
//压缩图片按照大小
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size {
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);//[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//压缩图片按照比例
+ (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio {
    CGImageRef imgRef = image.CGImage;
    
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    
    return [self image:image scaleToSize:size];
}
#pragma mark - 添加水印
+ (UIImage *)imageAddLogo:(UIImage *)img text:(UIImage *)logo {
    if (logo == nil ) {
        return img;
    }
    if (img == nil) {
        return nil;
    }
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth-15, 10, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return returnImage;
    // CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}
#pragma mark - 屏幕截图的几种方式
//有状态栏截屏
+ (UIImage *)imageWithScreenshotWithCaptureType:(CaptureType)type
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if ([window screen] == [UIScreen mainScreen]) {
            [window drawViewHierarchyInRect:[[UIScreen mainScreen] bounds] afterScreenUpdates:NO];
        }
    }
    
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [statusBar drawViewHierarchyInRect:[statusBar bounds] afterScreenUpdates:NO];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(screenImage);
    switch (type) {
        case CaptureTypeSandbox:
        {
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        case CaptureTypePhotes:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(screenImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
            break;
        case CaptureTypeBoth:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(screenImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            //存到沙盒
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        default:
            break;
    }
    
    return screenImage;
}
//没有状态栏截屏
+ (UIImage *)imageWithScreenshotNoStatusBarWithCaptureType:(CaptureType)type
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if ([window screen] == [UIScreen mainScreen]) {
            
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    switch (type) {
        case CaptureTypeSandbox:
        {
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        case CaptureTypePhotes:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
            break;
        case CaptureTypeBoth:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            //存到沙盒
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        default:
            break;
    }
    return image;
}
//给一个view截图
+ (UIImage *)imageForView:(UIView *)view withCaptureType:(CaptureType)type{
    if (!view) {
        return nil;
    }
    CGSize imageSize = [view bounds].size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[view layer] renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    switch (type) {
        case CaptureTypeSandbox:
        {
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        case CaptureTypePhotes:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
            break;
        case CaptureTypeBoth:
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            //存到沙盒
            [data writeToFile:pathCachesFileName(STRFORMAT(@"%@mainScreen_status.png", [self getTimestampWithType:(TimestampTpyeSecond)])) atomically:YES];
        }
            break;
        default:
            break;
    }
    return image;
}
// 指定回调方法
+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    } else {
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
#pragma mark - 二维码和条形码相关
#pragma mark - 二维码
+ (UIImage *)imageQRCodeWithString:(NSString *)string
{
    return [self imageQRCodeWithString:string width:KMainScreenWidth color:[UIColor colorWithRed:0.2353 green:0.2941 blue:0.3490 alpha:1]];
}

+ (UIImage *)imageQRCodeWithString:(NSString *)string width:(CGFloat)width
{
    return [self imageQRCodeWithString:string width:width color:[UIColor colorWithRed:0.2353 green:0.2941 blue:0.3490 alpha:1]];
}

+ (UIImage *)imageQRCodeWithString:(NSString *)string color:(UIColor *)color
{
    return [self imageQRCodeWithString:string width:KMainScreenWidth color:color];
}
+ (UIImage *)imageQRCodeWithString:(NSString *)string width:(CGFloat)width color:(UIColor *)color
{
    CIImage *outImage = [self generateQRCodeForString:string];
    UIImage *endImage = [self createNonInterpolatedUIImageFormCIImage:outImage withSize:width];
    return [self imageBlackToTransparent:endImage withColor:color];
}

#pragma mark - 条形码
+ (UIImage *)imageBarCodeWithString:(NSString *)string
{
    return [self imageQRCodeWithString:string width:KMainScreenWidth color:[UIColor colorWithRed:0.2353 green:0.2941 blue:0.3490 alpha:1]];
}

+ (UIImage *)imageBarCodeWithString:(NSString *)string size:(CGSize)size
{
    return [self imageBarCodeWithString:string size:size color:[UIColor colorWithRed:0.2353 green:0.2941 blue:0.3490 alpha:1]];
}

+ (UIImage *)imageBarCodeWithString:(NSString *)string color:(UIColor *)color
{
    return [self imageQRCodeWithString:string width:KMainScreenWidth color:color];
}

+ (UIImage *)imageBarCodeWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color
{
    CIImage *outImage = [self generateBarCodeForString:string];
    UIImage *endImage = [self createNonInterpolatedUIImageFormCIImage1:outImage withSize:size];
    return [self imageBlackToTransparent:endImage withColor:color];
}

#pragma mark - Other Support Function
// 生成二维码 CIImage
+ (CIImage *)generateQRCodeForString:(NSString *)codeString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return [qrFilter outputImage];
}

// 生成条形码 CIImage
+ (CIImage *)generateBarCodeForString:(NSString *)codeString
{
    NSData *data = [codeString dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    return [filter outputImage];
}


// CIImage 转换到 UIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *returnImage =  [UIImage imageWithCGImage:scaledImage];
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);
    return returnImage;
}

// CIImage 转换到 UIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage1:(CIImage *)image withSize:(CGSize)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scaleW = size.width / CGRectGetWidth(extent);
    CGFloat scaleH = size.height / CGRectGetHeight(extent);
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scaleW;
    size_t height = CGRectGetHeight(extent) * scaleH;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scaleW, scaleH);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *returnImage = [UIImage imageWithCGImage:scaledImage];
    // Cleanup
    CGImageRelease(scaledImage);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    return returnImage;
}
// ?
void ProviderReleaseData(void *info, const void *data, size_t size) {
    free((void*)data);
}
// 重置颜色
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withColor:(UIColor *)color {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    const CIColor *_color = [CIColor colorWithCGColor:color.CGColor];
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        uint8_t* ptr = (uint8_t*)pCurPtr;
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            ptr[3] = _color.red * 255; //0~255
            ptr[2] = _color.green * 255;
            ptr[1] = _color.blue * 255;
        }else{
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
#pragma mark - 检查摄像头
+ (BOOL)checkValidateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
#pragma mark - 检查手机号码是否规范
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    NSString *MOBILE    = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM        = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378]|7[7])\\d)\\d{7}$";   // 包含电信4G 177号段
    NSString *CU        = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT        = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    //
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phoneNumber];
    BOOL res2 = [regextestcm evaluateWithObject:phoneNumber];
    BOOL res3 = [regextestcu evaluateWithObject:phoneNumber];
    BOOL res4 = [regextestct evaluateWithObject:phoneNumber];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    
    return NO;
}
#pragma mark - 检查邮箱地址格式
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString       = EmailAddress.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}
#pragma mark - 判断身份证是否合法
+ (BOOL)checkIdentityNumber:(NSString *)number {
    //     //必须满足以下规则
    //     //1. 长度必须是18位或者15位，前17位必须是数字，第十八位可以是数字或X
    //     //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
    //     //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
    //     //4. 第17位表示性别，双数表示女，单数表示男
    //     //5. 第18位为前17位的校验位
    //     //算法如下：
    //     //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
    //     //（2）余数 ＝ 校验和 % 11
    //     //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
    //     //6. 出生年份的前两位必须是19或20
    //number = [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    number = [self filterSpecialString:number];
    //1⃣️判断位数
    if (number.length != 15 && number.length != 18) {
        return NO;
    }
    //2⃣️将15位身份证转为18位
    NSMutableString *mString = [NSMutableString stringWithString:number];
    if (number.length == 15) {
        //出生日期加上年的开头
        [mString insertString:@"19" atIndex:6];
        //最后一位加上校验码
        [mString insertString:[self getLastIdentifyNumberForIdentifyNumber:mString] atIndex:[mString length]];
        number = mString;
    }
    //3⃣️开始判断
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    //区域
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![regexTest evaluateWithObject:number]) {
        return NO;
    }
    //4⃣️验证校验码
    return [[self getLastIdentifyNumberForIdentifyNumber:number] isEqualToString:[number substringWithRange:NSMakeRange(17, 1)]];
}
//获取身份证最后一位验证码
+ (NSString *)getLastIdentifyNumberForIdentifyNumber:(NSString *)number {
    //位数不小于17
    if (number.length < 17) {
        return nil;
    }
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    long p =0;
    for (int i =0; i<=16; i++){
        NSString * s = [number substringWithRange:NSMakeRange(i, 1)];
        p += [s intValue]*R[i];
    }
    //校验位
    int o = p%11;
    NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
    return string_content;
}
//从身份证获取性别
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number{
    if ([self checkIdentityNumber:number]) {
        number = [self filterSpecialString:number];
        NSInteger i = [[number substringWithRange:NSMakeRange(number.length - 2, 1)] integerValue];
        if (i % 2 == 1) {
            return @"man";
        } else {
            return @"woman";
        }
    } else {
        return nil;
    }
}
//
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number {
    if ([self checkIdentityNumber:number]) {
        number = [self filterSpecialString:number];
        if (number.length == 18) {
            return [NSString stringWithFormat:@"%@年%@月%@日",[number substringWithRange:NSMakeRange(6,4)], [number substringWithRange:NSMakeRange(10,2)], [number substringWithRange:NSMakeRange(12,2)]];
        }
        if (number.length == 15) {
            return [NSString stringWithFormat:@"19%@年%@月%@日",[number substringWithRange:NSMakeRange(6,2)], [number substringWithRange:NSMakeRange(8,2)], [number substringWithRange:NSMakeRange(10,2)]];
        };
        return nil;
    } else {
        return nil;
    }
}
//从身份证获取籍贯信息
+ (NSString *)getAddressFromIdentityNumber:(NSString *)number {
    if ([self checkIdentityNumber:number]) {
        NSString *province = STRFORMAT(@"%@0000", [number substringWithRange:NSMakeRange(0, 2)]);
        NSString *city = STRFORMAT(@"%@00", [number substringWithRange:NSMakeRange(0, 4)]);
        NSString *country = [number substringWithRange:NSMakeRange(0, 6)];
        //从数据库查找
        return STRFORMAT(@"%@%@%@", [RegionSearch searchRegionByID:province].name, [RegionSearch searchRegionByID:city].name, [RegionSearch searchRegionByID:country].name);
    } else {
        return nil;
    }
}
#pragma mark - 拨打电话
+ (BOOL)callTelNumber:(NSString *)phoneNumber isPrompt:(BOOL)prompt {
    if ([self checkPhoneNumber:phoneNumber]) {
        if (prompt) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]]];
        }
        return YES;
    }
    return NO;
}
#pragma mark - JSON和字典、数组
//JSON字符串转字典或者数组
id JSONTransformToDictionaryOrArray(NSString *string) {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingMutableContainers) error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry or array from JSON: %@, error: %@", string, error);
#endif
    }
    return object;
}
//字典数组转字符串
NSString *dictionaryOrArrayTransformToString(id object) {
    if (![object isKindOfClass:[NSArray class]] && ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSError *error;
    //options为0 则不会有换行符和空格   NSJSONWritingPrettyPrinted有空格和换行符方便阅读
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:(0) error:&error];
    if (error != nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from object: %@, error: %@", object, error);
#endif
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
#pragma mark - NSUserDefault相关
//  从NSUserDefault取值
id userDefaultGetValue(NSString *key) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}
//存入NSUserDefault
void userDefaultSetValueKey(id object, NSString *key) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:key];
    [ud synchronize];
}
//根据key移除key-value对
void userDefaultRemoveKey(NSString *key) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}
//清空NSUserDefault
void userDefaultClean() {
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}
#pragma mark - sandbox沙盒相关
//documents路径
NSString *pathDocuments()
{
    //    return [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()];
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
//caches路径
NSString *pathCaches()
{
    //    return [NSString stringWithFormat:@"%@/Library/Caches/", NSHomeDirectory()];
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
//documents/<文件名>
NSString *pathDocumentsFileName(NSString *name)
{
    //    return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), name];
    //stringByAppendingPathComponent  会自动加上 / 如  a/b.txt
    return [pathDocuments() stringByAppendingPathComponent:name];
}

NSString *pathDocumentsFilePathName(NSString *subPath, NSString *name)
{
    //NSString *path = [NSString stringWithFormat:@"%@/Documents/%@/", NSHomeDirectory(), subPath];
    NSString *path = [pathDocuments() stringByAppendingPathComponent:subPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //    return [NSString stringWithFormat:@"%@%@", path, name];
    return [path stringByAppendingPathComponent:name];
}

NSString *pathCachesFileName(NSString *name)
{
    //    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/", NSHomeDirectory()];
    
    //    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
    //        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    //    }
    //    return [NSString stringWithFormat:@"%@%@", path, name];
    return [pathCaches() stringByAppendingPathComponent:name];
}

NSString *pathCachesFilePathName(NSString *subPath, NSString *name)
{
    //    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@/", NSHomeDirectory(), subPath];
    NSString *path = [pathCaches() stringByAppendingPathComponent:subPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //    return [NSString stringWithFormat:@"%@%@", path, name];
    return [path stringByAppendingPathComponent:name];
}
#pragma mark - Appdelegate
AppDelegate *getApp() {
    return [UIApplication sharedApplication].delegate;
}
UIWindow *getAppWindow() {
    return [[UIApplication sharedApplication] keyWindow];
}
#pragma mark - 快捷alloc方法
/*     UILabel方法     */
+ (UILabel *)allocLabelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)textAlignment keyWords:(NSString *)keyWords keyWordsColor:(UIColor *)keyWordsColor keyWordsFont:(UIFont *)keyWordsFont underLine:(BOOL)underLine {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (!font) {
        font = [UIFont systemFontOfSize:17];
    }
    label.font = font;
    if (!color) {
        color = [UIColor blackColor];
    }
    label.textColor = color;
    NSMutableAttributedString *titleString = title.length == 0 ? (keyWords.length == 0 ? nil : [[NSMutableAttributedString alloc] initWithString:keyWords]) : [[NSMutableAttributedString alloc] initWithString:title];
    if (keyWords.length != 0) {
        NSRange range = title.length == 0 ? [keyWords rangeOfString:keyWords] : [title rangeOfString:keyWords];
        if (keyWordsFont) {
            [titleString addAttribute:NSFontAttributeName value:keyWordsFont range:range];
        }
        if (keyWordsColor) {
            [titleString addAttribute:NSForegroundColorAttributeName value:keyWordsColor range:range];
        }
        if (underLine) {
            [titleString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        }
    }
    label.attributedText = titleString;
    label.textAlignment = textAlignment;  //对齐方式
    return label;
}
/* 获取NSAttributedString  */
+ (NSAttributedString *)labelAttributedText:(NSString *)title font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)textAlignment keyWords:(NSString *)keyWords keyWordsColor:(UIColor *)keyWordsColor keyWordsFont:(UIFont *)keyWordsFont underLine:(BOOL)underLine {
    NSMutableAttributedString *titleString = title.length != 0 ? [[NSMutableAttributedString alloc] initWithString:title] : (keyWords.length != 0 ? [[NSMutableAttributedString alloc] initWithString:keyWords] : nil);
    
    if (title.length != 0) {
        NSRange range = NSMakeRange(0, title.length);
        if (font) {
            [titleString addAttribute:NSFontAttributeName value:font range:range];
        }
        if (color) {
            [titleString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    
    if (keyWords.length != 0) {
        NSRange range = title.length == 0 ? [keyWords rangeOfString:keyWords] : [title rangeOfString:keyWords];
        if (keyWordsFont) {
            [titleString addAttribute:NSFontAttributeName value:keyWordsFont range:range];
        }
        if (keyWordsColor) {
            [titleString addAttribute:NSForegroundColorAttributeName value:keyWordsColor range:range];
        }
        if (underLine) {
            [titleString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        }
    }
    return titleString;
}
/*    UIButton方法  */
+ (UIButton *)allocButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font normalImage:(UIImage *)normalImage highImage:(UIImage *)highImage normalBackImage:(UIImage *)normalBackImage highBackImage:(UIImage *)highBackImage {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    if (title.length != 0) {
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitle:title forState:(UIControlStateHighlighted)];
    }
    if (color != nil) {
        [button setTitleColor:color forState:(UIControlStateNormal)];
        [button setTitleColor:color forState:(UIControlStateHighlighted)];
    }
    if (font != nil) {
        button.titleLabel.font = font;
    }
    if (normalImage != nil) {
        [button setImage:normalImage forState:(UIControlStateNormal)];
    }
    if (highImage != nil) {
        [button setImage:highImage forState:(UIControlStateHighlighted)];
    }
    if (normalBackImage != nil) {
        [button setBackgroundImage:normalBackImage forState:(UIControlStateNormal)];
    }
    if (highBackImage != nil) {
        [button setBackgroundImage:highBackImage forState:(UIControlStateHighlighted)];
    }
    return button;
}
/*  UIImageView方法 */
+ (UIImageView *)allocImageViewWith:(UIImage *)image frame:(CGRect)frame contentMode:(UIViewContentMode)mode {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    if (image != nil) {
        imageV.image = image;
    }
    if (mode) {
        imageV.contentMode = mode;
    }
    return imageV;
}

#pragma mark - 动画相关
//抖动动画
+ (void)animationShakeForView:(UIView *)view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES]; // 平滑结束
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    XHJLog(@"抖动动画");
    [viewLayer addAnimation:animation forKey:nil];
}
//渐进动画
+ (void)animationGradualForView:(UIView *)view type:(AnimateType)type isRotateFow:(BOOL)rotate delegate:(id)delegate{
    XHJLog(@"渐进动画");
    if (rotate) {
        view.transform = CGAffineTransformRotate(view.transform, M_1_PI);
    }
    NSTimeInterval duration = 0.5;
    //比例
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (type == AnimateTypeBig) {
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
        scaleAnimation.toValue = [NSNumber numberWithFloat:2];
    } else {
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0];
    }
    //透明度
    CABasicAnimation *opacityAnimaton = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimaton.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimaton.toValue = [NSNumber numberWithFloat:0];
    
    //组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, opacityAnimaton];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.duration = duration;
//    group.delegate = [HJCommonTools getControllerForView:view];
    if (delegate != nil) {
        group.delegate = delegate;
    }
    group.autoreverses = NO; // 防止最后显现
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [view.layer addAnimation:group forKey:nil];
    
}
//CATransition 核心动画
+ (void)animationCATransitionForView:(UIView *)view duration:(NSTimeInterval)duration type:(HJAnimationType)type direction:(DirectionType)direction {
    if (type == 0) {
        type = 1;
    }
    if (direction == 0) {
        direction = 1;
    }
    if (view == nil) {
        return;
    }
    if (duration <= 0) {
        duration = 1;
    }
    
    NSString *subtypeString = nil;
    switch (direction) {
        case DirectionTypeBottom:
            subtypeString = kCATransitionFromBottom;
            break;
        case DirectionTypeLeft:
            subtypeString = kCATransitionFromLeft;
            break;
        case DirectionTypeRight:
            subtypeString = kCATransitionFromRight;
            break;
        case DirectionTypeTop:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    switch (type) {
        case HJAnimationTypeFade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypePush:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeReveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeMoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeCube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeSuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeOglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeRippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypePageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypePageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeCameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeCameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString duration:duration ForView:view];
            break;
            
        case HJAnimationTypeCurlDown:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlDown duration:duration];
            break;
            
        case HJAnimationTypeCurlUp:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlUp duration:duration];
            break;
            
        case HJAnimationTypeFlipFromLeft:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft duration:duration];
            break;
            
        case HJAnimationTypeFlipFromRight:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight duration:duration];
            break;
            
        default:
            break;
    }
    
}
#pragma CATransition动画实现
+ (void)transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype duration:(NSTimeInterval)duration ForView : (UIView *) view {
    //1. 创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //2. 设置时间
    animation.duration = duration;
    //设置type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}
#pragma UIView实现动画
+ (void) animationWithView:(UIView *)view WithAnimationTransition: (UIViewAnimationTransition)transition duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma mark - 获取view的controller
+ (UIViewController *)getControllerForView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end

