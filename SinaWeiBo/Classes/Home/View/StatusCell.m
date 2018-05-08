//
//  StatusCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/10/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDock.h"

@interface StatusCell()
{    
    StatusDock *_dock; //底部的操作条
}

@end

@implementation StatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //操作条
        NSUInteger y = self.frame.size.height - kStatusDockHeight;
        _dock = [[StatusDock alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
        [self.contentView addSubview:_dock];
    }
    return self;
}


- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    _dock.status = cellFrame.status;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= kTableBorderWidth * 2;
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

@end
