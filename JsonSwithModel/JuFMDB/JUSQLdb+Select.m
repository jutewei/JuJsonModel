//
//  SHFMDBSql+Select.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+Select.h"

@implementation JUSQLdb (Select)

//查询表
+(NSMutableArray *)shSelectTable:(NSString *)tableName{
    return [self shSelectTable:tableName whereKey:nil pIndex:nil pSize:nil asc:nil desc:nil];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName PageIndex:(NSString *)pageIndex PageSize:(NSString *)pageSize  {
    return [self shSelectTable:tableName whereKey:nil pIndex:pageIndex pSize:pageSize asc:nil desc:nil];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName  whereKey:(NSDictionary *)whereKey{
    return [self shSelectTable:tableName whereKey:whereKey pIndex:nil pSize:nil asc:nil desc:nil];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName  whereKey:(NSDictionary *)whereKey PageIndex:(NSString *)pageIndex PageSize:(NSString *)pageSize{
    return [self shSelectTable:tableName whereKey:whereKey pIndex:pageIndex pSize:pageSize asc:nil desc:nil];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                             asc:(NSArray *)ascArrKey{
   return  [self shSelectTable:tableName whereKey:nil pIndex:nil pSize:nil asc:ascArrKey desc:nil];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                        whereKey:(NSDictionary *)whereKey
                             asc:(NSArray *)ascArrKey
                            desc:(NSArray *)desArrcKey{
     return  [self shSelectTable:tableName whereKey:whereKey pIndex:nil pSize:nil asc:ascArrKey desc:desArrcKey];
}
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                          pIndex:(NSString *)pindex
                           pSize:(NSString *)psize
                            desc:(NSArray *)desArrcKey{
    return [self shSelectTable:tableName whereKey:nil pIndex:pindex pSize:psize asc:nil desc:desArrcKey];
}
/*
 *asc升序
 *desc降序
 */
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                        whereKey:(NSDictionary *)whereKey
                          pIndex:(NSString *)pindex
                           pSize:(NSString *)psize
                             asc:(NSArray *)ascArrKey
                            desc:(NSArray *)desArrcKey
{
    NSMutableString *sqlStr=[NSMutableString string];
    if (whereKey) {
        NSMutableArray *arrKey=[NSMutableArray array];
        for (NSString *strKey in [whereKey allKeys]) {
            [arrKey addObject:[NSString stringWithFormat:@" %@='%@'",strKey,whereKey[strKey]]];
        }
        [sqlStr appendFormat:@"WHERE %@",[arrKey componentsJoinedByString:@" AND "]];
    }
    if(ascArrKey||desArrcKey){
        [sqlStr appendString:@" ORDER BY "];
        if (ascArrKey) {///< 默认升序
            [sqlStr appendString:[ascArrKey componentsJoinedByString:@","]];
        }
        if(desArrcKey){///< 降序
            NSMutableArray *arrDesc=[NSMutableArray array];
            for (NSString *string in desArrcKey) {
                [arrDesc addObject:[NSString stringWithFormat:@"%@ DESC",string]];
            }
            [sqlStr appendString:[arrDesc componentsJoinedByString:@","]];
        }
    }
    if (pindex&&psize) {
        [sqlStr appendFormat:@" limit %@,%@",pindex,psize];
    }
    return [self shSelectTable:tableName selectKey:nil withSql:sqlStr];
}

+(NSMutableArray *)shSelectTable:(NSString *)tableName
                          selectKey:(NSArray *)selectArr
                         withSql:(NSString *)strSql{
    NSString *select=@"*";
    if (selectArr) {
        select =[selectArr componentsJoinedByString:@","];
    }
    return [self shSelectTable:tableName withSql:[NSString stringWithFormat:@"SELECT %@ FROM %@ %@",select,tableName,strSql]];
}

+(NSMutableArray *)shSelectTable:(NSString *)tableName
                         withSql:(NSString *)strSql{

    NSMutableArray *arrResult=[NSMutableArray array];
    FMDatabase *db=[JUSQLdb shCreatDB];
    if ([db open]) {
        FMResultSet *rs=[db executeQuery:strSql];
        while ([rs next]) {
            NSMutableDictionary *dicResult=[NSMutableDictionary dictionaryWithDictionary:[rs resultDictionary]];
            [arrResult addObject:dicResult];

        }
        [db close];
    }
    return arrResult;

}
@end
