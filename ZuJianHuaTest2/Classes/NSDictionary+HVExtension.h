//
//  NSDictionary+HVExtension.h
//  hvresource
//
//  Created by lq2 on 14/10/18.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//  类型安全的取值方式  防止null 时候 崩溃 及类型错误

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+HVExtension.h"

@interface NSDictionary (HVExtension)

//如果path对应的value为[NSNull null],时,将返回nil对象
- (id)zlj_objectAtPath:(NSString *)path;
- (id)zlj_objectAtPath:(NSString *)path otherwise:(NSObject *)other;

- (NSArray *)zlj_arrayAtPath:(NSString *)path;
- (NSArray *)zlj_arrayAtPath:(NSString *)path otherwise:(NSArray *)other;

- (NSDictionary *)zlj_dictionaryAtPath:(NSString *)path;
- (NSDictionary *)zlj_dictionaryAtPath:(NSString *)path otherwise:(NSDictionary *)other;

- (id)zlj_jsonValueAtPath:(NSString *)path;//限制在NSArray和NSDictionary之间
- (id)zlj_jsonValueAtPath:(NSString *)path otherwise:(id)other;

- (NSString *)zlj_stringAtPath:(NSString *)path;
- (NSString *)zlj_stringAtPath:(NSString *)path otherwise:(NSString *)other;

- (NSNumber *)zlj_numberAtPath:(NSString *)path;
- (NSNumber *)zlj_numberAtPath:(NSString *)path otherwise:(NSNumber *)other;

- (BOOL)zlj_boolAtPath:(NSString *)path;
- (BOOL)zlj_boolAtPath:(NSString *)path otherwise:(BOOL)other;

- (NSInteger)zlj_integerAtPath:(NSString *)path;
- (NSInteger)zlj_integerAtPath:(NSString *)path otherwise:(NSInteger)other;

- (CGFloat)zlj_floatAtPath:(NSString *)path;
- (CGFloat)zlj_floatAtPath:(NSString *)path otherwise:(CGFloat)other;

- (CGFloat)zlj_CGFloatAtPath:(NSString *)path;
- (CGFloat)zlj_CGFloatAtPath:(NSString *)path otherwise:(CGFloat)other;

- (double)zlj_doubleAtPath:(NSString *)path;
- (double)zlj_doubleAtPath:(NSString *)path otherwise:(CGFloat)other;

- (NSTimeInterval)zlj_NSTimeIntervalAtPath:(NSString *)path;
- (NSTimeInterval)zlj_NSTimeIntervalAtPath:(NSString *)path otherwise:(CGFloat)other;

/**
 *  遞歸方式返回可變的字典
 *
 *  @return NSMutableDictionary
 */
- (NSMutableDictionary *)mutableDictionary;

/**
 *  返回json格式的字符串
 *
 *  @return 字符串
 */
- (NSString *)jsonString;

/**
 *  返回json格式的二进制数据
 *
 *  @return NSData对象
 */
- (NSData *)jsonData;

/**
 *  返回json格式的字符串
 *
 *  @param compact 是否要压缩字符串,YES:将输出没有分行的字符串,NO:将输出分好行的字符串,便于阅读
 *
 *  @return 字符串
 */
- (NSString *)jsonStringWithCompacted:(BOOL)compact;

/**
 *  返回json格式的二进制数据
 *
 *  @param compact 是否输出紧凑的数据
 *
 *  @return NSData对象
 */
- (NSData *)jsonDataWithCompacted:(BOOL)compact;

+ (NSDictionary *)zlj_dictionaryWithJSON:(id)json;

@end
