//
//  UITextField+ZLJ.m
//  ZuJianHuaTest2_Example
//
//  Created by lq2 on 2020/2/16.
//  Copyright © 2020 lq2. All rights reserved.
//

#import "UITextField+ZLJ.h"


@implementation UITextField (ZLJ)


+ (instancetype)fieldWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UITextField *field = [[self alloc] init];
    field.textColor = textColor;
    field.font = [UIFont systemFontOfSize:fontSize];
    return field;
}

@end
