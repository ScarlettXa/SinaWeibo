//
//  BaseCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseCell.h"



@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.设置背景
        [self setBackgroud];
    }
    return self;
}

- (void)setBackgroud
{
    UIImageView *bg = [[UIImageView alloc] init];
    self.backgroundView = bg;
    _bg = bg;
    
    UIImageView *selectedBg = [[UIImageView alloc] init];
    self.selectedBackgroundView = selectedBg;
    _selectedBg = selectedBg;
    
}

@end
