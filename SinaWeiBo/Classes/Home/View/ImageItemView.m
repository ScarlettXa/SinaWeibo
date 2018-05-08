//
//  ImageItemView.m
//  SinaWeiBo
//
//  Created by TecsonChan on 5/16/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"
#import "FICDPhoto.h"

@interface ImageItemView()
{
    UIImageView *_gifView;
}
@end

@implementation ImageItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif@2x.png"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    
    //1.加载图片
    [HttpTool downloadImage:url place:[UIImage imageNamed:@"timeline_image_loading@2x.png"] imageView:self];
    
    //2.是否为gif
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}

- (void)setOriginalPic:(NSString *)originalPic
{
    //1.加载图片
    _originalPic = originalPic;
    [HttpTool downloadImage:originalPic place:[UIImage imageNamed:@"timeline_image_loading@2x.png"] imageView:self];
    //2.是否为gif
    _gifView.hidden = ![originalPic.lowercaseString hasSuffix:@"gif"];
}

- (void)setBmiddlePic:(NSString *)bmiddlePic
{
    //1.加载图片
    _bmiddlePic = bmiddlePic;
    [HttpTool downloadImage:bmiddlePic place:[UIImage imageNamed:@"timeline_image_loading@2x.png"] imageView:self];
    //2.是否为gif
    _gifView.hidden = ![bmiddlePic.lowercaseString hasSuffix:@"gif"];
}

- (void)setFrame:(CGRect)frame
{
    //1.设置gifView的位置
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifView.frame = gifFrame;
    
    [super setFrame:frame];
}

@end
