//
//  ViewController.m
//  ColorMyCode
//
//  Created by hzyuxiaohua on 21/01/2018.
//  Copyright © 2018 hzyuxiaohua. All rights reserved.
//

#import "ViewController.h"

#import "DDLog.h"
#import "Person.h"
#import "NEBundle.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@property (nonatomic, strong) JSContext *context;

@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // exception handler
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"[Exception]: %@", exception);
    };
    
    // load java script
    [self.context evaluateScript:[ViewController originJavaScriptString]];
    [self.context evaluateScript:@"colors.greeting()"];
    
    self.textview.attributedText = [self attributedString:[ViewController originTextViewText]];
    
    Person *p = [Person new];
    p.name = @"demo";
    p.age = 10;
    
    JSValue *function = self.context[@"colors"][@"printPerson"];
    [function callWithArguments:@[p]];
}

- (IBAction)reloadBtnAction:(id)sender
{
    self.textview.attributedText = [self attributedString:self.textview.text];
}

#pragma mark - private

- (NSAttributedString *)attributedString:(NSString *)raw
{
    NSArray *components =
    [raw componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:raw];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont systemFontOfSize:22]
                 range:NSMakeRange(0, text.length)];
    
    for (NSString *item in components) {
        UIColor *color = [self colorForWord:item];
        if (!color) {
            continue;
        }
        
        NSRange range = [raw rangeOfString:item];
        if (range.location == NSNotFound) {
            continue;
        }
        
        [text addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    return text.copy;
}

- (UIColor *)colorForWord:(NSString *)word
{
    NSString *script = [NSString stringWithFormat:@"colors.colorForWord('%@');", word];
    NSDictionary *c = [self.context evaluateScript:script].toDictionary;
    
    if (c.count == 0) {
        return [UIColor blackColor];
    }
    
    CGFloat r = [c[@"r"] floatValue]/255.f;
    CGFloat g = [c[@"g"] floatValue]/255.f;
    CGFloat b = [c[@"b"] floatValue]/255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

#pragma mark - getter & setter

- (JSContext *)context
{
    if (!_context) {
        _context = [JSContext new];
        _context[@"ddlog"] = [DDLog class];
        _context[@"NEBundle"] = [NEBundle class];
        
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
