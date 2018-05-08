//
//  BaseTextCell.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseWordCell.h"
@class BaseTextCellFrame;
@interface BaseTextCell : BaseWordCell
@property (nonatomic, strong) BaseTextCellFrame *cellFrame;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) UITableView *myTableView;
@end
