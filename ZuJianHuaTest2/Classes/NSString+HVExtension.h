//
//  NSString+HVExtension.h
//  HVBasic
//
//  Created by lq2 on 14-9-11.
//  Copyright (c) 2014年 hv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HVExtension)
//@property (nonatomic, readonly) NSString *md5;//返回小寫的md5值
//@property (nonatomic, readonly) NSString *MD5;//返回大写的md5值
/**
 *  对json格式的字符串进行处理,返回其对应的NSDictionary或者NSArray等对象
 *
 *  @return json對象
 */
- (id)jsonValue;

/**
 *  string為NSDictionary的json格式
 *
 *  @return json對應的NSDictionary
 */
- (NSDictionary *)jsonDictionary;

/**
 *  string為NSArray的json格式
 *
 *  @return json對應的NSArray
 */
- (NSArray *)jsonArray;

/**
 *  對字符串進行佔位符替換
 *
 *  @param replacements 佔位符替換,可為多種形式:
 array=>對結果中的$1,$2,...進行順序替換
 dictionary=>按dictionary中的key,value對進行替換
 string,number=>對$1進行替換
 *
 *  @return 替換後的字符器
 */
- (NSString *)stringByReplacements:(id)replacements;

typedef NSString *(^HVStringAppendBlock)( id format, ... );
//@property(nonatomic, readonly) HVStringAppendBlock APPEND;//往字符串后面添加内容

//@property(nonatomic,readonly) NSString *firstLetterOfPinyin;//返回汉字拼音的第一個字符,空字符串時返回@"".如果是英文,返回英文第一个字母

/**
 *  返回注册推播后返回的设备号.会去掉尖括号和空格
 *
 *  @param data 设备号二进制数据
 *
 *  @return 设备号字符串
 */
+ (NSString *)stringWithDeviceToken:(NSData *)data;

/**
 *  使用正则表达式,对字符串进行分隔.分隔中,使用block进行子字符串的遍历.例如字符串如下:
	最早提出"自我效能干"这一概念的美国心理学家是$({"type":"TextField","length":8,"correctAnswer":"哈根达斯"})  .
	正则为:\$\((.*)\)
	则字符串会被分隔成以下三段:
 1.	最早提出"自我效能干"这一概念的美国心理学家是
 2.	$({"type":"TextField","length":8,"correctAnswer":"哈根达斯"})
 3.	  .
	然后会对这三段分别使用block进行遍历.
	block的参数说明:
	result:符合正则的匹配结果,如上例中的第2段
	component:result之间的字符串,如上例中的第1,3段
	stop:是否中止操作
 *
 *  @param reg   正则表达式
 *  @param block 遍历的block
 */
- (void)enumerateSeparatedComponentsByRegularExpression:(NSRegularExpression *)reg usingBlock:(void(^)(NSTextCheckingResult *result,NSString *component,BOOL *stop))block;

/**
 *  如果字符串内容为数字时,返回数字对应的NSNumber对象
 *
 *  @return 数字对象
 */
- (NSNumber *)numberValue;
- (NSNumber *)numberOfInteger;
- (NSNumber *)numberOfLongLong;
- (NSNumber *)numberOfCGFloat;
- (NSNumber *)numberOfFloat;
- (NSNumber *)numberOfDouble;

/**
 *  搜索指定字符串的所有位置
 *
 *  @param searchString 指定的字符串
 *
 *  @return NSRange包装类的列表
 */
- (NSArray<NSValue *> *)rangesOfString:(NSString *)searchString;

/**
 *  输出对象的内存地址,如0xff1100aa
 *
 *  @param object 对象
 *
 *  @return 内存地址
 */
+ (NSString *)stringWithObject16Address:(NSObject *)object;

/**
 *  返回文件大小的字符串，如89KB，1.0MB，1.9GB
 *
 *  @param fileSize 字节数
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)stringWithFileSize:(NSUInteger)fileSize;

@property(nonatomic,readonly) NSString *stringByAddingURLPercentEncoding;//对 url 进行转义
@property(nonatomic,readonly) NSString *base64EncodedString;//进行 base64编码后的字符串
@property(nonatomic,readonly) NSString *base64DecodedString;//进行 base64解码后的字符串
@end

@interface NSString (HV_NSURL)
/**
 *  如果self为本地文件的绝对路径,或者bundle://$(bundleName).bundle/xxx/xxx.png格式的字符串,则会返回本地文件对应的NSURL
 *
 *  @return 本地文件对应的NSURL对象
 */
- (NSURL *)filePathURL;

/**
 *  如果self以http开头,则返回http对应的NSURL对象
 *
 *  @return url对象
 */
- (NSURL *)httpURL;
@end

@interface NSString (HVHexDataExtension)

/**
 *  将形如@"af100b00"的字符串,转换成16进制表示的数字序列:0xaf100b00
 *	要求self.length为2的整数倍
 *  @return 二进制对象
 */
- (NSData *)hexData;
@end

