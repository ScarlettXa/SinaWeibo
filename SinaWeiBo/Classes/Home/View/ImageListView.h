//
//  ImageListView.h
//  SinaWeiBo
//
//  Created by TecsonChan on 5/12/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

//所有图片的url
@property (nonatomic,strong) NSArray *imageUrls;

@property (nonatomic,copy) NSString *originalPic;
@property (nonatomic,copy) NSString *bmiddlePic;

+ (CGSize)imageListSizeWithCount:(NSUInteger)count;
@end
