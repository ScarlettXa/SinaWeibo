//
//  StatusDock.h
//  SinaWeiBo
//
//  Created by TecsonChan on 5/17/16.
//  Copyright © 2016 itcast. All rights reserved.
//  一条微博的操作条

#import <UIKit/UIKit.h>
#import "Status.h"
//@class比import的编译效率高
//@class Status;
@interface StatusDock : UIImageView
@property (nonatomic,strong) Status *status;
@end
