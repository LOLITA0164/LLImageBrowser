//
//  LLPhotoTool.m
//  LLPhotoBrowser_Example
//
//  Created by 骆亮 on 2019/12/19.
//  Copyright © 2019 LOLITA0164. All rights reserved.
//

#import "LLPhotoTool.h"
#import <Photos/PHPhotoLibrary.h>

@implementation LLPhotoTool

/// 识别数据中的二维码信息
+(NSString*)identifyQRCodeWithData:(NSData*)data{
    NSString* content = @"";
    if (data.length == 0) { return content; }
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage* ciImage = [CIImage imageWithData:data];
    NSArray* features = [detector featuresInImage:ciImage];
    if (features.count) {
        CIQRCodeFeature* feature = [features objectAtIndex:0];
        content = feature.messageString;
    }
    return content;
}
/// 识别网络图片中的二维码信息
+(void)identifyQRCodeWithURLString:(NSString*)urlString result:(void(^)(NSString*))block{
    if (urlString.length == 0) { return; }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString* content = [self identifyQRCodeWithData:data];
            if (block) {
                block(content);
            }
        });
    });
}

/// 是否存在二维码
+(BOOL)existQRCodeWithData:(NSData*)data{
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage* ciImage = [CIImage imageWithData:data];
    NSArray* features = [detector featuresInImage:ciImage];
    return features.count;
}
/// 是否存在二维码
+(void)existQRCodeWithUrl:(NSString*)url result:(void(^)(BOOL))block{
    if (url.length == 0) { return; }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL result = [self existQRCodeWithData:data];
            if (block) {
                block(result);
            }
        });
    });
}

/// 保存网络图片
+(void)saveImageWithURLString:(NSString*)url{
    if (url.length==0) { return; }
    // 判断是否具有私有权限
    if ([self canPhotoLibary] == NO) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未开启相册权限，是否前往设置？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self.rootCtrl presentViewController:alert animated:YES completion:nil];
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    });
}
+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *msg = nil ;
    if(error != NULL){ msg = @"保存图片失败"; } else { msg = @"保存图片成功"; }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

+(UIViewController*)rootCtrl{
    return UIApplication.sharedApplication.windows.firstObject.rootViewController;
}

/// 当前是否有访问相册的权限
+(BOOL)canPhotoLibary{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

@end
