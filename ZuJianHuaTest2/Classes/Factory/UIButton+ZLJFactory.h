//
//  UIButton+ZLJFactory.h
//  ZuJianHuaTest2_Example
//
//  Created by lq2 on 2020/2/16.
//  Copyright © 2020 lq2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZLJFactory)

+ (instancetype)buttonWithTitle:(NSString *)btnTitle Image:(UIImage *)btnImage;

+ (instancetype)buttonWithBgImage:(UIImage *)bgImage;

@end

NS_ASSUME_NONNULL_END
