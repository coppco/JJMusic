//
//  NSObject+Unicode.m
//  JJMusic
//
//  Created by coco on 16/2/15.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "NSObject+Unicode.h"

@implementation NSObject (Unicode)
+ (NSString *)stringByReplaceUnicode:(NSString *)string
{
    NSMutableString *convertedString = [string mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}
@end
