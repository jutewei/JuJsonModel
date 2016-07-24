//
//  SHFMDBSql+insert.h
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb.h"

@interface JUSQLdb (insert)
//插入表数据
//+(BOOL)insertTabData:(id)data PrimaryKey:(NSString *)primaryKey;

/**
 *  @author Juvid, 16-07-11 13:07:44
 *
 *  插入数据（包括建表）
 *
 *  @param objects    表对象
 *  @param primaryKey 主键
 *
 *  @return 操作状态
 */
+(BOOL)shInsertTable:(JUBasicModels *)object primary:(NSString *)priKey;
/**
 *  @author Juvid, 16-07-22 13:07:57
 *
 *   插入数据（包括建表）
 *
 *  @param tableName 表名
 *  @param object    字典，数组
 *  @param priKey    主键（不设置传nil）
 *
 *  @return 操作状态
 */
+(BOOL)shInsertTable:(NSString *)tableName withData:(id)object primary:(NSString *)priKey;
/**
 *  @author Juvid, 16-07-23 11:07:22
 *
 *  多条数据更新操作（事物）
 *
 *  @param tableName 表名
 *  @param arrStr    SQL更新语句组
 *
 *  @return <#return value description#>
 */
+(BOOL)shUpdateMulitSQL:(NSArray *)allSQL transaction:(BOOL)isTrans;
///**
// *  @author Juvid, 16-07-11 13:07:42
// *
// *  插入数据
// *
// *  @param tableName 表名
// *  @param setKey    键
// *  @param setValue  值
// *
// *  @return 操作状态
// */
//+(BOOL)shInsertTable:(NSString *)tableName setKey:(NSString *)setKey setValue:(NSString *)setValue;
///**
// *  @author Juvid, 16-07-11 13:07:46
// *
// *  插入数据
// *
// *  @param tableName 表名
// *  @param sqlStr    sql语句
// *
// *  @return 操作状态
// */
///**SQL拼接不执行任何数据库操作提供子类调用*/
//+(NSString *)shSqlString:(NSString *)tableName withSql:(NSString *)sqlStr;
@end
