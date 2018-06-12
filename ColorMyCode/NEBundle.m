//
//  NEBundle.m
//  ColorMyCode
//
//  Created by hzyuxiaohua on 2018/6/12.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "NEBundle.h"

@implementation NEBundle

+ (NSString *)contentWithName:(NSString *)name
{
    NSArray *components = [name componentsSeparatedByString:@"."];
    if (components.count != 2) {
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:components.firstObject
                                                     ofType:components.lastObject];
    if (path.length == 0) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
