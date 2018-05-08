//
//  StatusDetailFrame.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusDetailCellFrame.h"

@implementation StatusDetailCellFrame
- (void)setStatus:(Status *)status
{
    [super setStatus:status];

    if (status.retweetedStatus) {
        _retweetedFrame.size.height += 30;
        _cellHeight += 30;
    }
    
}
@end
