//
//  HttpHandleTool.h
//  JJMusic
//
//  Created by coco on 16/1/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HJNetworkType) {
    HJNetworkTypeGET,  //GET请求
    HJNetworkTypePOST  //POST请求
};
@interface HttpHandleTool : NSObject
/**
 *  网络请求  GET、POST
 *
 *  @param networkType 网络请求类型
 *  @param url         网络请求URL
 *  @param params      网络请求参数
 *  @param showHUD     是否显示HUD
 *  @param view         需要显示HUD的view
 *  @param finishBlock 请求成功后的后block (JSON数据)
 *  @param failedBlock 请求失败后的block (错误信息)
 */
+ (void)requestWithType:(HJNetworkType)networkType URLString:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)showHUD inView:(UIView *)view successBlock:(void(^)(id responseObject))successBlock failedBlock:(void(^)(NSError *error))failedBlock;
/**
 *  上传图片 POST
 *
 *  @param url           网络请求URL
 *  @param params        网络请求参数
 *  @param images        上传的图片字典
 *  @param showHUD       是否显示HUD加载条
 *  @param view         需要显示HUD的view
 *  @param successBlock  成功block
 *  @param failedBlock   失败block
 */
+ (void)uploadImagesURLString:(NSString *)url params:(NSDictionary *)params images:(NSDictionary *)images showHUD:(BOOL)showHUD inView:(UIView *)view successBlock:(void(^)(id responseObject))successBlock failedBlock:(void(^)(NSError *error))failedBlock;
@end
