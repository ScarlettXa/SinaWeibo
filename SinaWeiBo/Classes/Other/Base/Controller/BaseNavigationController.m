/*!
 @header BaseNavigationController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/19
 
 @version 1.00 16/1/19 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "BaseNavigationController.h"
#import "UIBarButtonItem+DS.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if( ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)) {
//        self.edgesForExtendedLayout=UIRectEdgeNone;//下移64
//        self.navigationBar.translucent = NO;
//    }
    self.navigationBar.barTintColor = [UIColor redColor];
    CGSize size = self.navigationBar.intrinsicContentSize;
    MyLog(@"The nav's height is:%f",size.height);
    //返回按钮颜色
    UIImage *backButtonImage = [[UIImage imageNamed:@"navigator_btn_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0],NSFontAttributeName ,nil];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //修改导航栏的外观
//    UINavigationBar *bar = [UINavigationBar appearance];
//    //[bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
//    [bar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]}];
//    
//    //修改所有UIBarButtonItem的外观
//    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
//    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    //修改item上面的文字样式
//    NSDictionary *dict = @{UITextAttributeTextColor:[UIColor purpleColor],UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]};
//    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
//    
//    //设置状态栏样式
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com