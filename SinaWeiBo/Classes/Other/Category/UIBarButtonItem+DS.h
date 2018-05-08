//
//  UIBarButtonItem+DS.h
//  SinaWeiBo
//
//  Created by TecsonChan on 1/25/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DS)

- (id)initWithIcon:(NSString *)icon hightlightedIcon:(NSString *)highlighted target:(nullable id)target action:(SEL)action;

+ (id)itemWithIcon:(NSString *)icon hightlightedIcon:(NSString *)highlighted target:(nullable id)target action:(SEL)action;

@end
