//
//  NSString+DS.m
//  SinaWeiBo
//
//  Created by TecsonChan on 12/26/15.
//  Copyright © 2015 itcast. All rights reserved.
//

#import "NSString+DS.h"

@implementation NSString (DS)
//
-(NSString *)fileAppend:(NSString *)append
{
    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    if ([imgName hasSuffix:@"@2x"]) {
        NSUInteger length = [imgName length];
        imgName = [imgName substringToIndex:length - 3];
    }
    //MyLog(@"Before append,the imageName is:%@",imgName);
    imgName = [imgName stringByAppendingString:append];
    //MyLog(@"After append,the imageName is:%@",imgName);
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}
@end
