//
//  SHFMDBSql+insert.h
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "PFBSQLdb.h"

@interface PFBSQLdb (insert)
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
+(BOOL)shInsertTable:(id)object primary:(NSString *)priKey;
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
//+(BOOL)shInsertTable:(NSString *)tableName withSql:(NSString *)sqlStr;
@end
