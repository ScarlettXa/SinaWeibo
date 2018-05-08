//
//  IconView.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/12/16.
//  Copyright © 2016 itcast. All rights reserved.
//  头像

#import <UIKit/UIKit.h>
#import "User.h"

typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
}IconType;

@interface IconView : UIView

@property (nonatomic,strong) User *user;
@property (nonatomic,assign) IconType type;

-(void)setUser:(User *)user type:(IconType)type;

+ (CGSize)iconSizeWithType:(IconType)type;
@end
