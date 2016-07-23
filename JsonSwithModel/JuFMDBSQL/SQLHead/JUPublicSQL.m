//
//  PFBPublicSQL.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/23.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUPublicSQL.h"

@implementation JUPublicSQL
+(NSString *)shCreateTableSQL:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey{
    NSMutableArray *creatArr=[NSMutableArray array];
    for (NSString *strKey in arrKey) {
        if (primaryKey&&[strKey isEqualToString:primaryKey]) {
            [creatArr addObject:[NSString stringWithFormat:@"%@ text PRIMARY KEY",strKey]];
        }
        else{
            [creatArr addObject:[NSString stringWithFormat:@"%@ text",strKey]];
        }
    }
    NSMutableString * creatSql =[NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ",className];
    [creatSql appendFormat:@"(%@)",[creatArr componentsJoinedByString:@","]];
    return creatSql;
}
+(NSString *)shInsertSql:(NSString *)tableName withSql:(NSString *)sqlStr{
    NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@",tableName]];
    [sql appendString:sqlStr];
    return sql;
}

+(NSString *)shDeleteSql:(NSString *)tableName withSql:(NSString *)sqlStr{

    NSMutableString * sql= [NSMutableString stringWithString:[NSString stringWithFormat:@"DELETE %@ FROM %@ WHERE ",sqlStr?@"":@"*",tableName]];
    if (sqlStr) {
        [sql appendString:sqlStr];
    }
    return sql;
}

+(NSString *)shUpdateSql:(NSString *)tableName withSql:(NSString *)sqlStr{
    NSMutableString * sql=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE  %@  SET ",tableName]];
    [sql appendString:sqlStr];
    return sql;
}
@end
