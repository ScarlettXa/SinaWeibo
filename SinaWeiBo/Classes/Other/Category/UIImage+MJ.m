//
//  UIImage+MJ.m
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+MJ.h"
#import "NSString+DS.h"

@implementation UIImage (MJ)
#pragma mark 加载全屏的图片
// new_feature_1.png
+ (UIImage *)fullscrennImage:(NSString *)imgName
{
    // 1.如果是iPhone5 或者是iPhone6s，对文件名特殊处理
    if (iPhone5 || iPhone6s) {
        imgName = [imgName fileAppend:@"-568h@2x"];
    }
    
    // 2.加载图片
    return [self imageNamed:imgName];
}

#pragma mark 加载全屏的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
//    UIImage *image = [UIImage imageNamed:imgName];
//    
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.width * 0.5, image.size.height * 0.5) resizingMode:UIImageResizingModeTile];
    
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+(UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    
    //image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.width * 0.5, image.size.height * 0.5) resizingMode:UIImageResizingModeTile];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

@end
