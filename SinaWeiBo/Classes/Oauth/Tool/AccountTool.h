//
//  AccountTool.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/4/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"

@interface AccountTool : NSObject

single_interface(AccountTool)

- (void)saveAccount:(Account *)account;

//获得当前账号
@property (nonatomic,readonly) Account *account;
@end
