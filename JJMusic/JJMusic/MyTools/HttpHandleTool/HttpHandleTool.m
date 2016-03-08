//
//  HttpHandleTool.m
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HttpHandleTool.h"
#import <AFNetworking.h>  //网络请求
#import <MBProgressHUD.h>  //菊花
@implementation HttpHandleTool
//GET、POST 请求
+ (void)requestWithType:(HJNetworkType)networkType URLString:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)showHUD inView:(UIView *)view cache:(BOOL)cache successBlock:(void (^)(id))successBlock failedBlock:(void (^)(NSError *))failedBlock {
    //归档地址
    NSString *path = pathCachesFilePathName(@"networkRequest", STRFORMAT(@"%ld.xxoo", [url hash]));
    
    //url中有汉字 需要编码
    //对应解码方法:解码使用stringByRemovingPercentEncoding方法
//    if (ISIOS_7_0) {
//        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    } else {
//        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
    
    if (showHUD) {
        
    }
    
    //1⃣️请求管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //2⃣️设置返回格式, 默认JSON支持:application/json   text/json    text/javascript
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html , 也可以在AFURLResponseSerialization里面的init方法中设置, 一劳永逸self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //3⃣️设置请求格式  默认HTTP
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 30;  //请求时间30s, 默认60s
    /*
     //4⃣️添加header头信息, 需要根据具体情况添加
     srand((unsigned)time(0));  //随机种子
     NSString *noncestr = STRFORMAT(@"%d", rand()); //随机串
     NSString *timeStamp = [HJCommonTools getTimestampWithType:TimestampTpyeMillisecond]; //时间戳
     NSString *signture = STRFORMAT(@"%@%@%@", ServerAPPKey, noncestr, timeStamp);
     [session.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];   //置请求内容的类型   json数据,使用utf-8编码
     [session.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];//接收类型
     [session.requestSerializer setValue:noncestr forHTTPHeaderField:@"nonce"];  //随机串
     [session.requestSerializer setValue:timeStamp forHTTPHeaderField:@"timestamp"]; //时间戳
     [session.requestSerializer setValue:[HJCommonTools returnAStringWithEncryptType:EncryptTypeSHA256 forString:signture] forHTTPHeaderField:@"sign"];
     */
    //5⃣️开始请求
    switch (networkType) {
        case HJNetworkTypeGET://get请求
        {
            [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"请求成功:\n*** 请求接口URL: %@\n参数:\n%@\n返回数据:\n%@\n", url, [params description], responseObject);
//                NSLog(@"请求成功:\n*** 请求接口URL: %@\n参数:\n%@\n", url, [params description]);
                if (showHUD) {
                    
                }
                if (successBlock) {
                    //存在caches中
                    if (responseObject != nil) {
                        [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
                    }
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"请求失败:\n*** 请求接口URL: %@\n参数:\n%@\nERROR:%@\n返回数据:\n%@\n", url, [params description], error, task.taskDescription);
                if (showHUD) {
                    
                }
                //请求失败的时候,从caches中取,取到的数据不为空
                id data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if (data != nil && cache) {
                    successBlock(data);
                } else {
                    if (failedBlock) {
                        failedBlock(error);
                    }
                }
            }];
        }
            break;
        case HJNetworkTypePOST:  //post请求
        {
            [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"当前请求成功:\n*** 请求接口URL: %@\n参数:\n%@\n返回数据:\n%@\n", url, [params description], responseObject);
                if (showHUD) {
                    
                }
                if (successBlock) {
                    //存在caches中
                    if (responseObject != nil && cache) {
                        [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
                    }
                    successBlock(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"当前请求失败:\n*** 请求接口URL: %@\n参数:\n%@\nERROR:%@\n返回数据:\n%@\n", url, [params description], error, task.taskDescription);
                if (showHUD) {
                    
                }
                //请求失败的时候,从caches中取,取到的数据不为空
                id data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if (data != nil && cache) {
                    successBlock(data);
                } else {
                    if (failedBlock) {
                        failedBlock(error);
                    }
                }
            }];
        }
            break;
    }
}

//上传图片
+ (void)uploadImagesURLString:(NSString *)url params:(NSDictionary *)params images:(NSDictionary *)images showHUD:(BOOL)showHUD inView:(UIView *)view successBlock:(void (^)(id))successBlock failedBlock:(void (^)(NSError *))failedBlock {
    if (ISIOS_7_0) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (showHUD) {
        
    }
    //1⃣️请求管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //2⃣️设置返回格式, 默认JSON支持:application/json   text/json    text/javascript
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html , 也可以在AFURLResponseSerialization里面的init方法中设置, 一劳永逸self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //3⃣️设置请求格式  默认HTTP
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 30;  //请求时间30s, 默认60s
    /*
     //4⃣️添加header头信息, 需要根据具体情况添加
     srand((unsigned)time(0));  //随机种子
     NSString *noncestr = STRFORMAT(@"%d", rand()); //随机串
     NSString *timeStamp = [HJCommonTools getTimestampWithType:TimestampTpyeMillisecond]; //时间戳
     NSString *signture = STRFORMAT(@"%@%@%@", ServerAPPKey, noncestr, timeStamp);
     [session.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];   //置请求内容的类型   json数据,使用utf-8编码
     [session.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];//接收类型
     [session.requestSerializer setValue:noncestr forHTTPHeaderField:@"nonce"];  //随机串
     [session.requestSerializer setValue:timeStamp forHTTPHeaderField:@"timestamp"]; //时间戳
     [session.requestSerializer setValue:[HJCommonTools returnAStringWithEncryptType:EncryptTypeSHA256 forString:signture] forHTTPHeaderField:@"sign"];
     */
    //5⃣️开始上传
    [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 图片上传
        for (NSString *nameKey in [images allKeys])
        {
            // 上传时使用当前的系统时间做为文件名
            NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
            formatter.dateFormat  = @"yyyyMMddHHmmssSSS";
            NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
            // 上传的图片转成data格式
            UIImage *image  = [images objectForKey:nameKey];
            NSData *data    = UIImageJPEGRepresentation(image, 0.5);
            
            /**
             *  appendPartWithFileData  //  指定上传的文件
             *  name                    //  指定在服务器中获取对应文件或文本时的key
             *  fileName                //  指定上传文件的原始文件名
             *  mimeType                //  指定上传文件的MIME类型
             */
            [formData appendPartWithFileData:data name:nameKey fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"返回数据:\n%@\n图片上传成功: %@\n", task.taskDescription, responseObject);
        if (showHUD) {
            
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"返回数据:\n%@\n图片上传失败: %@\n", task.taskDescription, error);
        if (showHUD) {
            
        }
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
@end
