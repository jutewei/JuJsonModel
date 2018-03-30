//
//  SHFMDBSql+Update.h
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb.h"

@interface JUSQLdb (Update)
/**
 *  @author Juvid, 16-07-11 12:07:27
 *
 *  更新表(推荐使用)
 *
 *  @param object      表对象
 *  @param setKeys     SET 的所有Key（数组或单个字符串Key）
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(JuBasicModels *)object setKeys:(id)setKeys;
/**
 *  @author Juvid, 16-07-22 13:07:41
 *
 *  更新表
 *
 *  @param tableName 表名
 *  @param dicObject 键值
 *  @param setKeys   SET 的所有Key（数组或单个字符串Key)
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)tableName withData:(NSDictionary *)dicObject setKeys:(id)setKeys;
//+(BOOL)UpdateTabData:(id)object PrimaryKey:(NSString *)primaryKey;//更新表

/**
 *  @author Juvid, 16-07-11 12:07:22
 *
 *  更新表(单个key value)
 *
 *  @param table    表名
 *  @param setkey   set的key
 *  @param setvalue set key 的值
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setValue;
/**
 *  @author Juvid, 16-07-11 12:07:20
 *
 *  更新表
 *
 *  @param table      表名（单个where、set（key value））
 *  @param setkey     set的key
 *  @param setvalue   set key 的值
 *  @param wherekey   where 的key
 *  @param whereValue where key 的值
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setvalue whereKey:(NSString*)wherekey whereValue:(NSString*)whereValue;

/**
 *  @author Juvid, 16-07-11 12:07:14
 *
 *  更新表（多个）
 *
 *  @param tableName 表名
 *  @param setSql    set SQL 键值 key='value'，……
 *  @param whereSql  where SQL 键值 key='value' AND……
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql where:(NSString *)whereSql;
/**
 *  @author Juvid, 16-07-11 12:07:16
 *
 *  更新表
 *
 *  @param tableName 表名
 *  @param setSql    set SQL 键值 key='value'，……
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql;


/**
 *  @author Juvid, 16-07-11 12:07:40
 *
 *  更新表
 *
 *  @param tableName 表名
 *  @param sqlStr    SQL语句
 *
 *  @return 返回操作状态
 */
+(BOOL)shUpdateTable:(NSString *)tableName withSql:(NSString *)sqlStr;

@end
