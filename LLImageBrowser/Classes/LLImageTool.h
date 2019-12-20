//
//  LLImageTool.h
//  LLPhotoBrowser_Example
//
//  Created by 骆亮 on 2019/12/19.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLImageTool : NSObject
/// 识别数据中的二维码信息
+(NSString*)identifyQRCodeWithData:(NSData*)data;
/// 识别网络图片中的二维码信息
+(void)identifyQRCodeWithURLString:(NSString*)url result:(void(^)(NSString*))block;
/// 数据是否存在二维码
+(BOOL)existQRCodeWithData:(NSData*)data;
/// 网络图片是否存在二维码
+(void)existQRCodeWithUrl:(NSString*)url result:(void(^)(BOOL))block;
/// 保存网络图片
+(void)saveImageWithURLString:(NSString*)url;
/// 当前是否有访问相册的权限
+(BOOL)canPhotoLibary;

@end

