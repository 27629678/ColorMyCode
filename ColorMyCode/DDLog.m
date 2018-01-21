//
//  DDLog.m
//  ColorMyCode
//
//  Created by hzyuxiaohua on 21/01/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "DDLog.h"

@implementation DDLog

+ (void)debug:(JSValue *)msg
{
    NSLog(@"--js--[D]:%@",msg.toString);
}

@end
