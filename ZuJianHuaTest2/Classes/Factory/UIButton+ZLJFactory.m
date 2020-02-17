//
//  UIButton+ZLJFactory.m
//  ZuJianHuaTest2_Example
//
//  Created by lq2 on 2020/2/16.
//  Copyright © 2020 lq2. All rights reserved.
//

#import "UIButton+ZLJFactory.h"

@implementation UIButton (ZLJFactory)

+ (instancetype)buttonWithTitle:(NSString *)btnTitle Image:(UIImage *)btnImage {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:btnTitle forState:UIControlStateNormal];
    [button setImage:btnImage forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

+ (instancetype)buttonWithBgImage:(UIImage *)bgImage {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

@end
