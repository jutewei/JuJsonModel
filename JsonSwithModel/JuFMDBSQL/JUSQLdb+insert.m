//
//  SHFMDBSql+insert.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+insert.h"

@implementation JUSQLdb (insert)
//插入表数据
/**批量插入数据使用事物*/

//插入表数据(单条)
+(BOOL)shInsertTable:(JUBasicModels *)object primary:(NSString *)priKey{
    NSString *tableName=NSStringFromClass([object class]);
    return [self shInsertTable:tableName withData:object primary:priKey];
}
/**插入多条或者单条数据*/
+(BOOL)shInsertTable:(NSString *)tableName withData:(id)object primary:(NSString *)priKey{
    NSArray *allKeys=[[self shObjectForDic:object] allKeys];///< 获取建表所有key
    if ([self shCreateTable:tableName withKeys:allKeys  primaryKey:priKey]) {///< 建表成功后写数据
        if ([object isKindOfClass:[NSDictionary class]]) {
            return [self shInsertTable:tableName withSql:[self shObjectForSQL:object]];
        }else if([object isKindOfClass:[NSArray class]]){
            NSMutableArray *arrSql=[NSMutableArray array];
            for (id dicData in object) {
                [arrSql addObject:[JUPublicSQL shInsertSql:tableName withSql:[self shObjectForSQL:dicData]]];
            }
            return [self shUpdateMulitSQL:arrSql transaction:YES];
        }
    }
    return NO;
}
/*
+(BOOL)shInsertTable:(NSString *)tableName setKey:(NSString *)setKey setValue:(NSString *)setValue{
    return [self shInsertTable:tableName withSql:[NSString stringWithFormat:@" (%@) VALUES (%@)",setKey,setValue]];
}*/
/**多条数据**/
+(BOOL)shUpdateMulitSQL:(NSArray *)allSQL transaction:(BOOL)isTrans{
    FMDatabase *db=[JUSQLdb shCreatDB];
    [db open];
    BOOL isRollBack = NO;
    if (isTrans) {
        [db beginTransaction];
        @try {
            for (NSString *string in allSQL) {
                [db executeUpdate:string];
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack)[db commit];
        }
    }
    else{
        for (NSString *string in allSQL) {
            if (![db executeUpdate:string]) isRollBack = YES;
        }
    }
    if (!isRollBack) {
        NSLog(@"批量添加数据成功%@",allSQL);
    }else{
        NSLog(@"批量添加数据失败%@",allSQL);
    }
    [db close];
    return !isRollBack;
}
/**单条数据*/
+(BOOL)shInsertTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    BOOL flag = NO;
    FMDatabase *db=[JUSQLdb shCreatDB];
    NSString * sql=[JUPublicSQL shInsertSql:tableName withSql:sqlStr];
    if (![db open]) return NO;
    if ([db executeUpdate:sql]) {
        NSLog(@"添加数据成功成功%@",sql);
        flag = YES;
    }else{
        NSLog(@"添加数据失败%@",sql);
        flag = NO;
    }
    [db close];
    return flag;
}
+(NSDictionary *)shObjectForDic:(id)object{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }else if([object isKindOfClass:[NSArray class]]&&[object count]>0){
        return [self shObjectForDic:object[0]];
    }else if([object isKindOfClass:[JUBasicModels class]]){
        return [[object class] setModelForDictionary:object];
    }
    return @{};
}
/**拼接插入语句*/
+(NSString *)shObjectForSQL:(id)object{
    NSDictionary *dicObject=[self shObjectForDic:object];
    NSMutableArray * keyArr = [NSMutableArray array];
    NSMutableArray * valueArr = [NSMutableArray array];
    for (NSString *strKey in [dicObject allKeys]) {
        [keyArr addObject:strKey];
        [valueArr addObject:[NSString stringWithFormat:@"'%@'",dicObject[strKey]]];
    }
    return  [NSString stringWithFormat:@" (%@) VALUES (%@)",[keyArr componentsJoinedByString:@","] ,[valueArr componentsJoinedByString:@","]];
}

/*
+(BOOL)shInsertMultTable:(id)objects primary:(NSString *)priKey{
    FMDatabase *db=[PFBSQLdb shCreatDB];
    [db open];
    BOOL isRollBack = NO;
    [db beginTransaction];
    @try {
        for (id dbTable in objects) {
            NSString *tableName=NSStringFromClass([dbTable class]);
            NSDictionary *dicKeyVaule=[[dbTable class] setModelForDictionary:dbTable];
            if ([self shCreateTable:tableName withKeys:[dicKeyVaule allKeys]  primaryKey:priKey]) {
                NSMutableArray * keyArr = [NSMutableArray array];
                NSMutableArray * valueArr = [NSMutableArray array];
                for (NSString *strKey in [dicKeyVaule allKeys]) {
                    [keyArr addObject:strKey];
                    [valueArr addObject:[NSString stringWithFormat:@"'%@'",dicKeyVaule[strKey]]];
                }
                NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@",tableName]];
                [sql appendString:[NSString stringWithFormat:@" (%@) VALUES (%@)",[keyArr componentsJoinedByString:@","],[valueArr componentsJoinedByString:@","]]];
                BOOL a = [db executeUpdate:sql];
                if (!a) {
                    NSLog(@"插入失败1");
                }
            }
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [db rollback];
    } @finally {
        if (!isRollBack) {
            [db commit];
        }
    }
    [db close];
    return !isRollBack;
}*/
@end
