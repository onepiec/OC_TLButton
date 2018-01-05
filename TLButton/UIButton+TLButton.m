//
//  UIButton+TLButton.m
//  TLButton
//
//  Created by yishu on 2018/1/5.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "UIButton+TLButton.h"
#import<objc/runtime.h>

@implementation UIButton (TLButton)

void MethodSwizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

// 通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
- (void)setCs_acceptEventInterval:(NSTimeInterval)cs_acceptEventInterval {
    if (cs_acceptEventInterval >0) {
        MethodSwizzle([UIButton class], @selector(sendAction:to:forEvent:), @selector(cs_sendAction:to:forEvent:));
    }
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)cs_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

//+ (void)load {
//
//    Method timeBefore  = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method timeAfter     = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
//    method_exchangeImplementations(timeBefore, timeAfter);
//
//    Method titleBefore  = class_getInstanceMethod(self, @selector(titleRectForContentRect:));
//    Method titleAfter     = class_getInstanceMethod(self, @selector(cs_titleRectForContentRect:));
//    method_exchangeImplementations(titleBefore, titleAfter);
//
//    Method imageBefore  = class_getInstanceMethod(self, @selector(imageRectForContentRect:));
//    Method imageAfter     = class_getInstanceMethod(self, @selector(cs_imageRectForContentRect:));
//    method_exchangeImplementations(imageBefore, imageAfter);
//}
- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_acceptEventInterval) {
        return;
    }
    if (self.cs_acceptEventInterval > 0) {
        
        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self cs_sendAction:action to:target forEvent:event];
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.cs_acceptEventInterval = 1;
//        MethodSwizzle([UIButton class], @selector(sendAction:to:forEvent:), @selector(cs_sendAction:to:forEvent:));
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.alpha = 0.5f;
    } else {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1;
        }];
    }
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled{
    [super setUserInteractionEnabled:userInteractionEnabled];
    if (userInteractionEnabled) {
        self.alpha = 1;
    }else{
        self.alpha = 0.5;
    }
}
static const char *UIButton_titleRect = "UIButton_titleRect";
- (void)setTitleRect:(CGRect)titleRect {
    if (titleRect.size.width >0 || titleRect.size.height >0) {
        MethodSwizzle([UIButton class], @selector(titleRectForContentRect:), @selector(cs_titleRectForContentRect:));
    }
    objc_setAssociatedObject(self, UIButton_titleRect, @(titleRect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGRect)titleRect {
    return  [objc_getAssociatedObject(self, UIButton_titleRect) CGRectValue];
}

static const char *UIButton_imageRect = "UIButton_imageRect";
- (void)setImageRect:(CGRect)imageRect {
    if (imageRect.size.width >0 || imageRect.size.height >0) {
        MethodSwizzle([UIButton class], @selector(imageRectForContentRect:), @selector(cs_imageRectForContentRect:));
    }
    objc_setAssociatedObject(self, UIButton_imageRect, @(imageRect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGRect)imageRect {
    return  [objc_getAssociatedObject(self, UIButton_imageRect) CGRectValue];
}

- (CGRect)cs_titleRectForContentRect:(CGRect)contentRect{
    return self.titleRect;
}
- (CGRect)cs_imageRectForContentRect:(CGRect)contentRect{
    return self.imageRect;
}
@end
