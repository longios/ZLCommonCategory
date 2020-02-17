//
//  NSMutableArray+ZLJSwiftExtension.h
//  XiongMao
//
//  Created by lq2 on 2019/6/20.
//  Copyright © 2019 深圳市万事富科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef id _Nonnull (^MapBlock)( id obj);
typedef BOOL (^FilterBlock)( id obj);
typedef double (^ReduceBlock)(double orignNum, id obj);

@interface NSMutableArray (ZLJSwiftExtension)

- (NSMutableArray *)zlj_map:(MapBlock)block;
- (NSMutableArray *)zlj_filter:(FilterBlock)filterBlock;
- (double )zlj_reduceWithOrignValue:(double)orignvalue reduceBlock:(ReduceBlock)reduceBlock ;

- (BOOL)zlj_aryOneFollowCondition:(FilterBlock)filterBlock;
- (BOOL)zlj_aryAllFollowCondition:(FilterBlock)filterBlock;

@end

NS_ASSUME_NONNULL_END
