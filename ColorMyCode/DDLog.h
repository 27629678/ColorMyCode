//
//  DDLog.h
//  ColorMyCode
//
//  Created by hzyuxiaohua on 21/01/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol DDLogExportProtocol <JSExport>

+ (void)debug:(JSValue *)msg;

@end

@interface DDLog : NSObject <DDLogExportProtocol>

+ (void)debug:(JSValue *)msg;

@end
