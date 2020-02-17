//
//  NSArray+SwiftExtension.h
//  ZLTools
//
//  Created by Abe on 2018/4/3.
//  Copyright © 2018年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^MapBlock)( id obj);
typedef BOOL (^FilterBlock)( id obj);
typedef double (^ReduceBlock)(double orignNum, id obj);

@interface NSArray (SwiftExtension)

- (NSArray *)zlj_map:(MapBlock)block;
- (NSArray *)zlj_filter:(FilterBlock)filterBlock;
- (double )zlj_reduceWithOrignValue:(double)orignvalue reduceBlock:(ReduceBlock)reduceBlock ;

- (BOOL)zlj_aryOneFollowCondition:(FilterBlock)filterBlock;
- (BOOL)zlj_aryAllFollowCondition:(FilterBlock)filterBlock;
@end
