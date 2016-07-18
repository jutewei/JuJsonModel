//
//  SHFMDBSql+Select.h
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb.h"

@interface JUSQLdb (Select)
/**
 *  @author Juvid, 16-07-11 14:07:55
 *
 *  查询表所有数据
 *
 *  @param tableName 表名
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName;
/**
 *  @author Juvid, 16-07-11 14:07:21
 *
 *  查询表分页数据
 *
 *  @param tableName 表名
 *  @param pageIndex 第几页
 *  @param pageSize  页容量
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName PageIndex:(NSString *)pageIndex PageSize:(NSString *)pageSize;
/**
 *  @author Juvid, 16-07-11 14:07:08
 *
 *  查询指定字段数据
 *
 *  @param tableName 表名
 *  @param whereKey  指定值
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName  whereKey:(NSDictionary *)whereKey;
/**
 *  @author Juvid, 16-07-11 14:07:50
 *
 *  查询指定值分页
 *
 *  @param tableName 表名
 *  @param whereKey  指定值
 *  @param pageIndex 页索引
 *  @param pageSize  页容量
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName  whereKey:(NSDictionary *)whereKey PageIndex:(NSString *)pageIndex PageSize:(NSString *)pageSize;
/**
 *  @author Juvid, 16-07-11 14:07:35
 *
 *  查询数据按升序
 *
 *  @param tableName 表名
 *  @param ascArrKey 升序字段
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                             asc:(NSArray *)ascArrKey;
/**
 *  @author Juvid, 16-07-11 14:07:39
 *
 *  查询指定数据数据按升序与降序
 *
 *  @param tableName  表名
 *  @param whereKey   指定字段
 *  @param ascArrKey  升序数组
 *  @param desArrcKey 降序数组
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                        whereKey:(NSDictionary *)whereKey
                             asc:(NSArray *)ascArrKey
                            desc:(NSArray *)desArrcKey;
/**
 *  @author Juvid, 16-07-11 15:07:14
 *
 *  复杂查询
 *
 *  @param tableName  表名
 *  @param pindex     页索引
 *  @param psize      页容量
 *  @param desArrcKey 降序集
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                          pIndex:(NSString *)pindex
                           pSize:(NSString *)psize
                            desc:(NSArray *)desArrcKey;
/**
 *  @author Juvid, 16-07-11 14:07:26
 *
 *  复杂查询
 *
 *  @param tableName  表名
 *  @param whereKey   指定值
 *  @param pindex     页索引
 *  @param psize      页容量
 *  @param ascArrKey  升序值
 *  @param desArrcKey 降序值
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                        whereKey:(NSDictionary *)whereKey
                          pIndex:(NSString *)pindex
                           pSize:(NSString *)psize
                             asc:(NSArray *)ascArrKey
                            desc:(NSArray *)desArrcKey;
/**
 *  @author Juvid, 16-07-11 14:07:16
 *
 *  查询数据
 *
 *  @param tableName 表名
 *  @param strSql    SQL语句
 *
 *  @return 查询结果
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                         withSql:(NSString *)strSql;

@end
