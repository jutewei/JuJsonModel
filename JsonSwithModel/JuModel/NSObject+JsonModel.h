//
//  NSObject+JsonModel.h
//  MTSkinPublic
//
//  Created by Juvid on 2018/11/28.
//  Copyright © 2018年 Juvid. All rights reserved.
//
/**未使用**/
#import <Foundation/Foundation.h>
#define JU_Model_Prefix @"sh_"
//NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JsonModel)
-(void)juSetModelExtension;
/**
 *  @author Juvid, 15-09-11 11:09:42
 *
 *  初始化model对象
 *
 *  @return 返回对象
 */
+(id)mtInitM;
/**
 *  @author Juvid, 15-07-15 10:07:47
 *
 *  得到所有属性
 *
 *  @return 属性数组
 */
+(NSArray *)juGetModelAllProperty;
/**
 *  @author Juvid, 15-07-15 10:07:29
 *
 *  网络获取数据转对象
 *
 *  @param dic 网络返回的字典
 *
 *  @return 返回转换好的对象
 */
+(id) juSetDictionaryForModel :(NSDictionary *) dic ;
-(id) juSetDictionaryForModel :(NSDictionary *) dic;
//字典转换成对象
+(id) juSetDictionaryForModel :(NSDictionary *) dic withObject:(id)baseModel;
/**
 *  @author Juvid, 15-07-15 10:07:34
 *
 *  网络获取数据转对象数组
 *
 *  @param arr 网络返回的数组包含相同的字典
 *
 *  @return 返回转换好的数组，数组里为对象
 */
+(NSArray *) juSetArrayForModel :(NSArray *) arr ;

/**
 *  @author Juvid, 15-07-15 10:07:42
 *
 *  对象转化成字符串key=value中间逗号分隔形式
 *
 *  @param baseModel 要转换的对象
 *
 *  @return 返回对象字符串
 */
+(NSString *) juSetModelForString :(id ) baseModel;
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
+(NSMutableDictionary *) juSetModelForDictionary :(id) baseModel;
//对象数组转换成数字
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象数组转换成字符数组
 *
 *  @param arr 转换的对象数组
 *
 *  @return 返回字典
 */
+(NSArray *) juSetModelForArray :(NSArray *) arr;
/**
 *  @author Juvid, 15-07-15 10:07:20
 *
 *  设置对象属性值
 *
 *  @param key   键
 *  @param value 值
 */
-(void)juSetModelProValue:(NSString *)key value:(NSString *)value;

//-(NSString *)mtGetVauleForkey:(NSString *)key;
@end

//NS_ASSUME_NONNULL_END
