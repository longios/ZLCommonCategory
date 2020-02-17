//
//  NSMutableArray+ZLJSwiftExtension.m
//  XiongMao
//
//  Created by lq2 on 2019/6/20.
//  Copyright © 2019 深圳市万事富科技有限公司. All rights reserved.
//

#import "NSMutableArray+ZLJSwiftExtension.h"

@implementation NSMutableArray (ZLJSwiftExtension)

- (NSMutableArray *)zlj_map:(MapBlock)block {
    NSMutableArray *mary = [NSMutableArray array];
    for(id obj in self) {
        if(block) {
            id afterObj = block(obj);
            if(afterObj) {
                [mary addObject:afterObj];
            }
        }else {
            [mary addObject:obj];
        }
    }
    return mary;
}


- (NSMutableArray *)zlj_filter:(FilterBlock)filterBlock {
    NSMutableArray *mary = [NSMutableArray array];
    for(id obj in self) {
        if(filterBlock) {
            if(filterBlock(obj)) {
                [mary addObject:obj];
            }
        }
    }
    return mary;
}

- (double )zlj_reduceWithOrignValue:(double)orignvalue reduceBlock:(ReduceBlock)reduceBlock {
    double value = orignvalue;
    for(id obj in self) {
        if(reduceBlock) {
            double reduceValue = reduceBlock(value, obj);
            value = reduceValue;
        }
    }
    return value;
}

- (BOOL)zlj_aryOneFollowCondition:(FilterBlock)filterBlock {
    for(id obj in self) {
        if(filterBlock && filterBlock(obj)) {
            return YES;
            break;
        }
    }
    return NO;
}

- (BOOL)zlj_aryAllFollowCondition:(FilterBlock)filterBlock {
    for(id obj in self) {
        if(filterBlock && !filterBlock(obj)) {
            return NO;
        }
    }
    return YES;
}

@end
