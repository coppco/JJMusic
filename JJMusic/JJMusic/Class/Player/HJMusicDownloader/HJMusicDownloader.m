//
//  HJMusicLoader.m
//  JJMusic
//
//  Created by coco on 16/3/9.
//  Copyright © 2016年 XHJ. All rights reserved.
//  

#import "HJMusicDownloader.h"
#import <AFNetworking.h>
#import "HJMusicTool.h"
#import "HJDownloadDB.h"  //数据库

@interface HJMusicLoader () <AVAssetResourceLoaderDelegate>
HJpropertyCopy(NSString *tempPath);  //音乐本地地址
HJpropertyStrong(NSFileHandle *fileHandle);  //写数据
@end

@implementation HJMusicLoader
- (instancetype)init {
    self = [super init];
    if (self) {
        _tempPath = pathCachesFilePathName(@"music", STRFORMAT(@"%@_%@.mp3", [[[HJMusicTool sharedMusicPlayer].model songinfo] title], [[[HJMusicTool sharedMusicPlayer].model songinfo] song_id]));
        if ([[NSFileManager defaultManager] fileExistsAtPath:_tempPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
            
        } else {
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
        }
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:_tempPath];
    }
    return self;
}
#pragma mark - 处理数据  步骤2⃣️
- (void)dealWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSURL *url = [loadingRequest.request URL];
    NSURL *newURL = [self getSchemeWithURL:url scheme:@"http"];

    [self downloadMusicWithURLString:[newURL absoluteString] successBlock:^(id responseObject, NSURLSessionDataTask * _Nonnull task) {
        //设置属性
        loadingRequest.contentInformationRequest.contentType = @"audio/mpeg";
        loadingRequest.contentInformationRequest.contentLength = [responseObject length];
        loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
   
        [self processPendingRequests:responseObject loadingRequest:loadingRequest];
    } failedBlock:^(NSError *error) {
        NSLog(@"失败");
    }];
}
#pragma mark - block回调 步骤5⃣️
- (void)processPendingRequests:(id)responseObject loadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    AVAssetResourceLoadingDataRequest *dataRequest = loadingRequest.dataRequest;
    //写到文件
    XHJLog(@"写文件");
    [_fileHandle seekToEndOfFile];
    [_fileHandle writeData:responseObject];
    [_fileHandle closeFile];
    //写入数据库
    [HJDownloadDB addOneDownloadSongWithTitle:getApp().playerView.songModel.songinfo.title song_id:getApp().playerView.songModel.songinfo.song_id author:getApp().playerView.songModel.songinfo.author songModel:getApp().playerView.songModel path:_tempPath];
    //给request提供数据,从返回的数据取
    //回主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [dataRequest respondWithData:[responseObject subdataWithRange:NSMakeRange((NSUInteger)(dataRequest.requestedOffset), (NSUInteger)dataRequest.requestedLength)]];
        [loadingRequest finishLoading];
    });
    
}
#pragma mark - AVAssetResourceLoaderDelegate方法 步骤1⃣️
/**
 *  必须返回Yes，如果返回NO，则resourceLoader将会加载出现故障的数据
 *  这里会出现很多个loadingRequest请求， 需要为每一次请求作出处理
 *  @param resourceLoader 资源管理器
 *  @param loadingRequest 每一小块数据的请求
 *
 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    //这里会调用多次,因为使用的block,所以只在第一次的时候请求网络,
    if (!loadingRequest.dataRequest.requestsAllDataToEndOfResource) {
        [self dealWithLoadingRequest:loadingRequest];  //处理数据
    } else {
        //给request提供数据,从文件中取
            NSData *filedata = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_tempPath] options:NSDataReadingMappedIfSafe error:nil];
        //回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingRequest.dataRequest respondWithData:filedata];
            [loadingRequest finishLoading];
        });
    }
    return YES;
}
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"结束加载");
    [loadingRequest finishLoading];
}
#pragma mark - 下载数据  步骤3⃣️
- (void)downloadMusicWithURLString:(NSString *)URLString successBlock:(void (^)(id responseObject, NSURLSessionDataTask * _Nonnull task))success failedBlock:(void (^)(NSError *))failed{
    //1⃣️请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2⃣️设置请求类型  默认http
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; //json
    manager.requestSerializer.timeoutInterval = 20.0;  //请求超时时间
    //3⃣️返回格式  默认json
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];  //返回原始数据
    //4⃣️添加header信息
    /*
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];//接收类型
     */
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}
- (NSURL *)getSchemeWithURL:(NSURL *)url scheme:(NSString *)scheme {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme = scheme;
    return [components URL];
}
@end
