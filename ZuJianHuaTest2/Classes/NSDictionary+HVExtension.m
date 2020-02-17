//
//  NSDictionary+HVExtension.m
//  hvresource
//
//  Created by lq2 on 14/10/18.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "NSDictionary+HVExtension.h"

@implementation NSDictionary (HVExtension)

- (id)zlj_objectAtPath:(NSString *)path{
	id obj = [self valueForKeyPath:path];
	if(obj==[NSNull null]){
		obj = nil;
	}
	return obj;
}

- (id)zlj_objectAtPath:(NSString *)path otherwise:(NSObject *)other{
	id obj = [self zlj_objectAtPath:path];
	if(!obj){
		obj = other;
	}
	return obj;
}

- (NSArray *)zlj_arrayAtPath:(NSString *)path{
	NSObject *obj = [self zlj_objectAtPath:path];
	NSArray *arr;
	if ([obj isKindOfClass:[NSArray class]]) {
		arr = (NSArray *)obj;
	}else if([obj isKindOfClass:[NSString class]]){
		arr = [(NSString *)obj jsonArray];
	}else{
	}
	return arr;
}

- (NSArray *)zlj_arrayAtPath:(NSString *)path otherwise:(NSArray *)other{
	NSArray *arr = [self zlj_arrayAtPath:path];
	if (!arr) {
		arr = other;
	}
	return arr;
}

- (NSDictionary *)zlj_dictionaryAtPath:(NSString *)path{
	NSObject *obj = [self zlj_objectAtPath:path];
	NSDictionary *dict;
	if ([obj isKindOfClass:[NSDictionary class]]) {
		dict = (NSDictionary *)obj;
	}else if([obj isKindOfClass:[NSString class]]){
		dict = [(NSString *)obj jsonDictionary];
	}else{
	}
	return dict;
}

- (NSDictionary *)zlj_dictionaryAtPath:(NSString *)path otherwise:(NSDictionary *)other{
	NSDictionary *dict = [self zlj_dictionaryAtPath:path];
	if (!dict) {
		dict = other;
	}
	return dict;
}

- (id)zlj_jsonValueAtPath:(NSString *)path{
	id obj = [self zlj_objectAtPath:path];
	if ([obj isKindOfClass:[NSDictionary class]]||[obj isKindOfClass:[NSArray class]]) {
	}else if([obj isKindOfClass:[NSString class]]){
		obj = [(NSString *)obj jsonValue];
	}else{
		obj = nil;
	}
	return obj;
}

- (id)zlj_jsonValueAtPath:(NSString *)path otherwise:(id)other{
	id object = [self zlj_jsonValueAtPath:path];
	if (!object) {
		object = other;
	}
	return object;
}

- (NSString *)zlj_stringAtPath:(NSString *)path{
	NSString *str = [[self zlj_objectAtPath:path] description];
	return str;
}

- (NSString *)zlj_stringAtPath:(NSString *)path otherwise:(NSString *)other{
	NSString *str = [self zlj_stringAtPath:path];
	if(!str){
		str = other;
	}
	return str;
}

- (NSNumber *)zlj_numberAtPath:(NSString *)path{
	id obj = [self zlj_objectAtPath:path];
	NSNumber *num;
	if([obj isKindOfClass:[NSNumber class]]){
		num = obj;
	}else if([obj isKindOfClass:[NSString class]]){
		num = [obj numberValue];
	}
	return num;
}

- (NSNumber *)zlj_numberAtPath:(NSString *)path otherwise:(NSNumber *)other{
	NSNumber *num = [self zlj_objectAtPath:path otherwise:other];
	return num;
}

- (BOOL)zlj_boolAtPath:(NSString *)path{
	NSNumber *num = [self zlj_numberAtPath:path];
	BOOL b = [num boolValue];
	return b;
}

- (BOOL)zlj_boolAtPath:(NSString *)path otherwise:(BOOL)other{
	NSNumber *num = [self zlj_numberAtPath:path];
	BOOL b = num!=nil?[num boolValue]:other;
	return b;
}

- (NSInteger)zlj_integerAtPath:(NSString *)path{
	NSNumber *number = [self zlj_numberAtPath:path];
	return [number integerValue];
}

- (NSInteger)zlj_integerAtPath:(NSString *)path otherwise:(NSInteger)other{
	NSNumber * obj = [self zlj_numberAtPath:path];
	return obj!=nil?[obj integerValue]:other;
}

- (CGFloat)zlj_floatAtPath:(NSString *)path{
	NSNumber *number = [self zlj_numberAtPath:path];
	return [number floatValue];
}

- (CGFloat)zlj_floatAtPath:(NSString *)path otherwise:(CGFloat)other{
	NSNumber * obj = [self zlj_numberAtPath:path];
	return obj!=nil?[obj floatValue]:other;
}

- (CGFloat)zlj_CGFloatAtPath:(NSString *)path{
	NSNumber *number = [self zlj_numberAtPath:path];
	return [number doubleValue];
#if defined(__LP64__) && __LP64__
	return [number doubleValue];
#else
	return [number floatValue];
#endif
}

- (CGFloat)zlj_CGFloatAtPath:(NSString *)path otherwise:(CGFloat)other{
	NSNumber * obj = [self zlj_numberAtPath:path];
#if defined(__LP64__) && __LP64__
	return obj!=nil?[obj doubleValue]:other;
#else
	return obj!=nil?[obj floatValue]:other;
#endif
}

- (double)zlj_doubleAtPath:(NSString *)path{
	NSNumber *number = [self zlj_numberAtPath:path];
	return [number doubleValue];
}

- (double)zlj_doubleAtPath:(NSString *)path otherwise:(CGFloat)other{
	NSNumber * obj = [self zlj_numberAtPath:path];
	return obj!=nil?[obj doubleValue]:other;
}

- (NSTimeInterval)zlj_NSTimeIntervalAtPath:(NSString *)path{
	return [self zlj_doubleAtPath:path];
}

- (NSTimeInterval)zlj_NSTimeIntervalAtPath:(NSString *)path otherwise:(CGFloat)other{
	return [self zlj_doubleAtPath:path otherwise:other];
}

- (NSMutableDictionary *)mutableDictionary{
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:self.count];
	for (id key in self) {
		id value = [self objectForKey:key];
		if([value isKindOfClass:[NSDictionary class]]){
			value = [(NSDictionary *)value mutableDictionary];
		}
		[dict setObject:value forKey:key];
	}
	return dict;
}

- (NSString *)jsonString{
	NSString *jsonString = [self jsonStringWithCompacted:NO];
	return jsonString;
}

- (NSData *)jsonData{
	NSData *stringData = [self jsonDataWithCompacted:NO];
	return stringData;
}

- (NSString *)jsonStringWithCompacted:(BOOL)compact{
	NSString *jsonString;
	NSData *stringData = [self jsonDataWithCompacted:compact];
	if(stringData){
		jsonString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
	}
	return jsonString;
}

- (NSData *)jsonDataWithCompacted:(BOOL)compact{
	NSError *error;
	NSData *stringData = [NSJSONSerialization dataWithJSONObject:self options:compact?0:NSJSONWritingPrettyPrinted error:&error];
	return stringData;
}

+ (NSDictionary *)zlj_dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

@end
