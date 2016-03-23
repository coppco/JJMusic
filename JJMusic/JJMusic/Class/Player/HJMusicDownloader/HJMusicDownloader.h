//
//  HJMusicLoader.h
//  JJMusic
//
//  Created by coco on 16/3/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//   基于AFNetworking封装的音乐下载器,给AVURLAsset提供数据的同时把音乐下载到手机沙盒
/**
 *  参考:https://github.com/suifengqjn/TBPlayer
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class HJSongModel;
@interface HJMusicLoader : NSURLConnection<AVAssetResourceLoaderDelegate>
- (instancetype)initWithModel:(HJSongModel *)model;
- (NSURL *)getSchemeWithURL:(NSURL *)url scheme:(NSString *)scheme;
@end
