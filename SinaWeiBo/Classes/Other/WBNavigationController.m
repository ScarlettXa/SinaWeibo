//
//  WBNavigationController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/25/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改导航栏的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    //[bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];
    
    //修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //修改item上面的文字样式
    NSDictionary *dict = @{UITextAttributeTextColor:[UIColor purpleColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]};
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    //设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    [super pushViewController:viewController animated:YES];
//}

@end
