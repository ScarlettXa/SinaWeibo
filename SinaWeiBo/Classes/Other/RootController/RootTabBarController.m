//
//  RootTabBarController.m
//  WMVideoPlayer
//
//  Created by 郑文明 on 15/12/14.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeController.h"
#import "FollowersController.h"
#import "MoreController.h"
#import "SquareController.h"
#import "FriendController.h"
#import "BaseNavigationController.h"

@interface RootTabBarController () <UINavigationControllerDelegate>
{
    NSTimer *timer;
    NSInteger count;
}

@end

@implementation RootTabBarController
-(void)autoUploadWifiData{
    count++;
    NSLog(@"count = %ld",count);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.Home
    HomeController *homeVC = [[HomeController alloc]init];
    homeVC.title = @"Home";

    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
    homeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"tabbar_home@2x.png"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected@2x.png"]];
    homeNav.navigationBar.barTintColor = [UIColor redColor];

    
    //2.Follower
    FollowersController *followerVC = [[FollowersController alloc]init];
    followerVC.title = @"Fans";
    BaseNavigationController *followerNav = [[BaseNavigationController alloc]initWithRootViewController:followerVC];
    
    followerNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Fans" image:[UIImage imageNamed:@"message@2x.png"] selectedImage:[UIImage imageNamed:@"message_s@2x.png"]];

    
    //3.More
    MoreController *moreVC = [[MoreController alloc]init];
    moreVC.title = @"More";

    BaseNavigationController *moreNav = [[BaseNavigationController alloc]initWithRootViewController:moreVC];
    moreNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"More" image:[UIImage imageNamed:@"tabbar_more@2x.png"] selectedImage:[UIImage imageNamed:@"tabbar_more_selected@2x.png"]];
    
    //4.Square
    SquareController *squareVC = [[SquareController alloc]init];
    squareVC.title = @"Square";
    
    BaseNavigationController *squareNav = [[BaseNavigationController alloc]initWithRootViewController:squareVC];
    squareNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Square" image:[UIImage imageNamed:@"tabbar_discover@2x.png"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected@2x.png"]];
    
    //5.Friend
    FriendController *friendVC = [[FriendController alloc]init];
    friendVC.title = @"Friend";
    
    BaseNavigationController *friendNav = [[BaseNavigationController alloc]initWithRootViewController:friendVC];
    friendNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Friend" image:[UIImage imageNamed:@"tabbar_more@2x.png"] selectedImage:[UIImage imageNamed:@"tabbar_more_selected@2x.png"]];
    
    self.viewControllers = @[homeNav,followerNav,moreNav,squareNav,friendNav];
    
    self.tabBar.tintColor = [UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com