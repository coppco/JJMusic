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

@interface HJMusicLoader () <AVAssetResourceLoaderDelegate>
HJpropertyCopy(NSString *tempPath);  //音乐本地地址
HJpropertyStrong(NSFileHandle *fileHandle);  //写数据
@end

@implementation HJMusicLoader
- (instancetype)init {
    self = [super init];
    if (self) {
        _tempPath = pathCachesFilePathName(@"音乐", STRFORMAT(@"%@_%@.mp3", [[[HJMusicTool sharedMusicPlayer].model songinfo] title], [[[HJMusicTool sharedMusicPlayer].model songinfo] song_id]));
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
    
//    //添加信息
//    NSString *mimeType = @"audio/mpeg";
//    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
//    AVAssetResourceLoadingContentInformationRequest *contentInformationRequest = loadingRequest.contentInformationRequest;
//    contentInformationRequest.byteRangeAccessSupported = YES;
//    contentInformationRequest.contentType = CFBridgingRelease(contentType);
//    contentInformationRequest.contentLength = (unsigned long long)1555041;

    [self downloadMusicWithURLString:[newURL absoluteString] successBlock:^(id responseObject, NSURLSessionDataTask * _Nonnull task) {
        //每次请求完成都执行方法
        NSLog(@"成功:数据长度%ld", [responseObject length]);
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)(task.response);
        
        NSDictionary *dic = (NSDictionary *)[httpResponse allHeaderFields] ;
        
        NSString *content = [dic valueForKey:@"Content-Range"];
        NSArray *array = [content componentsSeparatedByString:@"/"];
        NSString *length = array.lastObject;
        
        NSUInteger videoLength;
        
        if ([length integerValue] == 0) {
            videoLength = (NSUInteger)httpResponse.expectedContentLength;
        } else {
            videoLength = [length integerValue];
        }
        
        NSString *mimeType = dic[@"Content-Type"];
        CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
        AVAssetResourceLoadingContentInformationRequest *contentInformationRequest = loadingRequest.contentInformationRequest;
        contentInformationRequest.byteRangeAccessSupported = YES;
        contentInformationRequest.contentType = CFBridgingRelease(contentType);
        contentInformationRequest.contentLength = (unsigned long long)videoLength;
        
        [self processPendingRequests:responseObject loadingRequest:loadingRequest];
    } failedBlock:^(NSError *error) {
        NSLog(@"失败");
    }];
}
#pragma mark - block回调 步骤5⃣️
- (void)processPendingRequests:(id)responseObject loadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    AVAssetResourceLoadingDataRequest *dataRequest = loadingRequest.dataRequest;
    //写到文件
    [_fileHandle seekToEndOfFile];
    [_fileHandle writeData:responseObject];

    //给request提供数据

    
    NSData *filedata = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_tempPath] options:NSDataReadingMappedIfSafe error:nil];
    XHJLog(@"%ld", filedata.length);
    [dataRequest respondWithData:[responseObject subdataWithRange:NSMakeRange(20, 2300)]];
    [loadingRequest finishLoading];
    
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
     [self dealWithLoadingRequest:loadingRequest];  //处理数据
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
