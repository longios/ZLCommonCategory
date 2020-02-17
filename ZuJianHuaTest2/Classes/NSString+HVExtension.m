//
//  NSString+HVExtension.m
//  HVBasic
//
//  Created by lq2 on 14-9-11.
//  Copyright (c) 2014年 hv. All rights reserved.
//

#import "NSString+HVExtension.h"

@implementation NSString (HVExtension)
- (NSString *)base64EncodedString{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSString *s = data?[data base64EncodedStringWithOptions:0]:nil;
	return s;
}
- (NSString *)base64DecodedString{
	NSString *s = nil;
	NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
	if(data){
		s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	}
	return s;
}
- (NSString *)stringByAddingURLPercentEncoding{
	NSString *string = self;
	static NSString * const kHVCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
	static NSString * const kHVCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
	
	NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
	[allowedCharacterSet removeCharactersInString:[kHVCharactersGeneralDelimitersToEncode stringByAppendingString:kHVCharactersSubDelimitersToEncode]];
	
	// FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
	// return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
	
	static NSUInteger const batchSize = 50;
	
	NSUInteger index = 0;
	NSMutableString *escaped = @"".mutableCopy;
	
	while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
		NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
		NSRange range = NSMakeRange(index, length);
		
		// To avoid breaking up character sequences such as 👴🏻👮🏽
		range = [string rangeOfComposedCharacterSequencesForRange:range];
		
		NSString *substring = [string substringWithRange:range];
		NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
		[escaped appendString:encoded];
		
		index += range.length;
	}
	
	return escaped;
}
+ (NSString *)stringWithFileSize:(NSUInteger)fileSize{
	if(fileSize==0)return @"0";
	NSDictionary *map = @{
						  @"GB":@(1024*1024*1024),
						  @"MB":@(1024*1024),
						  @"KB":@(1024),
						  };
	NSArray<NSString *> *units = @[@"GB",@"MB",@"KB"];
	NSString *str = nil;
	for (NSString *unit in units) {
		NSUInteger n = [[map objectForKey:unit] integerValue];
		double v = fileSize*1.0/n;
		if(v>=1||n==1){
			str = [NSString stringWithFormat:@"%.1f%@",v,unit];
			break;
		}
	}
	if(!str){
		str = [NSString stringWithFormat:@"%@B",@(fileSize)];
	}
	return str;
}
+ (NSString *)stringWithObject16Address:(NSObject *)object{
	if(!object)return @"";
	NSString *str = [NSString stringWithFormat:@"0x%p",object];
	return str;
}
- (NSArray<NSValue *> *)rangesOfString:(NSString *)searchString{
	if(searchString.length==0)return nil;
	NSMutableArray<NSValue *> *ranges = [[NSMutableArray alloc] init];
	NSRange r = [self rangeOfString:searchString];
	if(r.location!=NSNotFound&&r.length!=0){
		[ranges addObject:[NSValue valueWithRange:r]];
		NSInteger maxR = NSMaxRange(r);
		NSString *leftString = [self substringFromIndex:maxR];
		if(leftString.length){
			NSArray<NSValue *> *subRanges = [leftString rangesOfString:searchString];
			if(subRanges.count){
				for (NSValue *v in subRanges) {
					NSRange range = [v rangeValue];
					range.location += maxR;
					[ranges addObject:[NSValue valueWithRange:range]];
				}
			}
		}
	}
	return ranges;
}
- (NSNumber *)numberValue{
	NSNumber *number;
	number = [self numberOfInteger];
	if(!number){
		number = [self numberOfLongLong];
	}
	if(!number){
		number = [self numberOfCGFloat];
	}
	return number;
}
- (NSNumber *)numberOfInteger{
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	NSInteger value;
	if([scanner scanInteger:&value]&&scanner.isAtEnd){
		return @(value);
	}
	return nil;
}
- (NSNumber *)numberOfLongLong{
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	long long value;
	if([scanner scanLongLong:&value]&&scanner.isAtEnd){
		return @(value);
	}
	return nil;
}
- (NSNumber *)numberOfCGFloat{
#if defined(__LP64__) && __LP64__
	return [self numberOfDouble];
#else
	return [self numberOfFloat];
#endif
}
- (NSNumber *)numberOfFloat{
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	float value;
	if([scanner scanFloat:&value]&&scanner.isAtEnd){
		return @(value);
	}
	return nil;
}
- (NSNumber *)numberOfDouble{
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	double value;
	if([scanner scanDouble:&value]&&scanner.isAtEnd){
		return @(value);
	}
	return nil;
}
- (void)enumerateSeparatedComponentsByRegularExpression:(NSRegularExpression *)reg usingBlock:(void(^)(NSTextCheckingResult *result,NSString *component,BOOL *stop))block{
	if(!block||!reg||self.length==0)return;
	BOOL stop = NO;
	NSString *string = self;
	NSArray<NSTextCheckingResult *> *results = [reg matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
	if(results.count==0){//没有匹配项
		block(nil,string,&stop);
		if(stop){
			return;
		}
	}else{
		for (int i=0; i<results.count; i++) {
			NSTextCheckingResult *result = results[i];
			NSRange range = result.range;
			if(i==0&&range.location!=0){//处理第一次匹配项之前的字符串
				NSString *component = [string substringToIndex:range.location];
				block(nil,component,&stop);
				if(stop){
					return;
				}
			}
			//当前匹配项
			block(result,nil,&stop);
			if(stop){
				return;
			}
			//获取匹配项后面的字符串
			NSInteger begin = NSMaxRange(range);
			NSInteger len = 0;
			//获取与下一个匹配项之间的字符串
			if(i!=results.count-1){
				NSTextCheckingResult *nextResult = results[i+1];
				NSRange nextRange = nextResult.range;
				len = nextRange.location-begin;
			}else{//获取与字符串尾部之间的子字符串
				len = string.length-begin;
			}
			if(len>0){
				NSRange betweenRange = NSMakeRange(begin, len);
				NSString *component = [string substringWithRange:betweenRange];
				block(nil,component,&stop);
				if(stop){
					return;
				}
			}
		}
	}
}
+ (NSString *)stringWithDeviceToken:(NSData *)data{
	NSString *deviceToken;
	if(data){
		deviceToken = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
		deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	return deviceToken;
}
//- (NSString *)md5{
//    [[self dataUsingEncoding:NSUTF8StringEncoding] ]
//    NSString *str = [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
//    return str;
//}
//- (NSString *)MD5{
//    NSString *str = [[self dataUsingEncoding:NSUTF8StringEncoding] MD5String];
//    return str;
//}
- (id)jsonValue{
    if(self.length==0)return nil;
    NSError *error = nil;
    id obj =[NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (obj==nil&&error!=nil) {
//        HVError(@"jsonValue:%@ error:%@",self,error);
    }
    return obj;
}
- (NSDictionary *)jsonDictionary{
    id obj = [self jsonValue];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }else{
        return nil;
    }
}
- (NSArray *)jsonArray{
    id obj = [self jsonValue];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }else{
        return nil;
    }
}
//+ (NSString *)chkWithDeviceCode:(NSString *)devCode andToken:(NSString *)token{
//    NSString *chk = [[[NSString stringWithFormat:@"%@HV,INC.%@",devCode,token] md5] substringWithRange:NSMakeRange(0, 6)];
//    return chk;
//}
//+ (NSString *)chkWithDeviceCode:(NSString *)devCode salt:(NSString *)salt op:(NSString *)op{
//    NSString *chk = [[[NSString stringWithFormat:@"%@%@%@",devCode,salt,op] md5] substringWithRange:NSMakeRange(0, 6)];
//    return chk;
//}
//+ (NSString *)chkWithOp:(NSString *)op andToken:(NSString *)token {
//    NSString *chk = [[[NSString stringWithFormat:@"%@HV,INC.%@",op,token] md5] substringWithRange:NSMakeRange(0, 6)];
//    return chk;
//}
//+ (NSString *)chkWithOp:(NSString *)op andSalt:(NSString *)salt{
//    NSString *chk = [[[NSString stringWithFormat:@"%@HV,INC.%@",op,salt] md5] substringWithRange:NSMakeRange(0, 6)];
//    return chk;
//}

- (NSString *)stringByReplacements:(id)replacements{
	NSString *result = self;
	if(replacements){
		if ([replacements isKindOfClass:[NSArray class]]) {
			NSArray *array = (NSArray *)replacements;
			NSInteger count = array.count;
			for (int i=0;i<count; i++) {
				NSString *str = [[array objectAtIndex:i] description];
				result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"$%d",i+1] withString:str];
			}
		}else if([replacements isKindOfClass:[NSDictionary class]]){
			NSDictionary *dict = (NSDictionary *)replacements;
			for (NSString *key in dict) {
				NSString *val = [[dict objectForKey:key] description];
				result = [result stringByReplacingOccurrencesOfString:key withString:val];
			}
		}else{
			NSString *val = [replacements description];
			result = [result stringByReplacingOccurrencesOfString:@"$1" withString:val];
		}

	}
	return result;
}

@end

