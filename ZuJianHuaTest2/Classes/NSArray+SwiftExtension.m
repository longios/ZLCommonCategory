//
//  NSArray+SwiftExtension.m
//  ZLTools
//
//  Created by Abe on 2018/4/3.
//  Copyright © 2018年 heimavista. All rights reserved.
//

// 模範 swift中的高阶函数 filter  reduce  map

#import "NSArray+SwiftExtension.h"

@implementation NSArray (SwiftExtension)

- (NSArray *)zlj_map:(MapBlock)block {
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
    return [mary copy];
}


- (NSArray *)zlj_filter:(FilterBlock)filterBlock {
    NSMutableArray *mary = [NSMutableArray array];
    for(id obj in self) {
        if(filterBlock) {
            if(filterBlock(obj)) {
                [mary addObject:obj];
            }
        }
    }
    return [mary copy];
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
