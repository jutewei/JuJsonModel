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
+(BOOL)shInsertMultTable:(id)objects primary:(NSString *)priKey{
    FMDatabase *db=[JUSQLdb CreatDB];
    [db open];
    BOOL isRollBack = NO;
    [db beginTransaction];
    @try {
        for (id dbTable in objects) {
            NSString *tableName=NSStringFromClass([dbTable class]);
            NSDictionary *dicKeyVaule=[[dbTable class] setModelForDictionary:dbTable];
            if ([self createTable:tableName withKeys:[dicKeyVaule allKeys]  primaryKey:priKey]) {
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
}
+(NSString *)shSpliceSql:(NSString *)tableName withSql:(NSString *)sqlStr{
    NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@",tableName]];
    [sql appendString:sqlStr];
    return sql;
}
//插入表数据
+(BOOL)shInsertTable:(id)object primary:(NSString *)priKey{
    NSString *tableName=NSStringFromClass([object class]);
    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    if ([self createTable:tableName withKeys:[dicKeyVaule allKeys]  primaryKey:priKey]) {
        NSMutableArray * keyArr = [NSMutableArray array];
        NSMutableArray * valueArr = [NSMutableArray array];
        for (NSString *strKey in [dicKeyVaule allKeys]) {
            [keyArr addObject:strKey];
            [valueArr addObject:[NSString stringWithFormat:@"'%@'",dicKeyVaule[strKey]]];
        }
        return [self shInsertTable:tableName setKey:[keyArr componentsJoinedByString:@","] setValue:[valueArr componentsJoinedByString:@","]];
    }
    return NO;
}
+(BOOL)shInsertTable:(NSString *)tableName setKey:(NSString *)setKey setValue:(NSString *)setValue{
    return [self shInsertTable:tableName withSql:[NSString stringWithFormat:@" (%@) VALUES (%@)",setKey,setValue]];
}
+(BOOL)shInsertTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    BOOL flag = NO;
    FMDatabase *db=[JUSQLdb CreatDB:tableName];
    NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@",tableName]];
    [sql appendString:sqlStr];
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

@end
