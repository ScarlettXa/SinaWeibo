//
//  Account.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/4/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic,copy) NSString *uid;
@end
