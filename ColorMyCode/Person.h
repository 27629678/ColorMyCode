//
//  Person.h
//  ColorMyCode
//
//  Created by hzyuxiaohua on 2018/6/12.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol PersonExport <JSExport>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;

+ (instancetype)createWithName:(NSString *)name age:(NSUInteger)age;

@end

@interface Person : NSObject <PersonExport>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;

+ (instancetype)createWithName:(NSString *)name age:(NSUInteger)age;

@end
