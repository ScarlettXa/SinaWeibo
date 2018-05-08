//
//  IconView.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/12/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "IconView.h"
#import "HttpTool.h"
#import "Common.h"

@interface IconView()
{
    UIImageView *_icon;//头像图片
    UIImageView *_verify;//认证图标
    NSString *_placeholder;//占位图片
}

@end

@implementation IconView

//任何UIView的init方法内部都会调用initWithFrame的方法
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.用户头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        _icon = icon;
        
        // 2.右下角的认证图标
        UIImageView *verify = [[UIImageView alloc] init];
        [self addSubview:verify];
        _verify = verify;
    }
    return self;
}

-(void)setUser:(User *)user type:(IconType)type
{
    self.type = type;
    self.user = user;
}

-(void)setUser:(User *)user
{
    _user = user;
    
    //1.设置用户头像图片
    [HttpTool downloadImage:user.profileImageUrl place:[UIImage imageNamed:_placeholder] imageView:_icon];
    //[_icon setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:_placeholder] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    if ([_user.screenName isEqualToString: @"TecsonChan"]) {
        _user.verifiedType = kVerifiedTypePersonal;
        _user.mbtype = kMBTypeYear;
    }
    
    //2.设置认证图标
    NSString *verifiedIcon = nil;
    
    switch (user.verifiedType) {
        case kVerifiedTypeNone: //没有任何认证
            _verify.hidden = YES;
            break;
        case kVerifiedTypeDaren: //微博达人
            verifiedIcon = @"avatar_grassroot@2x.png";
            break;
        case kVerifiedTypePersonal: //个人
            verifiedIcon = @"avatar_vip@2x.png";
            break;
        default://企业认证
            verifiedIcon = @"avatar_enterprise_vip@2x.png";
            break;
    }
    
    //3.如果有认证,显示图标
    if (verifiedIcon) {
        _verify.hidden = NO;
        _verify.image = [UIImage imageNamed:verifiedIcon];
    }
    
}

-(void)setType:(IconType)type
{
    _type = type;
    
    //1判断类型
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: //小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            _placeholder = @"avatar_default_small@2x.png";
            break;
        case kIconTypeDefault://中图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            _placeholder = @"avatar_default@2x.png";
            break;
        case kIconTypeBig: //大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            _placeholder = @"avatar_default@_big@2x.png";
            break;
    }
    
    //2.设置frame
    _icon.frame = (CGRect){CGPointZero, iconSize};
    _verify.bounds = CGRectMake(0, 0, kVerifyW, kVerifyH);
    _verify.center = CGPointMake(iconSize.width, iconSize.height);
    
    //3.自己的宽高
    CGFloat width = iconSize.width + kVerifyW * 0.5;
    CGFloat height = iconSize.height + kVerifyH * 0.5;
    self.bounds = (CGRectMake(0, 0, width, height));
    
}

+(CGSize)iconSizeWithType:(IconType)type
{
    //1判断类型
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: //小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            break;
        case kIconTypeDefault://中图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
        case kIconTypeBig: //大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
    }
    CGFloat width = iconSize.width + kVerifyW * 0.5;
    CGFloat height = iconSize.height + kVerifyH * 0.5;
    return CGSizeMake(width, height);
}


//重写setFrame可以防止外界修改frame,将frame固定.
//-(void)setFrame:(CGRect)frame
//{
//    //MyLog(@"IconView Frame:%@",NSStringFromCGRect(self.bounds));
//    frame.size = self.bounds.size;
//    
//    [super setFrame:frame];
//}

@end
