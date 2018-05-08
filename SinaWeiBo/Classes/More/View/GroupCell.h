//
//  GroupCell.h
//  SinaWeiBo
//
//  Created by TecsonChan on 2/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseCell.h"

typedef enum {
    kCellTypeNone, //没有样式
    kCellTypeArrow, //箭头
    kCellTypeLabel, //文字
    kCellTypeSwitch //开关
} CellType;

@interface GroupCell : BaseCell

@property (nonatomic,readonly) UISwitch *rightSwitch;

@property (nonatomic,readonly) UILabel *rightLabel;

@property (nonatomic,assign) CellType cellType;

@property (nonatomic,strong) NSIndexPath *indexPath;

//为防止循环引用，所以用weak.
@property (nonatomic,weak) UITableView *myTableView;

@end
