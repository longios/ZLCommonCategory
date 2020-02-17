//
//  UIButton+ZLJExpandTouch.m
//  XiongMao
//
//  Created by lq2 on 2019/4/2.
//  Copyright © 2019 深圳市万事富科技有限公司. All rights reserved.
//

#import "UIButton+ZLJExpandTouch.h"
#import <objc/runtime.h>

@implementation UIButton (ZLJExpandTouch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(pointInside:withEvent:);
        SEL swizzledSelector = @selector(zlj_pointInside:withEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if(success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
   
}



- (BOOL)zlj_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.zlj_touchInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self zlj_pointInside:point withEvent:event]; // original implementation
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.zlj_touchInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setZlj_touchInset:(UIEdgeInsets)zlj_touchInset {
    objc_setAssociatedObject(self, @selector(zlj_touchInset), [NSValue valueWithUIEdgeInsets:zlj_touchInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)zlj_touchInset {
    NSValue *value = objc_getAssociatedObject(self, @selector(zlj_touchInset));
    return [value UIEdgeInsetsValue];
}

@end
