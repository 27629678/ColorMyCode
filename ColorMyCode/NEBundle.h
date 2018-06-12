//
//  NEBundle.h
//  ColorMyCode
//
//  Created by hzyuxiaohua on 2018/6/12.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol NEBundleExport <JSExport>

+ (NSString *)contentWithName:(NSString *)name;

@end

@interface NEBundle : NSObject <NEBundleExport>

+ (NSString *)contentWithName:(NSString *)name;

@end
