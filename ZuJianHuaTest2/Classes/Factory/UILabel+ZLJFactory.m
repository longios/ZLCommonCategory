//
//  UILabel+ZLJFactory.m
//  ZuJianHuaTest2_Example
//
//  Created by lq2 on 2020/2/16.
//  Copyright © 2020 lq2. All rights reserved.
//

#import "UILabel+ZLJFactory.h"



@implementation UILabel (ZLJFactory)

+ (instancetype)labelWithColor:(UIColor *)color fontSize:(CGFloat)fontSize {
    UILabel *label = [[self alloc] init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

@end
