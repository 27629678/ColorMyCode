//
//  ViewController.m
//  ColorMyCode
//
//  Created by hzyuxiaohua on 21/01/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "ViewController.h"

#import "DDLog.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@property (nonatomic, strong) JSContext *context;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textview.text = [ViewController originTextViewText];
    
    // exception handler
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"[Exception]: %@", exception);
    };
    
    // load java script
    [self.context evaluateScript:[ViewController originJavaScriptString]];
    [self.context evaluateScript:@"colors.greeting()"];
}

- (IBAction)reloadBtnAction:(id)sender
{
    
}

#pragma mark - private

- (NSAttributedString *)attributedString
{
    return nil;
}

#pragma mark - getter & setter

- (JSContext *)context
{
    if (!_context) {
        _context = [JSContext new];
        _context[@"ddlog"] = [DDLog class];
        
        NSLog(@"%@", [_context evaluateScript:@"ddlog.debug('ddlog module installed.')"].toString);
    }
    
    return _context;
}

#pragma mark - static resources

+ (NSString *)originJavaScriptString
{
    static NSString *javascript = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        javascript = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    });
    
    return javascript;
}

+ (NSString *)originTextViewText
{
    static NSString *text = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        text = @"The quick brown fox jumped over the lazy red dog to eat the yellow hen in the blue coop.";
    });
    
    return text;
}

@end
