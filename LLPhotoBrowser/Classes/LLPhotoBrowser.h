//
//  PhotoBrowser.h
//  PhotoBrowser
//
//  Created by LOLITA on 2017/8/31.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPhotoTool.h"

@class LLPhotoBrowser;
@protocol PhotoBrowserDelegate <NSObject>
@optional
/**
 @param photoBrowser 图片浏览器
 @param currentPage 当前图片下标
 */
/// 主线程
-(UIView *)photoBrowser:(LLPhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage;
/// 配合视图滚动使用
-(void)photoBrowser:(LLPhotoBrowser *)photoBrowser didScrollToPage:(NSInteger)currentPage completion:(void(^)(UIView *))completion;
/// 结束显示
-(void)photoBrowser:(LLPhotoBrowser *)photoBrowser didHidden:(NSInteger)currentPage;
/// 长按事件
-(void)photoBrowser:(LLPhotoBrowser *)photoBrowser longPress:(UILongPressGestureRecognizer*)longPress;
@end




@interface LLPhotoBrowser : UIView
@property (weak, nonatomic) id <PhotoBrowserDelegate> delegate;
@property (copy, nonatomic) void(^didHiddenBlock)(void);
@property (assign ,nonatomic, readonly) NSInteger currentPage;      // 当前页

/**
 加载本地图片
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showLocalImages:(NSArray*)images selectedIndex:(NSInteger)index selectedView:(UIView *)selectedView;;

/**
 加载网络图片
 @note selectedView 可选参数：一般来说是一个imageView，关闭浏览器时会将这个视图移回原来的位置
 */
+(instancetype)showURLImages:(NSArray*)images placeholderImage:(UIImage *)image selectedIndex:(NSInteger)index  selectedView:(UIView *)selectedView;

/// 主动隐藏
-(void)hidden;

@end





@interface PhotoBrowserCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property (strong ,nonatomic) UIScrollView *scrollView;
@end




