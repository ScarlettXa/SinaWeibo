//
//  UIBarButtonItem+DS.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/25/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "UIBarButtonItem+DS.h"

@implementation UIBarButtonItem (DS)
-(id)initWithIcon:(NSString *)icon hightlightedIcon:(NSString *)highlightedIcon target:(id)target action:(SEL)action
{
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置普通背景图片
    UIImage *image = [UIImage imageNamed:icon];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    //设置高亮图片
    [btn setBackgroundImage:[UIImage imageNamed:highlightedIcon] forState:UIControlStateHighlighted];
    
    //设置尺寸
    btn.bounds = (CGRect){CGPointZero,image.size};
    
    //添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+(id)itemWithIcon:(NSString *)icon hightlightedIcon:(NSString *)highlightedIcon target:(id)target action:(SEL)action
{
    
    return [[self alloc]initWithIcon:icon hightlightedIcon:highlightedIcon target:target action:action];
}

@end
