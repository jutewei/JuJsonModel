//
//  SHFMDBSql+Update.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+Update.h"

@implementation JUSQLdb (Update)
+(BOOL)shUpdateTable:(id)object setKeys:(id)setKeys{
    NSString *className=NSStringFromClass([object class]);

    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    if ([setKeys isKindOfClass:[NSString class]]) {
        setKeys=@[setKeys];
    }
    NSMutableArray * setArr = [NSMutableArray array];
    NSMutableArray *whereArr = [NSMutableArray array];

    for (NSString *strKey in [dicKeyVaule allKeys]) {
        if ([setKeys containsObject:strKey]) {
            [whereArr addObject:[NSString stringWithFormat:@" %@='%@' ",strKey,dicKeyVaule[strKey]]];
        }else{
            if (dicKeyVaule[strKey]&&![dicKeyVaule[strKey] isEqual:@""]) {
                [setArr addObject:[NSString stringWithFormat:@" %@='%@' ",strKey,dicKeyVaule[strKey]]];
            }
        }
    }

    return [self shUpdateTable:className set:[setArr componentsJoinedByString:@","] where:[whereArr componentsJoinedByString:@"AND"]];

}
//更新表数据
/*
+(BOOL)UpdateTabData:(id)object PrimaryKey:(NSString *)primaryKey{

    BOOL flag = YES;
    NSString *className=NSStringFromClass([object class]);
    FMDatabase *db=[self CreatDB:className];

    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    if ([db open]) {
        NSMutableString * string_key = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE  %@  SET ",className]];
        NSString *insersql_where;
        for (NSString *strKey in [dicKeyVaule allKeys]) {
            if (dicKeyVaule[strKey]&&![dicKeyVaule[strKey] isEqual:@""]) {
                if ([strKey isEqualToString:primaryKey]) {
                    insersql_where=[NSString stringWithFormat:@"where %@= '%@'",primaryKey,dicKeyVaule[strKey]];
                }
                else{
                    [string_key appendFormat:@"'%@'='%@',",strKey,dicKeyVaule[strKey]];
                }
            }

        }
        NSString * string_value = [NSString stringWithFormat:@"%@",[string_key substringToIndex:string_key.length - 1]];
        if ([db executeUpdate:[NSString stringWithFormat:@"%@%@",string_value,insersql_where]]) {
            NSLog(@"更新表数据成功成功%@",className);
            flag = YES;
        }else{
            NSLog(@"更新表数据失败%@",className);
            flag = NO;
        }

    }
    return flag;
}*/

+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setvalue{
    return [self shUpdateTable:table set:[NSString stringWithFormat:@" %@='%@' ",setkey,setvalue]];
}

+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setvalue whereKey:(NSString*)wherekey whereValue:(NSString*)whereValue{
    return [self shUpdateTable:table set:[NSString stringWithFormat:@" %@='%@' ",setkey,setvalue] where:[NSString stringWithFormat:@" %@='%@' ",wherekey,whereValue]];
}

+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql{
    return [self shUpdateTable:tableName set:setSql where:nil];
}
+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql where:(NSString *)whereSql{
    NSMutableString * sqlStr= [NSMutableString string];
    if (setSql) {
        [sqlStr appendString:setSql];
    }
    if (whereSql) {
        [sqlStr appendString:@" WHERE "];
        [sqlStr appendString:whereSql];
    }
   return [self shUpdateTable:tableName withSql:sqlStr];
}
+(BOOL)shUpdateTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    BOOL flag = NO;
    FMDatabase *db=[JUSQLdb CreatDB:tableName];
    NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE  %@  SET ",tableName]];
    [sql appendString:sqlStr];
    if (![db open]) return NO;
    //返回数据库中第一条满足条件的结果
    //    FMResultSet *rs=[db executeQuery:sqlStr];
    if ([db executeUpdate:sql]) {
        NSLog(@"更新表数据成功成功%@",sql);
        flag = YES;
    }else{
        NSLog(@"更新表数据失败%@",sql);
        flag = NO;
    }
    [db close];
    return flag;
}
@end
