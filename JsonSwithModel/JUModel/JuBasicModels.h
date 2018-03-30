//
//  BaseModel.h
//  JsonModel
//
//  Created by Juvid on 14-6-30.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "JuBasicEncode.h"
#import "NSArray+Safe.h"
#define Pro_Prefix @"sh_"
@interface JuBasicModels : JuBasicEncode
/**
 *  @author Juvid, 15-09-11 11:09:42
 *
 *  初始化model对象
 *
 *  @return 返回对象
 */
+(id)juInitModel;
/**
 *  @author Juvid, 15-07-15 10:07:47
 *
 *  得到所有属性
 *
 *  @return 属性数组
 */
+(NSArray *)getModelAllProperty;
/**
 *  @author Juvid, 15-07-15 10:07:29
 *
 *  网络获取数据转对象
 *
 *  @param dic 网络返回的字典
 *
 *  @return 返回转换好的对象
 */
+(id) setDictionaryForModel :(NSDictionary *) dic ;
-(id) setDictionaryForModel :(NSDictionary *) dic;
//字典转换成对象
+(id) setDictionaryForModel :(NSDictionary *) dic withObject:(id)baseModel;
/**
 *  @author Juvid, 15-07-15 10:07:34
 *
 *  网络获取数据转对象数组
 *
 *  @param arr 网络返回的数组包含相同的字典
 *
 *  @return 返回转换好的数组，数组里为对象
 */
+(NSArray *) setArrayForModel :(NSArray *) arr ;
/**
 *  @author Juvid, 15-07-15 10:07:34
 *
 *  网络获取数据数组转换
 *
 *  @param arr 网络返回的数组包含相同的字典
 *
 *  @return 返回转换好的数组，数组里为数组
 */
+(NSArray *) setArray :(NSArray *) arr ;
/**
 *  @author Juvid, 15-07-15 10:07:42
 *
 *  对象转化成字符串key=value中间逗号分隔形式
 *
 *  @param baseModel 要转换的对象
 *
 *  @return 返回对象字符串
 */
+(NSString *) setModelForString :(id ) baseModel;
//对象转换成字典
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象转换成字典包括父对象
 *
 *  @param baseModel 转换的对象
 *
 *  @return 返回字典
 */
+(NSMutableDictionary *) setModelForDictionary :(id) baseModel;
//对象数组转换成数字
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象数组转换成字符数组
 *
 *  @param baseModel 转换的对象
 *
 *  @return 返回字典
 */
+(NSArray *) setModelForArray :(NSArray *) arr;
/**
 *  @author Juvid, 15-07-15 10:07:20
 *
 *  <#Description#>
 *
 *  @param key   <#str description#>
 *  @param value <#value description#>
 */
-(void)setModelProValue:(NSString *)key value:(NSString *)value;

-(NSString *)getVauleForkey:(NSString *)key;
@end
