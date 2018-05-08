//
//  MessageController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/24/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "FriendshipController.h"
#import "GroupCell.h"
#import "FriendshipTool.h"
#import "AccountTool.h"
#import "User.h"
#import "HttpTool.h"

@interface FriendshipController ()

@end

@implementation FriendshipController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    _data = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    User *u = _data[indexPath.row];
    
    //头像
    [HttpTool downloadImage:u.profileImageUrl place:[UIImage imageNamed:@"Icon.png"] imageView:cell.imageView];
    
    //昵称
    cell.textLabel.text = u.screenName;
    
    return cell;
}

@end
