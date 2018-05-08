//
//  ImageListView.m
//  SinaWeiBo
//
//  Created by TecsonChan on 5/12/16.
//  Copyright © 2016 itcast. All rights reserved.
// 配图列表

#define kCount 9
#define kOneW 120
#define kOneH 120

#define kMultiW 80
#define kMultiH 80

#define kMargin 5

#import "ImageListView.h"
#import "UIImageView+WebCache.h"
#import "ImageItemView.h"
#import "FICDPhoto.h"
#import "FICDFullscreenPhotoDisplayController.h"
#import "FICImageCache.h"
#import "HttpTool.h"

@interface ImageListView() <UIGestureRecognizerDelegate, FICDFullscreenPhotoDisplayControllerDelegate>
{
    UITapGestureRecognizer *_tapGestureRecognizer;
    BOOL isClick;
}
@end

@implementation ImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //先把有可能显示的控件都加进去
        for (int i = 0; i<kCount; i++) {
            ImageItemView *imageView = [[ImageItemView alloc]init];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    NSUInteger count = imageUrls.count;
    for (int i = 0; i<kCount; i++) {
        //1.取出对应位置的子控件
        ImageItemView *child = self.subviews[i];
        
        child.userInteractionEnabled = YES;
        //2.判断要不要显示图片
        if (i >= count) {
            child.hidden = YES;
            continue;
        }
        //需要显示图片
        child.hidden = NO;
        
        //3.设置图片url
        if (i == 0 && _originalPic != nil) {
            MyLog(@"_originalPic is:%@",_originalPic);
            child.originalPic = _originalPic;
        }else{
            child.url = imageUrls[i][@"thumbnail_pic"];
        }
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        isClick = YES;
        
        _tapGestureRecognizer = singleTap;
        
        [child addGestureRecognizer:singleTap];
        
        //4.设置frame
        if (count == 1) {
            child.contentMode = UIViewContentModeScaleAspectFit;
            child.frame = CGRectMake(0, 0, kOneW, kOneH);
            continue;
        }
        //超出边界的减掉
        child.clipsToBounds = YES;
        child.contentMode = UIViewContentModeScaleAspectFill;
        //child.contentMode = UIViewContentModeScaleAspectFit;
        NSUInteger temp = count == 4 ? 2 : 3;
        CGFloat row = i/temp;//行号
        CGFloat col = i%temp;//列号
        CGFloat x = (kMultiW + kMargin) * col;
        CGFloat y = (kMultiH + kMargin) * row;
        child.frame = CGRectMake(x, y, kMultiW, kMultiH);
        
    }
    
}

- (void)setOriginalPic:(NSString *)originalPic
{
    _originalPic = originalPic;
}

- (void)setBmiddlePic:(NSString *)bmiddlePic
{
    _bmiddlePic = bmiddlePic;
}

- (void)imageTap:(id)sender
{

    //MyLog(@"图片被点击了:%d",isClick);
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    ImageItemView *view = (ImageItemView *) tap.view;
    FICDPhoto *photo = [[FICDPhoto alloc] init];
    MyLog(@"图片被点击了,url是:%@",view.originalPic);
    NSURL *imageUrl = [NSURL URLWithString:view.originalPic];
    //[HttpTool downloadImage:view.url place:[UIImage imageNamed:@"timeline_image_loading@2x.png"] imageView:view];
    [photo setSourceImageURL:imageUrl];
    if (isClick) {
        [[FICDFullscreenPhotoDisplayController sharedDisplayController] showFullscreenPhoto:photo forImageFormatName:FICDPhotoSquareImage32BitBGRAFormatName withThumbnailImageView:view];
        isClick = NO;
    }else{
        [[FICDFullscreenPhotoDisplayController sharedDisplayController] hideFullscreenPhoto];
        isClick = YES;
    }
    
}

+(CGSize)imageListSizeWithCount:(NSUInteger)count
{
    // 1.只有1张图片
    if (count == 1) {
        return CGSizeMake(kOneW, kOneH);
    }
    
    // 2.至少2张图片
    CGFloat countRow = (count == 4) ? 2 : 3;
    // 总行数
    int rows = (count + countRow - 1) / countRow;
    // 总列数
    int columns = (count >= 3) ? 3 : 2;
    
    CGFloat width = columns * kMultiW + (columns - 1) * kMargin;
    CGFloat height = rows * kMultiH + (rows - 1) * kMargin;
    return CGSizeMake(width, height);
}

#pragma mark - FICDFullscreenPhotoDisplayControllerDelegate

- (void)photoDisplayController:(FICDFullscreenPhotoDisplayController *)photoDisplayController willShowSourceImage:(UIImage *)sourceImage forPhoto:(FICDPhoto *)photo withThumbnailImageView:(UIImageView *)thumbnailImageView {
    // If we're running on iOS 7, we'll try to intelligently determine whether the photo contents underneath the status bar is light or dark.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)photoDisplayController:(FICDFullscreenPhotoDisplayController *)photoDisplayController willHideSourceImage:(UIImage *)sourceImage forPhoto:(FICDPhoto *)photo withThumbnailImageView:(UIImageView *)thumbnailImageView {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

@end
