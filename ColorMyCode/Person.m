//
//  Person.m
//  ColorMyCode
//
//  Created by hzyuxiaohua on 2018/6/12.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)createWithName:(NSString *)name age:(NSUInteger)age
{
    Person *p = [Person new];
    p.name = name;
    p.age = age;
    
    return p;
}

@end
