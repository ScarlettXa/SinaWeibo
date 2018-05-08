//
//  MoreController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/19/16.
//  Copyright © 2016 itcast. All rights reserved.
//

@interface LogoutBtn : UIButton

@end

@implementation LogoutBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return  CGRectMake(x, y, width, height);
}

@end

#import "MoreController.h"
#import "UIImage+MJ.h"
#import "GroupCell.h"
#import "AccountsController.h"

@interface MoreController ()
{
    NSArray *_data;
}

@end

@implementation MoreController

#pragma mark 重写这个方法的目的是:去掉父类默认的操作:显示滚动条.
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.搭建UI界面
    [self buildUI];
    
    //2.读取plist文件的内容
    [self loadPlist];
    
    //3.设置tableView属性
    [self buildTableView];
    
}

#pragma mark 设置tableView属性
- (void)buildTableView
{
    //1.设置背景
    //backgroundView的优先级 > backgroundColor
    self.tableView.backgroundView = nil;
    //0~1
    self.tableView.backgroundColor = kGlobalBackgroundColor;
    //2.设置tableView每组头部的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    
    //3.要在tableView底部添加一个按钮
    LogoutBtn *logout = [LogoutBtn buttonWithType:UIButtonTypeCustom];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    logout.bounds = CGRectMake(0, 0, 0, 44);
    
    //设置按钮文字
    [logout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    
    //logout.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.tableFooterView = logout;
    
    //增加底部额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _data.count - 1) {
        return 10;
    }
    
    return 0;
}

#pragma mark -搭建UI见面
- (void)loadPlist
{
    //1.获得路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"more" withExtension:@"plist"];
    
    // 当前所在地的使用语言
    //NSLocale *currentLocale = [NSLocale currentLocale];
    //MyLog(@"Language Code is %@", [currentLocale objectForKey:NSLocaleLanguageCode]);
    //NSString *language = [currentLocale objectForKey:NSLocaleLanguageCode];
    //2.读取数据
    _data = [NSArray arrayWithContentsOfURL:url];
//    if ([language isEqual:@"zh"]) {
//        _data = [NSDictionary dictionaryWithContentsOfURL:url][@"zh_CN"];
//    }else if([language isEqual:@"en"]){
//        _data = [NSDictionary dictionaryWithContentsOfURL:url][@"en_US"];
//    }
    
    //[array writeToFile:@"/Users/tecsonchan/Desktop/more.plist" atomically:YES];
    
}

#pragma mark -搭建UI见面
- (void)buildUI
{
    //1.设置标题
    self.title = @"More";
    
    //3.设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.设置右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSArray *array = _data[section];
//    
//    return array.count;
    
    return [_data[section] count];
}

#pragma mark 每当有一个新的cell进入屏幕视野范围内就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //forIndexPath:indexPath 跟 storyboard配套使用的
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
        
    //1.取出这行对应的字典数据
    NSDictionary *dict = _data[indexPath.section][indexPath.row];
    
    //2.设置文字
    cell.textLabel.text = dict[@"name"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    //3.设置cell的背景
    cell.indexPath = indexPath;
    
    //4.设置cell的类型 (设置右边显示什么东西)
    if (indexPath.section == 2) {
        cell.cellType = kCellTypeLabel;
        cell.rightLabel.text = indexPath.row?@"有图模式":@"经典模式";
    }else{
        cell.cellType = kCellTypeArrow;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        //跳到账号管理控制器
        AccountsController *accounts = [[AccountsController alloc] init];
        [self.navigationController pushViewController:accounts animated:YES];
    }
}

@end
