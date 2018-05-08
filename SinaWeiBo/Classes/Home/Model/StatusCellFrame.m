//
//  StatusCellFrame.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/10/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "IconView.h"
#import "ImageListView.h"
#import "Common.h"

@implementation StatusCellFrame
- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    _cellHeight += kStatusDockHeight;
}
@end
