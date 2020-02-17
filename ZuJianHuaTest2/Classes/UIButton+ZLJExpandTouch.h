//
//  UIButton+ZLJExpandTouch.h
//  XiongMao
//
//  Created by lq2 on 2019/4/2.
//  Copyright © 2019 深圳市万事富科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZLJExpandTouch)
// 拓宽同层级的点击范围   跨层级不响应  负数扩大正数减小
@property(assign, nonatomic) UIEdgeInsets zlj_touchInset;

@end

NS_ASSUME_NONNULL_END
